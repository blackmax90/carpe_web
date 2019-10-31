package com.carpe.usage;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.carpe.common.CarpeConfig;
import com.carpe.common.Consts;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

@Controller
public class UsageController {
	@Inject
	private UsageService service;

	@RequestMapping(value = "/usage.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView usageView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

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
		mav.addObject("month", map.get("day"));
		return mav;
	}
	
	@RequestMapping(value = "/usage_year_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getUsageYearList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
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
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("year", map.get("year"));
		paramMap.put("month", map.get("month"));
		
		List<Map> usageList = service.selectUsageMonthList(paramMap);
		
		mav.addObject("list", usageList);
		
		return mav;
	}
}