package com.carpe.mft;

import java.math.BigDecimal;
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

import com.carpe.common.CommonUtil;
import com.carpe.common.Consts;

@Controller
public class MftController {
	@Inject
	private MftService service;

	@RequestMapping(value = "/mft/mfthistory.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView mftHistory(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {

		ModelAndView mav = new ModelAndView();
		mav.setViewName("carpe/mft/mfthistory");

		return mav;
	}

	/**
	 * Mft History Directory List
	 * 
	 * @param map
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mft/mfthistory_dir_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getMftHistoryDirList(@RequestParam HashMap<String, String> map, HttpSession session, Model model) throws Exception {
		List list = new ArrayList();

		String caseid = (String) session.getAttribute(Consts.SESSION_CASE_ID);
		String evdid = map.get("evd_id");
		String evdName = map.get("evd_name");
		String parid = map.get("par_id");
		String id = map.get("id");
		String parentid = map.get("parent_id");
		String dirType = map.get("dirType");

		try {
			if (evdid == null || evdid.equals("") == true) {
				// evdnc list
				list = service.getEvdncList(caseid);
			} else if (id != null && id != "") {
				// file directory list
				list = service.getFileDirList(caseid, evdid, evdName, dirType, parid, parentid);
			} else {
				// partion directory list
				list = service.getParDirList(evdid, evdName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("jsonView");

		return mav;
	}

	/**
	 * MFT History List
	 * 
	 * @param map
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mft/mfthistory_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getMftHistoryList(@RequestParam HashMap<String, String> map, HttpSession session, Model model) throws Exception {
		List list = new ArrayList();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
		paramMap.put("evd_id", map.get("evd_id"));
		paramMap.put("par_id", map.get("par_id"));
		paramMap.put("parent_id", map.get("parent_id"));
		paramMap.put("dir_type", map.get("dirType"));
		
		List<Map> fileList = service.selectMftHistoryList(paramMap);

		for (Map fileMap : fileList) {
			String dirType = String.valueOf(fileMap.get("dir_type"));
			String ext = String.valueOf(fileMap.get("extension")).toLowerCase();
			String dirTypeStr = "";
			
			if ("3".equals(dirType) == true) {
				dirTypeStr = "Directory";
			} else {
				dirTypeStr = ext;
			}
			
			Map data = new HashMap();
			data.put("name", fileMap.get("name") + "|" + dirTypeStr);
			data.put("size", fileMap.get("size"));
			data.put("file_id", fileMap.get("file_id"));
			data.put("parent_id", fileMap.get("parent_id"));
			data.put("dir_type", fileMap.get("dir_type"));
			data.put("dir_type_str", dirTypeStr);
			data.put("extension", fileMap.get("extension"));
			data.put("ctime", fileMap.get("ctime"));
			data.put("mtime", fileMap.get("mtime"));
			list.add(data);
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("jsonView");

		return mav;
	}

	/**
	 * Mft History Directory List
	 * 
	 * @param map
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/mft/mfthistory_copyrate.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getMftHistoryCopyRate(@RequestParam HashMap<String, String> map, HttpSession session, Model model) throws Exception {
		String color = "";
		String filename = "";
		String label = "";
		boolean isExpanded = Boolean.parseBoolean((String) map.get("isExpanded"));
		
		if (map.get("color") != null) {
			color = (String) map.get("color");
		}

		if (map.get("filename") != null) {
			filename = (String) map.get("filename");
		}
		
		if (CommonUtil.empty(color) == true || CommonUtil.empty(filename) == true) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("case_id", session.getAttribute(Consts.SESSION_CASE_ID));
			paramMap.put("evd_id", map.get("evd_id"));
			paramMap.put("par_id", map.get("par_id"));
			paramMap.put("file_id", map.get("file_id"));
			paramMap.put("dir_type", map.get("dirType"));

			Map fileMap = service.selectMftHistoryCopyRate(paramMap);
			
			if (fileMap != null) {
			  filename = (String) fileMap.get("name");
			  int copyrate = ((BigDecimal) fileMap.get("copyrate")).intValue();
			  int r = 0;
			  int g = 0;
			  int b = 0;

			  if (copyrate <= 33) {
			    r = 0;
			    g = (int) (copyrate * ((float) 255 / 33));
			    b = 255 - copyrate * (255 / 33);
			  } else if (copyrate <= 66) {
			    r = (int) ((copyrate - 33) * ((float) 255 / 33));
			    g = 255;
			    b = 0;
			  } else {
			    r = 255;
			    g = (int) ((100 - copyrate) * ((float) 255 / 34));
			    b = 0;
			  }

			  color = String.format("%02X%02X%02X", r, g, b);
			}
		}

		String svg = "";
		
		if (CommonUtil.notEmpty(color)) {
		  if (isExpanded == true) {
		    svg += " <?xml version='1.0' encoding='UTF-8'?> ";
		    svg += " <svg width='22' height='18' viewBox='0 0 22 18' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'> ";
		    svg += "     <g id='ico_folder_open' style='fill: #" + color + "'> ";
		    svg += "         <path d='M8.46442367,0 C8.79724472,0 9.1082547,0.165583165 9.29406675,0.441705843 L10.867008,2.77914708 C10.959914,2.91720842 11.115419,3 11.2818295,3 L18.0002463,3 C18.5130821,2.99992377 18.9357535,3.38595851 18.9935186,3.88329681 L19.0001642,4 L19.0001642,7 L20.9995642,7 C21.5518489,7 21.9995642,7.44771525 21.9995642,8 C21.9995642,8.14336536 21.9687378,8.2850547 21.909175,8.41546139 L17.7984582,17.4154614 C17.6358119,17.771559 17.2803309,18 16.8888473,18 L1.0044887,18 C0.726903074,18 0.4757338,17.8868981 0.294550163,17.7042637 C0.139056838,17.5501199 0.0335511164,17.3431808 0.00672773133,17.1122403 L1.36867786e-05,16.9956055 L1.36867786e-05,1 C0.000253860829,0.447720595 0.447966897,0 1.0002463,0 L8.46442367,0 Z M19.1102985,9 L6.31685614,9 C6.12340537,9 5.94731213,9.11159244 5.86471841,9.28652523 L2.8634137,15.6432626 C2.80446426,15.768117 2.85789079,15.9171194 2.98274517,15.9760689 C3.0161215,15.9918273 3.05257308,16 3.08948256,16 L15.9687294,16 C16.164187,16 16.3417241,15.886107 16.4232082,15.7084443 L19.3375379,9.35422213 C19.3950982,9.22872127 19.3400215,9.08032089 19.2145207,9.02276059 C19.1818221,9.00776359 19.1462722,9 19.1102985,9 Z M7.66579907,2 L2.5,2 C2.22386983,2 1.99996874,2.22386983 1.99996874,2.5 L1.99996874,12.438 L4.23232977,7.58238881 C4.39546018,7.22745459 4.75032811,7 5.1409556,7 L17,7 L17,5.5 C17,5.22385763 16.7761424,5 16.5,5 L10.4832197,5 C10.1504002,5 9.83939145,4.83441836 9.65357906,4.55829777 L8.08061939,2.22085111 C7.98771319,2.08279082 7.83220882,2 7.66579907,2 Z' id='icon'></path> ";
		    svg += "     </g> ";
		    svg += " </svg> ";
		  } else {
		    svg += " <?xml version='1.0' encoding='UTF-8'?> ";
		    svg += " <svg width='20' height='18' viewBox='0 0 20 18' version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink'> ";
		    svg += "     <g id='ico_folder_close' style='fill: #" + color + "'> ";
		    svg += "         <path d='M9.46442367,-2.48689958e-14 C9.79724472,-2.48689958e-14 10.1082547,0.165583165 10.2940667,0.441705843 L11.867008,2.77914708 C11.959914,2.91720842 12.115419,3 12.2818295,3 L19.0002463,3 C19.5525311,3 20.0002463,3.44771525 20.0002463,4 L20.0002463,16.9956055 C20.0002463,17.5478902 19.5525311,17.9956055 19.0002463,17.9956055 L1,17.9956055 C0.487164161,17.9956055 0.0644928393,17.6095789 0.00672773133,17.1122403 L1.36867753e-05,16.9956055 L0.000232615032,1 C0.000253860825,0.447720595 0.447966897,-2.48689958e-14 1.0002463,-2.48689958e-14 L9.46442367,-2.48689958e-14 Z M8.66482313,1.999 L2.5,1.999 C2.22387158,1.999 2.00001973,2.22287158 1.99996428,2.499 L1.99903571,15.495 C1.99903571,15.7404599 2.17584348,15.944621 2.40908927,15.9869736 L2.499,15.995 L17.5,15.995 C17.7761424,15.995 18,15.7711424 18,15.495 L18,5.499 C18,5.25354011 17.8231949,5.04939163 17.5899465,5.00705567 L17.5,4.99907093 L11.4832626,4.99992447 C11.1504194,4.99997168 10.8393683,4.83441077 10.653522,4.55828448 L9.07962252,2.21982 C8.98671338,2.08177769 8.83121961,1.999 8.66482313,1.999 Z' id='icon'></path> ";
		    svg += "     </g> ";
		    svg += " </svg> ";
		  }

		  label = "<div style='float:left;margin-right:5px;'>" + svg + "</div>" + filename;
		} else {
		  if (isExpanded == true) {
		    label = "<div style='float:left;margin-right:5px;'><img src='/carpe/resources/images/ico_folder_default.svg' /></div>" + filename;
		  } else {
		    label = "<div style='float:left;margin-right:5px;'><img src='/carpe/resources/images/ico_folder_default_open.svg' /></div>" + filename;
		  }
		}

		ModelAndView mav = new ModelAndView();
		mav.addObject("ret", 0);
		mav.addObject("label", label);
		mav.addObject("color", color);
		mav.addObject("filename", filename);
		mav.setViewName("jsonView");

		return mav;
	}
}