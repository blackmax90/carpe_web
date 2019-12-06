package com.carpe.carving;

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
public class CarvingController {
	@Inject
	private CarvingService service;

	@RequestMapping(value = "/carving.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView carvingView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		// model.addAttribute(Consts.SESSION_CASE_NAME,
		// session.getAttribute(Consts.SESSION_CASE_NAME));
		mav.setViewName("carpe/carving/carving");

		return mav;
	}

	@RequestMapping(value = "/carving_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getCarvingList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		if (map.get("currentPage") == null && map.get("pageSize") == null) {
			mav.addObject("totalcount", 0);
			mav.addObject("list", new ArrayList());
			return mav;
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
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
		
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		
		List<Map> carvingList = service.selectCarvingList(paramMap);
		int totalCnt = ((Long) service.selectCarvingListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", carvingList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

}