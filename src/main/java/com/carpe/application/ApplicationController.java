package com.carpe.application;

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

import com.carpe.common.Consts;

@Controller
public class ApplicationController {
	@Inject
	private ApplicationService service;

	@RequestMapping(value = "/application/application.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView application(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("carpe/application/application");

		return mav;
	}

	@RequestMapping(value = "/application/app_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getApplicationList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		long pageSize = Long.parseLong((String) map.get("pageSize"));
		paramMap.put("pageSize", pageSize);
		long currentPage = Long.parseLong((String) map.get("currentPage"));
		paramMap.put("offset", (currentPage - 1) * pageSize);
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("sdate", map.get("sdate"));
		paramMap.put("edate", map.get("edate"));
		List<Map> appList = service.selectAppHistoryList(paramMap);
		int totalCnt = ((Long) service.selectAppHistoryListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", appList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

	@RequestMapping(value = "/application/app_list_group.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getApplicationListGroup(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("sdate", map.get("sdate"));
		paramMap.put("edate", map.get("edate"));
		List<Map> appList = service.selectAppHistoryListGroup(paramMap);

		mav.addObject("list", appList);

		return mav;
	}
}