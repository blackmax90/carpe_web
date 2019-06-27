package com.carpe.artifact;

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
public class ArtifactController {
	@Inject
	private ArtifactService service;

	@RequestMapping(value = "/artifact.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView artifactView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/artifact/artifact");

		return mav;
	}

	private void addArtifactTreeNode(List list, String name, boolean dataExists, boolean forceSelect, List subList) {
		Map data = new HashMap();
		data.put("label", name);

		Map value = new HashMap();
		value.put("artifact", name);
		value.put("data_exists", dataExists);
		value.put("force_select", forceSelect);

		if (subList != null) {
			value.put("sub_exists", true);
			data.put("items", subList);
		} else {
			value.put("sub_exists", false);
		}

		data.put("value", value);

		list.add(data);
	}

	@RequestMapping(value = "/artifact_tree_node.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getArtifactTreeNode(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session, Model model) throws Exception {
		List subList = new ArrayList();
		addArtifactTreeNode(subList, "Overview", true, true, null);

		List list = new ArrayList();
		addArtifactTreeNode(list, "System Log", false, false, subList);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("jsonView");

		return mav;
	}

	@RequestMapping(value = "/system_log_overview.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getSystemLogOverview(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session, Model model)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		if (map.get("currentPage") == null && map.get("pageSize") == null) {
			mav.addObject("totalcount", 0);
			mav.addObject("list", new ArrayList());
			return mav;
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("evd_id", session.getAttribute(Consts.SESSION_EVDNC_ID));

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

		List<Map> systemLogOverviewList = service.selectSystemLogOverviewList(paramMap);
		int totalCnt = ((Long) service.selectSystemLogOverviewListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", systemLogOverviewList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}


}