package com.carpe.usage;

import java.util.ArrayList;
import java.util.Arrays;
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

import com.carpe.common.CommonUtil;
import com.carpe.common.Consts;

@Controller
public class UsageController {
  @Inject
  private UsageService service;

  @RequestMapping(value = "/usage.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView usageView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();

		if (map.get("evd_id") != null && map.get("evd_id") != "") {
			session.setAttribute(Consts.SESSION_EVDNC_ID, map.get("evd_id"));
			session.setAttribute(Consts.SESSION_EVDNC_NAME, map.get("evd_name"));
		}

		String caseid = (String) session.getAttribute(Consts.SESSION_CASE_ID);

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", caseid);
    List list = service.selectEvdncList(paramMap);
    
    mav.addObject("evdList", list);
    mav.setViewName("carpe/usage/usage");

    return mav;
  }
  
  @RequestMapping(value = "/usage_month.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView usageMonthView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("carpe/usage/usage_month");
    mav.addObject("year", map.get("year"));
    mav.addObject("month", map.get("month"));
    return mav;
  }
  
  @RequestMapping(value = "/usage_day.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView usageDayView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("carpe/usage/usage_day");
    mav.addObject("year", map.get("year"));
    mav.addObject("month", map.get("month"));
    mav.addObject("day", map.get("day"));
    return mav;
  }
  
  @RequestMapping(value = "/usage_year_list.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView getUsageYearList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");

    Map<String, Object> paramMap = new HashMap<String, Object>();
    
    paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
    paramMap.put("evd_id", session.getAttribute(Consts.SESSION_EVDNC_ID));

    if (map.get("year") != null && !"".equals(map.get("year"))) {
      String delimiter = ",";
      List<String> split = Arrays.asList(map.get("year").split(delimiter));
      ArrayList<String> yearList = new ArrayList<String>();
      yearList.addAll(split);
      paramMap.put("yearList", yearList);
    }
    List<Map> usageList = service.selectUsageYearList(paramMap);

    mav.addObject("list", usageList);

    return mav;
  }
  
  @RequestMapping(value = "/usage_month_list.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView getUsageMonthList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");
    String year = map.get("year");
    String month = map.get("month");
    
    Map<String, Object> paramMap = new HashMap<String, Object>();
    
    paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
    paramMap.put("evd_id", session.getAttribute(Consts.SESSION_EVDNC_ID));
    paramMap.put("regdate", year + month);
    
    List<Map> usageList = service.selectUsageMonthList(paramMap);
    List<Map> spcdeList = CommonUtil.getSpcdeInfoService(year, month);
    
    mav.addObject("list", usageList);
    mav.addObject("spcdeList", spcdeList);
    
    return mav;
  }
  
  @RequestMapping(value = "/usage_day_list.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView getUsageDayList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");
    
    Map<String, Object> paramMap = new HashMap<String, Object>();
    
    paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
    paramMap.put("evd_id", session.getAttribute(Consts.SESSION_EVDNC_ID));
    paramMap.put("year", map.get("year"));
    paramMap.put("month", map.get("month"));
    paramMap.put("day", map.get("day"));
    paramMap.put("hour", map.get("hour"));
    
    List<Map> usageList = service.selectUsageDayList(paramMap);
    
    mav.addObject("list", usageList);
    
    return mav;
  }

  @RequestMapping(value = "/usage_day_detail_list.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView getUsageDayDetailList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");
    
    Map<String, Object> paramMap = new HashMap<String, Object>();
    
    paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
    paramMap.put("evd_id", session.getAttribute(Consts.SESSION_EVDNC_ID));
    paramMap.put("sdate", map.get("sdate"));
    paramMap.put("edate", map.get("edate"));
    
    int sdate = Integer.parseInt(map.get("sdate").substring(0, 4));
    
    System.out.println(">>> : " + sdate);
    //1970년인 경우 그 이전값도 조회
    if (sdate > 1970) {
      paramMap.put("dateType", 1);
    } else {
      paramMap.put("dateType", 2);
    }
    
    List<Map> detailList = service.selectUsageDayDetailList(paramMap);
    
    mav.addObject("list", detailList);
    
    return mav;
  }
}