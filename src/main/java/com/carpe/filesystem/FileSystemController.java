package com.carpe.filesystem;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
public class FileSystemController {

	@Inject
	private FileSystemService service;

	@RequestMapping(value = "/filesystem.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView filesystemView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/filesystem/filesystem");

		return mav;
	}

	@RequestMapping(value = "/dir_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getDirList(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session, Model model) throws Exception {
		long parentId = Consts.TREE_ROOT_ID;
		if (map.get("id") != null) {
			if (!map.get("id").equals("0"))	{
				try {
					parentId = Long.parseLong((String) map.get("id"));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("id", parentId);
		paramMap.put("evd_id", session.getAttribute(Consts.SESSION_EVDNC_ID));

		List<Map> dirList = service.selectDirList(paramMap);

		List list = new ArrayList();
		for (int i = 0; i < dirList.size(); i++) {
			Map data = new HashMap();
			data.put("label", dirList.get(i).get("name"));
			data.put("icon", Consts.FOLDER_CLOSED_IMAGE);
			data.put("iconsize", "18");

			Map value = new HashMap();
			value.put("id", dirList.get(i).get("id"));
			value.put("isLoaded", false);

			data.put("value", value);

			List loading = new ArrayList();
			Map dummy = new HashMap();
			dummy.put("label", "Loading...");
			loading.add(dummy);

			data.put("items", loading);

			list.add(data);
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("jsonView");

		return mav;
	}

	@RequestMapping(value = "/file_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getFileList(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		if (map.get("id") == null) {
			mav.addObject("totalcount", 0);
			return mav;
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();

		try {
			long parentId = Long.parseLong((String) map.get("id"));
			paramMap.put("id", parentId);
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("totalcount", 0);
			return mav;
		}

		paramMap.put("evd_id", session.getAttribute(Consts.SESSION_EVDNC_ID));

		List<Map> fileList = service.selectFileList(paramMap);

		mav.addObject("list", fileList);
		mav.addObject("totalcount", fileList.size());

		return mav;
	}

	@RequestMapping(value = "/filename_wordcloud.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView filesystemWordCloudView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/filesystem/filename_wordcloud");

		return mav;
	}

	@RequestMapping(value = "/date_treemap.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView dateTreeMapView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.addObject("id", map.get("id"));
		mav.setViewName("carpe/filesystem/date_treemap");

		return mav;
	}

	@RequestMapping(value = "/get_date_treemap.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getDateTreeMap(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		if (map.get("id") == null) {
			mav.addObject("totalcount", 0);
			return mav;
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();

		try {
			long parentId = Long.parseLong((String) map.get("id"));
			paramMap.put("id", parentId);
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("totalcount", 0);
			return mav;
		}

		List<Map> list = service.selectDateTreeMap(paramMap);

		mav.addObject("list", list);
		mav.addObject("totalcount", list.size());

		return mav;
	}

	@RequestMapping(value = "/hexview.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView hewview(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/filesystem/hexview/hexviewer");

		return mav;
	}
}