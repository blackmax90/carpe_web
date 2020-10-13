package com.carpe.recyclebin;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
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

import com.carpe.common.CommonUtil;
import com.carpe.common.Consts;

@Controller
public class RecyclebinController {
	@Inject
	private RecyclebinService service;

	@RequestMapping(value = "/recyclebin/recyclebin.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView recyclebin(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		String selYear = map.get("selYear");
		
		if (CommonUtil.empty(selYear)) {
			Calendar cal = Calendar.getInstance();
			selYear = cal.get(Calendar.YEAR) + "";
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		
		List<Map> yearList = service.selectYearList(paramMap);
		
		if (yearList.size() == 0) {
		  HashMap<String, String> tmpHm = new HashMap<>();
		  tmpHm.put("year", selYear);
		  yearList.add(tmpHm);
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("selYear", selYear);
		mav.addObject("yearList", yearList);
		
		mav.setViewName("carpe/recyclebin/recyclebin_year");

		return mav;
	}

	@RequestMapping(value = "/recyclebin/recyclebinYearList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView recyclebinYearList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("searchDate", map.get("year"));

		List<Map> list = service.selectRecyclebinYearList(paramMap);

		mav.addObject("list", list);

		return mav;
	}

	@RequestMapping(value = "/recyclebin/recyclebinMonth.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView recyclebinMonth(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		String selYear = map.get("selYear");
		String selMonth = map.get("selMonth");
		Calendar cal = Calendar.getInstance();
		
		if (CommonUtil.empty(selYear)) {
			selYear = cal.get(Calendar.YEAR) + "";
		}

		if (CommonUtil.empty(selMonth)) {
			int month = cal.get(Calendar.MONTH) + 1;
			
			if (month < 10) {
				selMonth = "0" + month;
			} else {
				selMonth = month + "";
			}
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("selYear", selYear);
		mav.addObject("selMonth", selMonth);
		
		mav.setViewName("carpe/recyclebin/recyclebin_month");

		return mav;
	}

	@RequestMapping(value = "/recyclebin/recyclebinMonthList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView recyclebinMonthList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("searchDate", map.get("year") + "-" + map.get("month"));

		List<Map> list = service.selectRecyclebinMonthList(paramMap);

		mav.addObject("list", list);

		return mav;
	}

	@RequestMapping(value = "/recyclebin/recyclebinDay.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView recyclebinDay(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		String selYear = map.get("selYear");
		String selMonth = map.get("selMonth");
		String selDay = map.get("selDay");
		Calendar cal = Calendar.getInstance();
		
		if (CommonUtil.empty(selYear)) {
			selYear = cal.get(Calendar.YEAR) + "";
		}

		if (CommonUtil.empty(selMonth)) {
			int month = cal.get(Calendar.MONTH) + 1;
			
			if (month < 10) {
				selMonth = "0" + month;
			} else {
				selMonth = month + "";
			}
		}

		if (CommonUtil.empty(selDay)) {
			selDay = cal.get(Calendar.DATE) + "";
		}
		
		cal.set(Integer.parseInt(selYear), Integer.parseInt(selMonth), 1);
		cal.add(Calendar.DATE, -1);
		
		int lastDay = cal.get(Calendar.DATE);

		ModelAndView mav = new ModelAndView();
		mav.addObject("selYear", selYear);
		mav.addObject("selMonth", selMonth);
		mav.addObject("selDay", selDay);
		mav.addObject("lastDay", lastDay);
		
		mav.setViewName("carpe/recyclebin/recyclebin_day");

		return mav;
	}

	@RequestMapping(value = "/recyclebin/recyclebinDayList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView recyclebinDayList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("searchDate", map.get("year") + "-" + map.get("month") + "-" + map.get("day"));

		List<Map> list = service.selectRecyclebinDayList(paramMap);

		mav.addObject("list", list);

		return mav;
	}

	@RequestMapping(value = "/recyclebin/recyclebinHour.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView recyclebinHour(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		String selYear = map.get("selYear");
		String selMonth = map.get("selMonth");
		String selDay = map.get("selDay");
		String selHour = map.get("selHour");
		Calendar cal = Calendar.getInstance();
		
		if (CommonUtil.empty(selYear)) {
			selYear = cal.get(Calendar.YEAR) + "";
		}

		if (CommonUtil.empty(selMonth)) {
			int month = cal.get(Calendar.MONTH) + 1;
			
			if (month < 10) {
				selMonth = "0" + month;
			} else {
				selMonth = month + "";
			}
		}

		if (CommonUtil.empty(selDay)) {
			selDay = cal.get(Calendar.DATE) + "";
		}

		if (CommonUtil.empty(selHour)) {
			int hour = cal.get(Calendar.HOUR);

			if (hour < 10) {
				selHour = "0" + hour;
			} else {
				selHour = hour + "";
			}
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("selYear", selYear);
		mav.addObject("selMonth", selMonth);
		mav.addObject("selDay", selDay);
		mav.addObject("selHour", selHour);
		
		mav.setViewName("carpe/recyclebin/recyclebin_hour");

		return mav;
	}

	@RequestMapping(value = "/recyclebin/recyclebinHourList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView recyclebinHourList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("searchDate", map.get("year") + "-" + map.get("month") + "-" + map.get("day") + " " + map.get("hour"));

		List<Map> list = service.selectRecyclebinHourList(paramMap);

		mav.addObject("list", list);

		return mav;
	}

	@RequestMapping(value = "/recyclebin/recyclebinList.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView recyclebinList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		String sdate = map.get("date");
		
		if (CommonUtil.empty(sdate)) {
			return mav;
		}

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = df.parse(sdate);
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MINUTE, 5);
		String edate = df.format(cal.getTime());

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("sdate", sdate);
		paramMap.put("edate", edate);

		List<Map> list = service.selectRecyclebinList(paramMap);
		
		for (Map data : list) {
			String size = (String) data.get("size");
			
			if (CommonUtil.empty(size)) {
				size = "0";
			}

			long lSize = Long.parseLong(size);
			
			data.put("size", CommonUtil.getFileSize(lSize));
		}

		mav.addObject("list", list);

		return mav;
	}
}