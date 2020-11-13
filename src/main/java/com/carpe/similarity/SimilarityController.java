package com.carpe.similarity;

import java.io.BufferedReader;
import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

@Controller
public class SimilarityController {
	//@Inject
	//private SimilarityService service;

	@RequestMapping(value = "/similarity.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView similarity(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/similarity/similarity");

		return mav;
	}

  @RequestMapping(value = "/similarity_proc.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView similarityProc(@RequestParam HashMap<String, String> map, @RequestParam(value="path[]") String[] arrPath
      , HttpSession session, HttpServletRequest requst, Model model) throws Exception {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("jsonView");
    int ret = 0;
    String msg = "";
    String target = map.get("target");
    List<String> paramList = new ArrayList<>();
    
    paramList.add("java");
    paramList.add("-jar");
    paramList.add(CarpeConfig.getEvdncSimilarityPath());

		String caseid = (String) session.getAttribute(Consts.SESSION_CASE_ID);
		String evdid = (String) session.getAttribute(Consts.SESSION_EVDNC_ID);
		
		//이부분을 실제 파일 경로로 수정해줘야함
		String filePath = CarpeConfig.getEvdncBaseTmpPath() + "/" + caseid + "/" + evdid;
    
    File sFile = new File(filePath + "/" + target);
    System.out.println("target : " + filePath + "/" + target);
    paramList.add(target);
    
    if (sFile.exists() == false) {
      ret = -1;
      msg = filePath + "/" + target + " 파일을 찾을 수 없습니다.";
      mav.addObject("ret", ret);
      mav.addObject("msg", msg);
      return mav;
    }
    
    for (String path : arrPath) {
      File dFile = new File(filePath + "/" + path);
      System.out.println("path : " + filePath + "/" + path);
      paramList.add(path);

      if (dFile.exists() == false) {
        ret = -1;
        msg = filePath + "/" + path + " 파일을 찾을 수 없습니다.";
        mav.addObject("ret", ret);
        mav.addObject("msg", msg);
        return mav;
      }
    }
    
    Process process = null;
    BufferedReader br = null;
    
    String[] cmd = new String[paramList.size()];
    paramList.toArray(cmd);
    
    process = Runtime.getRuntime().exec(cmd);
    StringBuffer stdMsg = new StringBuffer();
    // 스레드로 inputStream 버퍼 비우기
    ProcessOutputThread o = new ProcessOutputThread(process.getInputStream(), stdMsg);
    o.start();

    StringBuffer errMsg = new StringBuffer();
    // 스레드로 errorStream 버퍼 비우기
    o = new ProcessOutputThread(process.getErrorStream(), errMsg);
    o.start();

    // 수행종료시까지 대기
    process.waitFor();
    process.destroy();
    
    String std = stdMsg.toString();
    String err = errMsg.toString();

    System.out.println("std msg : " + std);
    System.out.println("srr msg : " + err);
    
    if (std == null || std.equals("-1") == true) {
      ret = -1;
      msg = "유사도 비교에 실패하였습니다.";
      mav.addObject("ret", ret);
      mav.addObject("msg", msg);
      return mav;
    }
    
    List<Map<String, Object>> results = new ArrayList<>();
    String[] arrRs = std.split(",");
    int i = 0;

    for (String path : arrPath) {
      Map<String, Object> rsMap = new HashMap<>();
      rsMap.put("name", new File(path).getName());
      rsMap.put("path", path);
      rsMap.put("value", arrRs[i]);
      results.add(rsMap);
      i++;
    }

    mav.addObject("targetName", new File(target).getName());
    mav.addObject("targetPath", target);
    mav.addObject("result", results);
    mav.addObject("ret", ret);
    mav.addObject("msg", msg);

    return mav;
  }
}
