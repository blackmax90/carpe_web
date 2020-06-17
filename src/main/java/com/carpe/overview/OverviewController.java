package com.carpe.overview;

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
public class OverviewController {
	@Inject
	private OverviewService service;

	@RequestMapping(value = "/overview.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView overviewView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		String caseId = (String) session.getAttribute(Consts.SESSION_CASE_ID);
		String caseName = (String) session.getAttribute(Consts.SESSION_CASE_NAME);
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", caseId);
		
		Map<String, Object> overviewMap = service.selectCaseInfo(paramMap);
		String description = (String) overviewMap.get("description");
		String procStat = String.valueOf(overviewMap.get("process_state"));
		String logtimelineCnt = String.valueOf(overviewMap.get("logtimeline_cnt"));
		String caseUserCnt = String.valueOf(overviewMap.get("case_user_cnt"));
		String evidenceCnt = String.valueOf(overviewMap.get("evidence_cnt"));
		
		List<Map> caseUserList = service.selectCaseUserList(paramMap);
		List<Map> evidenceList = service.selectEvidenceList(paramMap);
		
		model.addAttribute("caseName", caseName);
		model.addAttribute("desc", description);
		model.addAttribute("procStat", procStat);
		model.addAttribute("logtimelineCnt", logtimelineCnt);
		model.addAttribute("caseUserCnt", caseUserCnt);
		model.addAttribute("evidenceCnt", evidenceCnt);
		mav.addObject("caseUserList", caseUserList);
		mav.addObject("evidenceList", evidenceList);
		mav.setViewName("carpe/overview/overview");
		return mav;
	}

}