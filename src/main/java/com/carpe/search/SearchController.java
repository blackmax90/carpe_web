package com.carpe.search;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.carpe.common.CarpeConfig;
import com.carpe.common.Consts;
import com.carpe.common.search.SearchService;
import com.opencsv.CSVWriter;

import io.searchbox.core.SearchResult;
import io.searchbox.core.SearchResult.Hit;

@Controller
public class SearchController {
	@Inject
	private SearchService service;

	@RequestMapping(value = "/search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView filesystemView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/search/search");

		return mav;
	}

	@RequestMapping(value = "/download_search.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void downloadEvdnc(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, HttpServletResponse response) throws Exception {
		String searchPath = map.get("path");

		if (searchPath.startsWith("/home/carpe/tmp/") && searchPath.contains("..") == false)
		{
			File physicalFile = new File(String.format("%s", searchPath));
			
			System.out.println(CarpeConfig.getEvdncBasePath());
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
	}
	
	@RequestMapping(value = "/search_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getSearchList(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session, Model model) throws Exception {
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

			paramMap.put("inFileName", Boolean.parseBoolean((String) map.get("inFileName")));
			paramMap.put("inContent", Boolean.parseBoolean((String) map.get("inContent")));

			String searchWord = (String) map.get("searchWord");
			if (searchWord != null) {
				searchWord = URLDecoder.decode(searchWord, "UTF-8");
				searchWord = new String(Base64.decodeBase64(searchWord), "UTF-8");
				searchWord = searchWord.trim();
			}

			paramMap.put("searchWord", searchWord);
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("totalcount", 0);
			return mav;
		}

		SearchResult searchResult = service.search(paramMap);
		if (searchResult == null) {
			mav.addObject("msg", "reault is null.");
			mav.setStatus(HttpStatus.INTERNAL_SERVER_ERROR);
			return mav;
		}

		if (!searchResult.isSucceeded()) {
			mav.addObject("msg", "search fail.");
			mav.setStatus(HttpStatus.INTERNAL_SERVER_ERROR);
			return mav;
		}

		long totalCnt = 0;
		totalCnt = searchResult.getTotal();

		List<Map> list = new ArrayList<Map>();

		List<Hit<Map<String, Object>, Void>> thehits = (List) searchResult.getHits(Map.class);
		for (Hit<Map<String, Object>, Void> hit : thehits) {
			String name = "", highlight_nm = "", original_size = "", path = "", author = ""
					, last_written_time = "", content = "", download_path = "", path_with_ext  = "", lastsavedby = "", createdtime = "", lastsavedtime = "";
			if (hit.source.get("name") != null) {
				name = hit.source.get("name").toString();
			}
			
			if (map.get("searchWord") != null && !"".equals(map.get("searchWord"))) {
				if (hit.highlight.get("name") != null) {
					highlight_nm = hit.highlight.get("name").toString();
				}
	
				if (highlight_nm == null || highlight_nm.length() < 1) {
					highlight_nm = name;
				}
			}

			if (hit.source.get("full_path") != null) {
				path = hit.source.get("full_path").toString();
			}
			
			if (hit.source.get("original_size") != null) {
				original_size = hit.source.get("original_size").toString();
			}

			
			if (hit.source.get("author") != null) {
				author = hit.source.get("author").toString();
			}

			if (hit.source.get("download_path") != null) {
				download_path = hit.source.get("download_path").toString();
			}

			if (hit.source.get("last_written_time") != null) {
				last_written_time = hit.source.get("last_written_time").toString();
			}
			
			if (hit.source.get("path_with_ext") != null) {
				path_with_ext = hit.source.get("path_with_ext").toString();
			}
			
			if (hit.source.get("createdtime") != null) {
				createdtime = hit.source.get("createdtime").toString();
			}
			
			if (hit.source.get("lastsavedby") != null) {
				lastsavedby = hit.source.get("lastsavedby").toString();
			}
			
			if (hit.source.get("lastsavedtime") != null) {
				lastsavedtime = hit.source.get("lastsavedtime").toString();
			}
			
			if (map.get("searchWord") != null && !"".equals(map.get("searchWord"))) {
				if (hit.highlight.get("content") != null) {
					content = hit.highlight.get("content").toString();
				}
			}
			Map<String, Object> element = new HashMap<String, Object>();
			element.put("name", name);
			if (map.get("searchWord") != null && !"".equals(map.get("searchWord"))) {
				element.put("highlight_nm", highlight_nm);
			}
			element.put("path", path);
			element.put("size", original_size);
			element.put("path", path);
			element.put("author", author);
			element.put("last_written_time", last_written_time);
			element.put("download_path", download_path);
			element.put("path_with_ext", path_with_ext);
			element.put("lastsavedby", lastsavedby);
			element.put("createdtime", createdtime);
			element.put("lastsavedtime", lastsavedtime);
			element.put("content", content);

			list.add(element);
		}
		//		mav.addObject("list", systemLogOverviewList);
		mav.addObject("list", list);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

	@RequestMapping(value = "/stringsearch_csv_export.do", method = { RequestMethod.GET, RequestMethod.POST })
	public void stringsearchCsvExport(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session, 
	    HttpServletResponse response, Model model) throws Exception {
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddhhmmss");
		String fileName = "stringsearch_data_" + df.format(new Date()) + ".csv";

		response.setContentType("text/csv; charset=MS949");
	  response.setHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + fileName + "\"");
		CSVWriter csvWriter = new CSVWriter(response.getWriter());
		
		String[] keys = {"name", "original_size", "author", "lastsavedby", "createdtime", "lastsavedtime", "path_with_ext"};
		String[] header = {"File name", "File Size", "Author", "Last saved by", "Created Time", "Last saved time", "File Path"};
		csvWriter.writeNext(header);

		Map<String, Object> paramMap = new HashMap<String, Object>();
		long pageSize = Consts.PAGE_SZIE * 10;
		long currentPage = 1;
		long totalCnt = 0;
		long offset = 0;

		try {
		  paramMap.put("pageSize", pageSize);
		  paramMap.put("inFileName", Boolean.parseBoolean((String) map.get("inFileName")));
		  paramMap.put("inContent", Boolean.parseBoolean((String) map.get("inContent")));

		  String searchWord = (String) map.get("searchWord");

		  if (searchWord != null) {
		    searchWord = URLDecoder.decode(searchWord, "UTF-8");
		    searchWord = new String(Base64.decodeBase64(searchWord), "UTF-8");
		    searchWord = searchWord.trim();
		  }

		  paramMap.put("searchWord", searchWord);

		  while (true) {
		    offset = (currentPage - 1) * pageSize;
		    paramMap.put("offset", offset);

		    SearchResult searchResult = service.search(paramMap);

		    if (searchResult == null || !searchResult.isSucceeded()) {
		      break;
		    }

		    totalCnt = searchResult.getTotal();
		    
		    if (totalCnt - offset < 0) {
		      break;
		    }

		    List<Hit<Map<String, Object>, Void>> thehits = (List) searchResult.getHits(Map.class);

		    for (Hit<Map<String, Object>, Void> hit : thehits) {
		      String[] buff = new String[keys.length];
		      int idx = 0;

		      for (String key : keys) {
		        String val = (hit.source.get(key) == null) ? "" : hit.source.get(key).toString();
		        buff[idx++] = val;
          }
			
		      csvWriter.writeNext(buff);
		    }
		    
		    currentPage++;
		  }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
		  if (csvWriter != null) {
		    csvWriter.close();
		  }
    }
	}
}