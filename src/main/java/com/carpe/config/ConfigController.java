package com.carpe.config;

import java.util.ArrayList;
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
public class ConfigController {
	@Inject
	private ConfigService service;

	@RequestMapping(value = "/config/config.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView configView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/config/config");

		return mav;
	}

	@RequestMapping(value = "/config/user_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getUserList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("negrade", String.valueOf(Consts.ADMIN_GRADE));
		
		List<Map> list = service.selectUserList(paramMap);
		mav.addObject("list", list);

		return mav;
	}

	@RequestMapping(value = "/config/case_user_auth_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getCaseUserAuthList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("id", map.get("id"));
		
		List<Map> list = service.selectCaseUserAuthList(paramMap);
		mav.addObject("list", list);

		return mav;
	}

	@RequestMapping(value = "/config/case_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getCaseList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		
		if (map.get("currentPage") == null && map.get("pageSize") == null) {
			mav.addObject("totalcount", 0);
			mav.addObject("list", new ArrayList());
			return mav;
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("id", map.get("id"));
		
		try {
			long pageSize = Long.parseLong((String) map.get("pageSize"));
			paramMap.put("pageSize", pageSize);
			long currentPage = Long.parseLong((String) map.get("currentPage"));
			paramMap.put("offset", (currentPage - 1) * pageSize);
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("totalcount", 0);
			return mav;
		}
		
		List<Map> caseList = service.selectCaseList(paramMap);
		int totalCnt = ((Long) service.selectCaseListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", caseList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

	@RequestMapping(value = "/config/insert_user_auth.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView insertCaseUserAuth(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		String msg = "";
		
		String id = map.get("id");
		String caseidList = map.get("caseidList");
		
		int ret = service.insertCaseUserAuth(id, caseidList);
		
		if (ret != 0) {
			msg = "User Case 추가에 실패하였습니다.";
		}

		mav.addObject("ret", ret);
		mav.addObject("msg", msg);

		return mav;
	}

	@RequestMapping(value = "/config/delete_user_auth.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView deleteCaseUserAuth(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		String msg = "";
		
		String id = map.get("id");
		String caseidList = map.get("caseidList");
		
		int ret = service.deleteCaseUserAuth(id, caseidList);
		
		if (ret != 0) {
			msg = "User Case 삭제에 실패하였습니다.";
		}

		mav.addObject("ret", ret);
		mav.addObject("msg", msg);

		return mav;
	}
}