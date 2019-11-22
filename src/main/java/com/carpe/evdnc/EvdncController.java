package com.carpe.evdnc;

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
public class EvdncController {
	@Inject
	private EvdncService service;

	@RequestMapping(value = "/evdnc.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView evdncView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		// model.addAttribute(Consts.SESSION_CASE_NAME,
		// session.getAttribute(Consts.SESSION_CASE_NAME));
		mav.setViewName("carpe/evdnc/evdnc");

		return mav;
	}

	@RequestMapping(value = "/evdnc_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEvdncList(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
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
		
		List<Map> evdncList = service.selectEvdncList(paramMap);
		int totalCnt = ((Long) service.selectEvdncListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", evdncList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

	@RequestMapping(value = "/select_evdnc.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView selectEvdnc(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		String evdncId = map.get("id");
		String evdncName = map.get("name");

		session.setAttribute(Consts.SESSION_EVDNC_ID, evdncId);
		session.setAttribute(Consts.SESSION_EVDNC_NAME, evdncName);

		mav.setViewName("forward:/filesystem.do");

		return mav;
	}

	@RequestMapping(value = "/add_evdnc.do", method = { RequestMethod.POST })
	public ModelAndView fileUpload(Locale locale, @RequestParam HashMap<String, String> map, @RequestParam("evdnc_file") MultipartFile file, HttpSession session, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		if (file.getOriginalFilename().isEmpty()) {
			mav.addObject("msg", "Empty file name.");
			mav.setStatus(HttpStatus.BAD_REQUEST);

			return mav;
		}

		String evdncId = CarpeConfig.getEvdncCode() + UUID.randomUUID().toString().replace("-", "");

		String physicalDir = String.format("%s/%s/%s", CarpeConfig.getEvdncBasePath(), session.getAttribute(Consts.SESSION_CASE_ID), evdncId);
		(new File(physicalDir)).mkdirs();

		String evdncFile = String.format("%s/%s/%s", session.getAttribute(Consts.SESSION_CASE_ID), evdncId, file.getOriginalFilename());
		String evdncTmpPath = String.format("%s/%s", session.getAttribute(Consts.SESSION_CASE_ID), evdncId);

		String evdncName = map.get("newEvdncName");
		String evdncMainType = "image";
		String evdncSubType = map.get("newEvdncSubType");
		String caseId = (String) session.getAttribute(Consts.SESSION_CASE_ID);
		String timezone = "UTC+9";

		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("id", evdncId);
		paramMap.put("path", evdncFile);
		paramMap.put("tmp_path", evdncTmpPath);
		paramMap.put("name", evdncName);
		paramMap.put("main_type", evdncMainType);
		paramMap.put("sub_type", evdncSubType);
		paramMap.put("case_id", caseId);
		paramMap.put("timezone", timezone);

		service.insertEvdnc(paramMap);

		File destFile = new File(String.format("%s/%s", physicalDir, file.getOriginalFilename()));
		file.transferTo(destFile);

		String mqMsg = "{'req_id':'1', 'req_type':'analyze', 'case_id':'" + caseId + "', 'evd_id':'" + evdncId + "', 'options':'vss'}";

		ConnectionFactory factory = new ConnectionFactory();
		factory.setUsername(CarpeConfig.getMqId());
		factory.setPassword(CarpeConfig.getMqPw());
		factory.setHost(CarpeConfig.getMqServer());
		factory.setVirtualHost(CarpeConfig.getMqVhost());
		Connection connection = factory.newConnection();
		Channel channel = connection.createChannel();

		channel.queueDeclare(CarpeConfig.getMqQueue(), true, false, false, null);
		channel.basicPublish("", CarpeConfig.getMqQueue(), null, mqMsg.getBytes("UTF-8"));

		channel.close();
		connection.close();

		mav.addObject("msg", "Add Evidence Complete!");
		mav.setStatus(HttpStatus.OK);

		return mav;
	}

	@RequestMapping(value = "/download_evdnc.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void downloadEvdnc(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, HttpServletResponse response) throws Exception {
		String evdncId = map.get("id");

		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("id", evdncId);

		Map<String, Object> evdncMap = service.selectEvdnc(paramMap);
		String evdncPath = (String) evdncMap.get("evd_path");
		File physicalFile = new File(String.format("%s/%s", CarpeConfig.getEvdncBasePath(), evdncPath));

		BufferedInputStream in = null;
		BufferedOutputStream out = null;

		try {
			response.setContentType("application/x-msdownload");
			response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + URLEncoder.encode(physicalFile.getName(), "UTF-8").replaceAll("\\+", "%20") + "; ");

			in = new BufferedInputStream(new FileInputStream(physicalFile));
			out = new BufferedOutputStream(response.getOutputStream());

			FileCopyUtils.copy(in, out);
			out.flush();
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (Exception ignore) {
				}
			}

			if (out != null) {
				try {
					out.close();
				} catch (Exception ignore) {
				}
			}
		}
	}

	@RequestMapping(value = "/delete_evdnc.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView delEvdnc(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		Map<String, Object> paramMap = new HashMap<String, Object>();

		String delimiter = ",";
		List<String> split = Arrays.asList(map.get("evdId").split(delimiter));
		ArrayList<String> evdncList = new ArrayList<String>();
		evdncList.addAll(split);
		paramMap.put("evdList", evdncList);


		int affected = 0;
		try {
			// evdncList list delete
			affected = service.deleteEvdncList(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
		}

		mav.addObject("affected", affected);
		mav.setViewName("jsonView");

		return mav;
	}
}