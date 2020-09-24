package com.carpe.timeline;

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
public class TimelineController {
	@Inject
	private TimelineService service;

	@RequestMapping(value = "/timeline/timeline_chart.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView timelineChart(@RequestParam HashMap<String, String> map, HttpSession session,
			HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/timeline/timeline");

		return mav;
	}

	@RequestMapping(value = "/timeline/timeline_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getTimelineList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("sdate", map.get("sdate"));
		paramMap.put("edate", map.get("edate"));
		List<Map> tlList = service.selectTimelineList(paramMap);

		mav.addObject("list", tlList);

		return mav;
	}
}