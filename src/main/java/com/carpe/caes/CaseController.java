package com.carpe.caes;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.carpe.common.CarpeConfig;
import com.carpe.common.Consts;
import com.carpe.login.UserVO;

@Controller
public class CaseController {

  @Inject
  private CaseService service;

  @RequestMapping(value = "/case.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView caseView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();

    session.removeAttribute(Consts.SESSION_CASE_ID);
    session.removeAttribute(Consts.SESSION_CASE_NAME);

    mav.setViewName("carpe/case/case");
    return mav;
  }

  @RequestMapping(value = "/map.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView mapView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();

    mav.setViewName("carpe/case/map");
    return mav;
  }

  @RequestMapping(value = "/case_list.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView getCaseList(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");

    if (map.get("currentPage") == null && map.get("pageSize") == null) {
      mav.addObject("totalcount", 0);
      mav.addObject("list", new ArrayList());
      return mav;
    }
    
    Map<String, Object> paramMap = new HashMap<String, Object>();
    UserVO userInfo = (UserVO) session.getAttribute("userInfo");
    
    if (userInfo.getGrade() != Consts.ADMIN_GRADE) {
      paramMap.put("id", userInfo.getId());
    }
    
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

  /**
   * Main 페이지 Case 선택
   * @param map
   * @param session
   * @param requst
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/select_case.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView selectCase(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();

    String caseId = map.get("id");
    String caseName = map.get("name");
    
    //case 권한 체크
    UserVO userInfo = (UserVO) session.getAttribute("userInfo");

    if (userInfo.getGrade() != Consts.ADMIN_GRADE) {
    	Map<String, Object> paramMap = new HashMap<String, Object>();
    	paramMap.put("id", userInfo.getId());
    	paramMap.put("case_id", caseId);

    	Map rsMap = service.selectCaseUserAuthCount(paramMap);
    	int cnt = Integer.parseInt(String.valueOf(rsMap.get("cnt")));

    	if (cnt == 0) {
    		mav.setViewName("forward:/login.do");
    		return mav;
    	}
    }
    
    //초기 Evidence 셋팅
    Map<String, Object> paramMap = new HashMap<>();
    paramMap.put("case_id", caseId);
    List<Map> evdncList = service.getEvidenceList(paramMap);
    String evdncId = "";
    String evdncName = "";
    
    if (evdncList != null && evdncList.size() > 0) {
      evdncId = evdncList.get(0).get("evd_id") + "";
      evdncName = evdncList.get(0).get("evd_name") + "";
    }
    
    session.setAttribute(Consts.SESSION_CASE_ID, caseId);
    session.setAttribute(Consts.SESSION_CASE_NAME, caseName);
    session.setAttribute(Consts.SESSION_EVDNC_ID, evdncId);
    session.setAttribute(Consts.SESSION_EVDNC_NAME, evdncName);

    mav.setViewName("forward:/overview.do");

    return mav;
  }

  /**
   * Case 추가
   * @param map
   * @param session
   * @param requst
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/add_case.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView addcase(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");

    UserVO userInfo = (UserVO) session.getAttribute("userInfo");
    
    if (userInfo.getGrade() != Consts.ADMIN_GRADE) {
    	mav.addObject("affected", 0);
    	return mav;
    }

    Map<String, Object> paramMap = new HashMap<String, Object>();

    String caseId = CarpeConfig.getCaseCode() + UUID.randomUUID().toString().replace("-", "");

    paramMap.put("id", caseId);
    paramMap.put("name", map.get("name"));
    paramMap.put("admin", map.get("admin"));
    paramMap.put("timezone", map.get("timezone"));
    paramMap.put("desc", map.get("desc"));

    int affected = 0;
    try {
      affected = service.insertCase(paramMap);
    } catch (Exception e) {
      e.printStackTrace();
    }

    mav.addObject("affected", affected);

    return mav;
  }
  
  /**
   * Case 삭제
   * @param map
   * @param session
   * @param requst
   * @param model
   * @return
   * @throws Exception
   */
  @RequestMapping(value = "/delete_case.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView delCase(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");

    UserVO userInfo = (UserVO) session.getAttribute("userInfo");
    
    if (userInfo.getGrade() != Consts.ADMIN_GRADE) {
    	mav.addObject("affected", 0);
    	return mav;
    }

    Map<String, Object> paramMap = new HashMap<String, Object>();

    String delimiter = ",";
    List<String> split = Arrays.asList(map.get("caseId").split(delimiter));
    ArrayList<String> caseList = new ArrayList<String>();
    caseList.addAll(split);
    paramMap.put("caseList", caseList);
    paramMap.put("isdelete", "Y");


    int affected = 0;
    try {
      // case list delete
      affected = service.updateCaseDeleteFlag(paramMap);

      if (affected > 0) {
      	service.deleteCaseUserAuth(paramMap);
      }
    } catch (Exception e) {
      e.printStackTrace();
    }

    mav.addObject("affected", affected);

    return mav;
  }
}