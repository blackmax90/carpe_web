package com.carpe.filesystem;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.StreamingResponseBody;

import com.carpe.common.CommonUtil;
import com.carpe.common.Consts;
import com.opencsv.CSVWriter;

@Controller
public class FileSystemController {

	@Inject
	private FileSystemService service;

	@RequestMapping(value = "/filesystem.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView filesystemView(@RequestParam HashMap<String, String> map, HttpSession session,
			HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/filesystem/filesystem");

		return mav;
	}

	/**
	 * Directory Tree List
	 * 
	 * @param locale
	 * @param map
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/dir_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getDirList(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
		List list = new ArrayList();
		String dataAttr = "";

		if (map.get("attr") != null && map.get("attr") != "") {
			dataAttr = map.get("attr");
		}

		if (map.get("evd_id") != null && map.get("evd_id") != "") {
			session.setAttribute(Consts.SESSION_EVDNC_ID, map.get("evd_id"));
			session.setAttribute(Consts.SESSION_EVDNC_NAME, map.get("evd_name"));
		}

		String caseid = (String) session.getAttribute(Consts.SESSION_CASE_ID);
		String evdid = (String) session.getAttribute(Consts.SESSION_EVDNC_ID);
		String evdName = (String) session.getAttribute(Consts.SESSION_EVDNC_NAME);

		try {
			if (map.get("evd_id") == null || map.get("evd_id").equals("") == true) {
				// evdnc list
				list = service.getEvdncList(caseid, evdid);
			} else if (map.get("id") != null && map.get("id") != "") {
				// file directory list
				list = service.getFileDirList(evdid, evdName, dataAttr, map.get("par_id"), map.get("parentId"));
			} else {
				// partion directory list
				list = service.getDirList(evdid, evdName);
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
	 * File Grid List
	 * 
	 * @param locale
	 * @param map
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/file_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getFileList(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		String searchFlag = map.get("search_flag");

		if (map.get("evd_id") != null && map.get("evd_id").equals("") == false) {
			session.setAttribute(Consts.SESSION_EVDNC_ID, map.get("evd_id"));
			session.setAttribute(Consts.SESSION_EVDNC_NAME, map.get("evd_name"));
		}

		if (map.get("evd_id") == null || map.get("evd_id").equals("")) {
			mav.addObject("totalcount", 0);
			return mav;
		}

		if ("1".equals(searchFlag) == false && (map.get("id") == null || map.get("id").equals("") 
				|| (map.get("attr") != null && "par".equals(map.get("attr"))))) {
			mav.addObject("totalcount", 0);
			return mav;
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("par_id", map.get("par_id"));

		if ("1".equals(searchFlag) == false) {
			try {
				long parentId = Long.parseLong((String) map.get("id"));
				paramMap.put("id", parentId);
			} catch (Exception e) {
				e.printStackTrace();
				mav.addObject("totalcount", 0);
				return mav;
			}
		} else {
			long pageSize = Long.parseLong((String) map.get("pageSize"));
			paramMap.put("pageSize", pageSize);
			long currentPage = Long.parseLong((String) map.get("currentPage"));
			paramMap.put("offset", (currentPage - 1) * pageSize);
		
			paramMap.put("search_fname", map.get("search_fname"));
			paramMap.put("search_ssize", map.get("search_ssize"));
			paramMap.put("search_esize", map.get("search_esize"));
			paramMap.put("search_timeType", map.get("search_timeType"));
			paramMap.put("search_stime", map.get("search_stime"));
			paramMap.put("search_etime", map.get("search_etime"));
		}

		paramMap.put("evd_id", session.getAttribute(Consts.SESSION_EVDNC_ID));
		
		List<Map> fileList = service.selectFileList(paramMap);

		if ("1".equals(searchFlag) == false) {
			mav.addObject("list", fileList);
			mav.addObject("totalcount", fileList.size());
		} else {
			int totalCnt = ((Long) service.selectFileListCount(paramMap).get("cnt")).intValue();
			mav.addObject("list", fileList);
			mav.addObject("totalcount", totalCnt);
		}

		return mav;
	}
	
	/**
	 * Filesystem CSV Export
	 * 
	 * @param locale
	 * @param map
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/filesystem_csv_export.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void filesystemCsvExport(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			HttpServletResponse response, Model model) throws Exception {
		String searchFlag = map.get("searchFlag");

		if (map.get("evd_id") != null && map.get("evd_id").equals("") == false) {
			session.setAttribute(Consts.SESSION_EVDNC_ID, map.get("evd_id"));
			session.setAttribute(Consts.SESSION_EVDNC_NAME, map.get("evd_name"));
		}

		if (map.get("evd_id") == null || map.get("evd_id").equals("")) {
			return;
		}

		if ("1".equals(searchFlag) == false && (map.get("id") == null || map.get("id").equals("") 
				|| (map.get("attr") != null && "par".equals(map.get("attr"))))) {
			return;
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("par_id", map.get("par_id"));

		if ("1".equals(searchFlag) == false) {
			try {
				long parentId = Long.parseLong((String) map.get("id"));
				paramMap.put("id", parentId);
			} catch (Exception e) {
				e.printStackTrace();
				return;
			}
		} else {
			paramMap.put("search_fname", map.get("search_fname"));
			paramMap.put("search_ssize", map.get("search_ssize"));
			paramMap.put("search_esize", map.get("search_esize"));
			paramMap.put("search_timeType", map.get("search_timeType"));
			paramMap.put("search_stime", map.get("search_stime"));
			paramMap.put("search_etime", map.get("search_etime"));
		}

		paramMap.put("evd_id", session.getAttribute(Consts.SESSION_EVDNC_ID));
		
		List<Map> fileList = service.selectFileList(paramMap);
		
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddhhmmss");
		String fileName = "filesystem_data_" + df.format(new Date()) + ".csv";

		response.setContentType("text/csv; charset=MS949");
	  response.setHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"");
		CSVWriter csvWriter = new CSVWriter(response.getWriter());
		
		String[] keys = {"parent_path", "name", "size", "md5", "dir_type", "mtime", "ctime", "atime"};
		String[] header = {"Path", "Name", "Size", "MD5", "Category", "Modified Time", "Create Time", "Accessed Time"};
		csvWriter.writeNext(header);
		
		for (Map data : fileList) {
			String[] buff = new String[keys.length];
			int idx = 0;

			for (String key : keys) {
				String val = String.valueOf(data.get(key));

				if (key.equals("dir_type")) {
					String tmp = "etc";

					if ("3".equals(val)) {
						tmp = "Directory";
					} else if ("5".equals(val)) {
						tmp = "File";
					}
					
					val = tmp;
				}

				buff[idx++] = val;
			}

		  csvWriter.writeNext(buff);
		}
		
		csvWriter.close();
	}

	@RequestMapping(value = "/filename_wordcloud.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView filesystemWordCloudView(@RequestParam HashMap<String, String> map, HttpSession session,
			HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/filesystem/filename_wordcloud");

		return mav;
	}

	@RequestMapping(value = "/date_treemap.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView dateTreeMapView(@RequestParam HashMap<String, String> map, HttpSession session,
			HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.addObject("id", map.get("id"));
		mav.setViewName("carpe/filesystem/date_treemap");

		return mav;
	}

	@RequestMapping(value = "/get_date_treemap.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getDateTreeMap(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		if (map.get("id") == null || map.get("id").equals("")) {
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
	public ModelAndView hewview(@RequestParam HashMap<String, String> map, HttpSession session,
			HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/filesystem/hexview/hexviewer");

		return mav;
	}

	@RequestMapping(value = "/file_preview.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView filePreview(@RequestParam HashMap<String, String> map, HttpSession session,
			HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.addAllObjects(map);
		mav.setViewName("carpe/filesystem/file_preview");

		return mav;
	}

	@RequestMapping(value = "/get_image_preview.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void getImagePreview(@RequestParam HashMap<String, String> map, HttpSession session,
			HttpServletRequest requst, HttpServletResponse response, Model model) throws Exception {
		ServletOutputStream out = response.getOutputStream();
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("id", map.get("seq"));
		paramMap.put("file_id", map.get("id"));

		Map rsMap = service.selectFileInfo(paramMap);

		if (rsMap != null) {
			File file = new File(rsMap.get("parent_path") + "/" + rsMap.get("name"));
			response.setContentType("image/" + rsMap.get("extension"));

			if (file != null && file.isFile() == true) {
				FileInputStream fis = new FileInputStream(file);
				byte[] buff = new byte[1024];
				int len = 0;

				try {
					while ((len = fis.read(buff)) != -1) {
						out.write(buff, 0, len);
					}
				} catch (IOException e) {
					e.printStackTrace();
				}

				fis.close();
			}
		}
	}

	@RequestMapping(value = "/get_video_preview.do", method = { RequestMethod.GET, RequestMethod.POST })
	public StreamingResponseBody getVideoPreview(@RequestParam HashMap<String, String> map, HttpSession session,
			HttpServletRequest requst, Model model) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("id", map.get("seq"));
		paramMap.put("file_id", map.get("id"));

		Map rsMap = service.selectFileInfo(paramMap);

		if (rsMap != null) {
			File file = new File(rsMap.get("parent_path") + "/" + rsMap.get("name"));

			final InputStream is = new FileInputStream(file);

			return os -> {
				byte[] data = new byte[2048];
				int read = 0;
				while ((read = is.read(data)) > 0) {
					os.write(data, 0, read);
				}
				os.flush();
				is.close();
			};
		}

		return null;
	}
}