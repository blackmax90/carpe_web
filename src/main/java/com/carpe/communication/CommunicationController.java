package com.carpe.communication;

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
public class CommunicationController {
	@Inject
	private CommunicationService service;

	@RequestMapping(value = "/communication.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView communicationView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		Map<String, Object> paramMap = new HashMap<String, Object>();
		//int year = Calendar.getInstance().get(Calendar.YEAR);
		int year = 2019;
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		mav.setViewName("carpe/communication/communication");
		if (map.get("year") != null && !"".equals(map.get("year"))) {
			mav.addObject("year", map.get("year"));
			paramMap.put("year", map.get("year"));
		} else {
			mav.addObject("year", year);
			paramMap.put("year", year);
		}
		//int topCnt = ((Long) service.selectCallStatCount(paramMap).get("cnt")).intValue();
		//mav.addObject("topCnt", topCnt);

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

		List<Map> gpsList = service.selectCallStat(paramMap);
		
		mav.addObject("list", gpsList);
		mav.addObject("totalcount", gpsList.size());
		
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
		
		List<Map> gpsList = service.selectSmsStat(paramMap);
		
		mav.addObject("list", gpsList);
		mav.addObject("totalcount", gpsList.size());
		
		return mav;
	}
}