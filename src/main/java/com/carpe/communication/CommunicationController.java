package com.carpe.communication;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.carpe.common.CommonUtil;
import com.carpe.common.Consts;
import com.opencsv.CSVWriter;

@Controller
public class CommunicationController {
  @Inject
  private CommunicationService service;

  @RequestMapping(value = "/communication.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView communicationView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();

    Map<String, Object> paramMap = new HashMap<String, Object>();
    String year = map.get("year");
    
    if (CommonUtil.empty(year)) {
        year = Calendar.getInstance().get(Calendar.YEAR) + "";
    }

    paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
    List<Map> yearList = service.selectCommunicationYearList(paramMap);

		if (yearList.size() == 0) {
		  HashMap<String, String> tmpHm = new HashMap<>();
		  tmpHm.put("year", year);
		  yearList.add(tmpHm);
		}

    mav.addObject("year", year);
    mav.addObject("yearList", yearList);
    mav.setViewName("carpe/communication/communication");

    return mav;
  }

  @RequestMapping(value = "/communication_list.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView getCommunicationList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");

    Map<String, Object> paramMap = new HashMap<String, Object>();
    paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
    paramMap.put("year", map.get("year"));
    List<Map> communicationList = service.selectCommunicationList(paramMap);

    mav.addObject("list", communicationList);
    mav.addObject("totalcount", communicationList.size());

    return mav;
  }
  
  @RequestMapping(value = "/communication_call_stat.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView getCallStat(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");
    
    Map<String, Object> paramMap = new HashMap<String, Object>();
    paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
    String year = map.get("year");
    paramMap.put("year", year);
    paramMap.put("in_out", "Outgoing");

    List<Map> list = service.selectCallStat(paramMap);
    
    mav.addObject("list", list);
    mav.addObject("totalcount", list.size());
    
    return mav;
  }
  
  @RequestMapping(value = "/communication_sms_stat.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView getSmsStat(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");
    
    Map<String, Object> paramMap = new HashMap<String, Object>();
    paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
    
    String year = map.get("year");
    paramMap.put("year", year);
    paramMap.put("in_out", "Incoming");
    
    List<Map> list = service.selectCallStat(paramMap);
    
    mav.addObject("list", list);
    mav.addObject("totalcount", list.size());
    
    return mav;
  }

  @RequestMapping(value = "/communication_room_list.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView getCommunicationRoomList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");

    Map<String, Object> paramMap = new HashMap<String, Object>();
    paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
    paramMap.put("number", map.get("number"));
    paramMap.put("sdate", map.get("sdate"));
    paramMap.put("edate", map.get("edate"));
    List<Map> roomList = service.selectCommunicationRoomList(paramMap);

    mav.addObject("list", roomList);

    return mav;
  }

  @RequestMapping(value = "/communication_data_list.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView getCommunicationDataList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");

    Map<String, Object> paramMap = new HashMap<String, Object>();
    paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
    paramMap.put("number", map.get("phoneNumber"));
    paramMap.put("type", map.get("type"));
    paramMap.put("sdata", map.get("sdata"));
    paramMap.put("pageCnt", map.get("pageCnt"));
    List<Map> dataList = service.selectCommunicationDataList(paramMap);

    mav.addObject("list", dataList);

    return mav;
  }

  @RequestMapping(value = "/communication_export.do", method = { RequestMethod.POST })
  public void getCommunicationExport(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, HttpServletResponse response, Model model) throws Exception {
    Map<String, Object> paramMap = new HashMap<String, Object>();
    paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
    paramMap.put("number", map.get("phoneNumber"));
    paramMap.put("type", map.get("type"));
    List<Map> dataList = service.selectCommunicationDataList(paramMap);
    SimpleDateFormat df = new SimpleDateFormat("yyyyMMddhhmmss");
    String fileName = "communication_data_" + df.format(new Date()) + ".csv";

    response.setContentType("text/csv; charset=MS949");
    response.setHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"");
    CSVWriter csvWriter = new CSVWriter(response.getWriter());
    
    String[] keys = {"type", "created_at", "message", "in_out", "phone_number"};
    String[] header = {"종류", "날짜", "내용", "발신번호", "수신번호"};
    csvWriter.writeNext(header);
    
    for (Map data : dataList) {
      String[] buff = new String[keys.length];
      int idx = 0;
      int inOutFlag = 0;  //0 발신, 1 수신

      for (String key : keys) {
        if (key.equals("in_out") == true) {
          if ("Outgoing".equals(data.get(key))) {
            inOutFlag = 0;
          } else {
            inOutFlag = 1;
          }
        } else if (key.equals("phone_number") == true) {
          buff[idx + inOutFlag] = String.valueOf(data.get(key));
        } else {
          buff[idx++] = String.valueOf(data.get(key));
        }
      }

      csvWriter.writeNext(buff);
    }
    
    csvWriter.close();
  }
}