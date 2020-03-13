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
import com.carpe.sqlite.SqliteDataReader;

@Controller
public class ArtifactController {
	@Inject
	private ArtifactService service;

	@RequestMapping(value = "/artifact.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView artifactView(@RequestParam HashMap<String, String> map, HttpSession session,
			HttpServletRequest requst, Model model) throws Exception {
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
	public ModelAndView getArtifactTreeNode(Locale locale, @RequestParam HashMap<String, String> map,
			HttpSession session, Model model) throws Exception {
		
		// lv1
		List subLv1List = new ArrayList();
		addArtifactTreeNode(subLv1List, "EventLogs", true, true, null);
		addArtifactTreeNode(subLv1List, "Reg Amcache File Entries", true, true, null);
		addArtifactTreeNode(subLv1List, "Reg Installed Programs", true, true, null);
		addArtifactTreeNode(subLv1List, "Reg OS Info", true, true, null);
		addArtifactTreeNode(subLv1List, "Reg User Accounts", true, true, null);
		addArtifactTreeNode(subLv1List, "Chrome Visit Urls", true, true, null);
		
		
		List subWebList = new ArrayList();
		addArtifactTreeNode(subWebList, "History", true, true, null);
		addArtifactTreeNode(subWebList, "Download", true, true, null);
		addArtifactTreeNode(subWebList, "Cache", true, true, null);
		addArtifactTreeNode(subWebList, "Cookie", true, true, null);

		List subList = new ArrayList();
		addArtifactTreeNode(subList, "Overview", true, true, null);
		addArtifactTreeNode(subList, "Operating System", true, true, null);
		addArtifactTreeNode(subList, "Storage Device", true, true, null);
		addArtifactTreeNode(subList, "Installed Application", true, true, null);
		addArtifactTreeNode(subList, "Web", false, false, subWebList);
		addArtifactTreeNode(subList, "Lv1 Tables", false, false, subLv1List);

		List subListMobile = new ArrayList();
		addArtifactTreeNode(subListMobile, "Application List", true, true, null);
		addArtifactTreeNode(subListMobile, "Call History", true, true, null);
		addArtifactTreeNode(subListMobile, "File History", true, true, null);
		addArtifactTreeNode(subListMobile, "Geo Data", true, true, null);
		addArtifactTreeNode(subListMobile, "ID/Password Hash", true, true, null);
		addArtifactTreeNode(subListMobile, "Web Browser", true, true, null);

		List list = new ArrayList();
		addArtifactTreeNode(list, "System Log", false, false, subList);
		// addArtifactTreeNode(list, "Mobile", false, false, subListMobile);

		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("jsonView");

		return mav;
	}

	@RequestMapping(value = "/system_log_overview.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getSystemLogOverview(Locale locale, @RequestParam HashMap<String, String> map,
			HttpSession session, Model model) throws Exception {
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

	@RequestMapping(value = "/operating_system.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getOSInstallation(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> OSInstallationList = service.selectOSInstallationList(paramMap);
		int totalCnt = ((Long) service.selectOSInstallationListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", OSInstallationList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

	@RequestMapping(value = "/storage_device.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getStorageDevice(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> StorageDeviceList = service.selectStorageDeviceList(paramMap);
		int totalCnt = ((Long) service.selectStorageDeviceListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", StorageDeviceList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

	@RequestMapping(value = "/installed_app.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getInstalledApp(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> InstalledAppList = service.selectInstalledAppList(paramMap);
		int totalCnt = ((Long) service.selectInstalledAppListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", InstalledAppList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

	@RequestMapping(value = "/web_history.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getWebHistory(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> WebHistoryList = service.selectWebHistoryList(paramMap);
		int totalCnt = ((Long) service.selectWebHistoryListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", WebHistoryList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

	@RequestMapping(value = "/web_download.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getWebDownload(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> WebDownloadList = service.selectWebDownloadList(paramMap);
		int totalCnt = ((Long) service.selectWebDownloadListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", WebDownloadList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

	@RequestMapping(value = "/web_cache.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getWebCache(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> WebCacheList = service.selectWebCacheList(paramMap);
		int totalCnt = ((Long) service.selectWebCacheListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", WebCacheList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

	@RequestMapping(value = "/web_cookie.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getWebCookie(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> WebCookieList = service.selectWebCookieList(paramMap);
		int totalCnt = ((Long) service.selectWebCookieListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", WebCookieList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

	@RequestMapping(value = "/timeline.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView timeline(@RequestParam HashMap<String, String> map, HttpSession session,
			HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/artifact/timeline/timeline");

		return mav;
	}

	@RequestMapping(value = "/timeline_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getTimelineList(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		Map<String, Object> paramMap = new HashMap<String, Object>();

		List<Map> timelineList = service.selectTimelineList(paramMap);

		List<Map> list = new ArrayList<Map>();
		List<Map> sublist = null;

		String preName = "";

		for (Map timeline : timelineList) {
			String source = timeline.get("source").toString();
			String date = timeline.get("date").toString();
			long cnt = (long) timeline.get("cnt");

			if (!preName.equals(source)) {
				Map<String, Object> element = new HashMap<String, Object>();
				element.put("name", source);
				sublist = new ArrayList<Map>();
				element.put("data", sublist);
				list.add(element);

				preName = source;
			}

			Map<String, Object> subElement = new HashMap<String, Object>();
			subElement.put("date", date);
			subElement.put("cnt", cnt);

			sublist.add(subElement);
		}

		mav.addObject("list", list);

		return mav;
	}

	@RequestMapping(value = "/timeline_chart.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView timelineChart(@RequestParam HashMap<String, String> map, HttpSession session,
			HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/timeline/timeline");

		return mav;
	}

	@RequestMapping(value = "/sqlite_list.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getSqliteList(Locale locale, @RequestParam HashMap<String, String> map, Model model)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");

		// SqliteDataReader reader = new SqliteDataReader("D:\\analysis.db");
		SqliteDataReader reader = new SqliteDataReader("/home/carpe/sqlite/analysis.db");

		try {
			reader.open();
			List<Map> list = null;
			if (map.get("div") != null && "application_list".equals(map.get("div"))) {
				list = reader.readApplicationList();
			} else if (map.get("div") != null && "call_history".equals(map.get("div"))) {
				list = reader.readCallHistory();
			} else if (map.get("div") != null && "file_history".equals(map.get("div"))) {
				list = reader.readFileHistory();
			} else if (map.get("div") != null && "geodata".equals(map.get("div"))) {
				list = reader.readGeoData();
			} else if (map.get("div") != null && "id_password_hash".equals(map.get("div"))) {
				list = reader.readIDPasswordHash();
			} else if (map.get("div") != null && "web_browser".equals(map.get("div"))) {
				list = reader.readWebBrowser();
			} 
			mav.addObject("list", list);
			mav.addObject("totalcount", list.size());
		} finally {
			reader.close();
		}

		return mav;
	}
	
	// lv1
	// lv1_os_win_event_logs
	@RequestMapping(value = "/eventlogs.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogs(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> EventLogsList = service.selectEventLogsList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	// lv1_os_win_jumplist
	@RequestMapping(value = "/jumplist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getJumplist(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> JumplistList = service.selectJumplistList(paramMap);
		int totalCnt = ((Long) service.selectJumplistListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", JumplistList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_reg_amcache_file_entries
	@RequestMapping(value = "/reg_amcache_file_entries.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getRegAmcacheFileEntries(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> RegAmcacheFileEntriesList = service.selectRegAmcacheFileEntriesList(paramMap);
		int totalCnt = ((Long) service.selectRegAmcacheFileEntriesListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", RegAmcacheFileEntriesList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	// lv1_os_win_reg_installed_programs
	@RequestMapping(value = "/reg_installed_programs.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getRegInstalledPrograms(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> RegInstalledProgramsList = service.selectRegInsatlledProgramsList(paramMap);
		int totalCnt = ((Long) service.selectRegInsatlledProgramsListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", RegInstalledProgramsList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	// lv1_os_win_reg_os_info
	@RequestMapping(value = "/reg_os_info.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getRegOSInfo(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> RegOSInfoList = service.selectRegOSInfoList(paramMap);
		int totalCnt = ((Long) service.selectRegOSInfoListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", RegOSInfoList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	// lv1_os_win_reg_usb_devices
	@RequestMapping(value = "/reg_usb_devices.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getRegUSBDevices(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> RegUSBDevicesList = service.selectRegUSBDevicesList(paramMap);
		int totalCnt = ((Long) service.selectRegUSBDevicesListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", RegUSBDevicesList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	// lv1_os_win_reg_user_accounts
	@RequestMapping(value = "/reg_user_accounts.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getRegUserAccounts(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> RegUserAccountsList = service.selectRegUserAccountsList(paramMap);
		int totalCnt = ((Long) service.selectRegUserAccountsListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", RegUserAccountsList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_app_web_chrome_visit_urls
	@RequestMapping(value = "/chrome_visit_urls.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getChromeVisitUrls(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
			Model model) throws Exception {
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

		List<Map> ChromeVisitUrlsList = service.selectChromeVisitUrlsList(paramMap);
		int totalCnt = ((Long) service.selectChromeVisitUrlsListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", ChromeVisitUrlsList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
		
}