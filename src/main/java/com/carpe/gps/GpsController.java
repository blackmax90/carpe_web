package com.carpe.gps;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.carpe.common.CarpeConfig;
import com.carpe.common.CommonUtil;
import com.carpe.common.Consts;

@Controller
public class GpsController {
	@Inject
	private GpsService service;

	@RequestMapping(value = "/gps/gps.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView gpsView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("ncpClientId", CarpeConfig.getNcpClientId());
		mav.setViewName("carpe/gps/gps");

		return mav;
	}

	@RequestMapping(value = "/gps/gps_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getGpsList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));

		List<Map> gpsList = service.selectGpsList(paramMap);

		mav.addObject("list", gpsList);
		mav.addObject("totalcount", gpsList.size());

		return mav;
	}
	
	@RequestMapping(value = "/gps/gps_link_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getGpsLinkList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		map.put("caseid", (String)session.getAttribute(Consts.SESSION_CASE_ID));
		
		Map<String, Object> retMap = service.getDetailPath(map);
		List<Map> gpsList = (List<Map>) retMap.get("list");
		
		if (gpsList == null) {
			gpsList = new ArrayList<>();
		}

		mav.addObject("ret", retMap.get("ret"));
		mav.addObject("msg", retMap.get("msg"));
		mav.addObject("list", gpsList);

		return mav;
	}

	@RequestMapping(value = "/gps/gps_date_count.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getGpsDateCount(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("sdate", map.get("sdate"));
		paramMap.put("edate", map.get("edate"));

		List<Map> gpsList = service.selectGpsDateCount(paramMap);
		
		if (gpsList == null) {
			gpsList = new ArrayList<>();
		}

		mav.addObject("list", gpsList);

		return mav;
	}

	@RequestMapping(value = "/gps/file_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getFileList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		String regdate = map.get("regdate");
		
		if (CommonUtil.empty(regdate)) {
			mav.addObject("list", new ArrayList<Map>());
			return mav;
		}

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = df.parse(regdate);
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.HOUR, -1);
		String sdate = df.format(cal.getTime());
		cal.add(Calendar.HOUR, 2);
		String edate = df.format(cal.getTime());

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("sdate", sdate);
		paramMap.put("edate", edate);

		List<Map> fileList = service.selectGpsFileList(paramMap);

		mav.addObject("list", fileList);

		return mav;
	}

	@RequestMapping(value = "/gps/communication_room_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getCommunicationRoomList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("sdate", map.get("sdate"));
		paramMap.put("edate", map.get("edate"));
		List<Map> roomList = service.selectCommunicationRoomList(paramMap);

		mav.addObject("list", roomList);

		return mav;
	}

	@RequestMapping(value = "/gps/communication_data_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getCommunicationDataList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
    paramMap.put("number", map.get("phoneNumber"));
    paramMap.put("chatroom_id", map.get("chatroomId"));
    paramMap.put("type", map.get("type"));
    paramMap.put("sdata", map.get("sdata"));
    paramMap.put("pageCnt", map.get("pageCnt"));
		List<Map> dataList = service.selectCommunicationDataList(paramMap);

		mav.addObject("list", dataList);

		return mav;
	}
}