package com.carpe.report;

import java.text.SimpleDateFormat;
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
public class ReportController {
  @Inject
  private ReportService service;

  @RequestMapping(value = "/report.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView report(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();

		String caseid = (String) session.getAttribute(Consts.SESSION_CASE_ID);
		String caseName = (String) session.getAttribute(Consts.SESSION_CASE_NAME);

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", caseid);

		Map<String, Object> overviewMap = service.getCaseInfo(paramMap);
		String administrator = (String) overviewMap.get("administrator");
		String createDate = (String) overviewMap.get("create_date");
		String description = (String) overviewMap.get("description");
		String procStat = String.valueOf(overviewMap.get("process_state"));
		String logtimelineCnt = String.valueOf(overviewMap.get("logtimeline_cnt"));
		String caseUserCnt = String.valueOf(overviewMap.get("case_user_cnt"));
		String evidenceCnt = String.valueOf(overviewMap.get("evidence_cnt"));

		model.addAttribute("caseName", caseName);
		model.addAttribute("administrator", administrator);
		model.addAttribute("createDate", createDate);
		model.addAttribute("desc", description);
		model.addAttribute("procStat", procStat);
		model.addAttribute("logtimelineCnt", logtimelineCnt);
		model.addAttribute("caseUserCnt", caseUserCnt);
		model.addAttribute("evidenceCnt", evidenceCnt);
    mav.setViewName("carpe/report/report");

    return mav;
  }

  @RequestMapping(value = "/report_view.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView reportView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();

		String caseid = (String) session.getAttribute(Consts.SESSION_CASE_ID);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String reportTime = format.format(System.currentTimeMillis());
    
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", caseid);

		Map<String, Object> caseInfoMap = service.selectCaseInfo(paramMap);

		List<Map> evdncList = service.getEvdncInfo(paramMap);
    
		model.addAttribute("reportTime", reportTime);
		model.addAttribute("caseInfo", caseInfoMap);
		model.addAttribute("evdncList", evdncList);
    mav.setViewName("carpe/report/report_view");

    return mav;
  }
}