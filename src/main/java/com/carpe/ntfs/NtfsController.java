package com.carpe.ntfs;

import java.util.ArrayList;
import java.util.Calendar;
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
public class NtfsController {
	@Inject
	private NtfsService service;

	@RequestMapping(value = "/ntfs/ntfsloghistory.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView ntfsHistory(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {

		ModelAndView mav = new ModelAndView();

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));

		List<Map> yearList = service.selectNtfsHistoryYearList(paramMap);

		if (yearList.size() == 0) {
		  HashMap<String, String> tmpHm = new HashMap<>();
		  tmpHm.put("year", Calendar.getInstance().get(Calendar.YEAR) + "");
		  yearList.add(tmpHm);
		}

		mav.addObject("yearList", yearList);
		mav.setViewName("carpe/ntfs/ntfsloghistory");

		return mav;
	}

	/**
	 * NTFS Log History Count List
	 * 
	 * @param map
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ntfs/ntfs_history_count_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getNtfsHistoryCountList(@RequestParam HashMap<String, String> map, HttpSession session, Model model) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("timestamp", map.get("timestamp"));
		paramMap.put("reason", map.get("reason"));
		
		List<Map> logList = service.selectNtfsHistoryCountList(paramMap);
		Map<String, Long> list = new HashMap<>();

		for (Map logMap : logList) {
			String timestamp = (String) logMap.get("timestamp");
			long timestampcnt = (long) logMap.get("timestampcnt");
			list.put(timestamp, timestampcnt);
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("jsonView");

		return mav;
	}

	/**
	 * NTFS Log History List
	 * 
	 * @param map
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/ntfs/ntfs_history_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getNtfsHistoryList(@RequestParam HashMap<String, String> map, HttpSession session, Model model) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("timestamp", map.get("timestamp"));
		paramMap.put("reason", map.get("reason"));
		
		List<Map> logList = service.selectNtfsHistoryList(paramMap);

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", logList);
		mav.setViewName("jsonView");

		return mav;
	}
}