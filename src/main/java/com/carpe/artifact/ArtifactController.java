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
		
		List subRegList = new ArrayList();
		addArtifactTreeNode(subRegList, "Installed Programs", true, true, null);
		addArtifactTreeNode(subRegList, "USB Devices", true, true, null);
		addArtifactTreeNode(subRegList, "OS Info", true, true, null);
		addArtifactTreeNode(subRegList, "User Accounts", true, true, null);
		addArtifactTreeNode(subRegList, "UserAssist", true, true, null);
		addArtifactTreeNode(subRegList, "Amcache Program", true, true, null);
		addArtifactTreeNode(subRegList, "Amcache File", true, true, null);
		addArtifactTreeNode(subRegList, "File Connection", true, true, null);
		addArtifactTreeNode(subRegList, "Known Dll", true, true, null);
		addArtifactTreeNode(subRegList, "Mac Address", true, true, null);
		addArtifactTreeNode(subRegList, "MRU Folder", true, true, null);
		addArtifactTreeNode(subRegList, "Mui Cache", true, true, null);
		addArtifactTreeNode(subRegList, "Network Drive", true, true, null);
		addArtifactTreeNode(subRegList, "Network Interface", true, true, null);
		addArtifactTreeNode(subRegList, "Network Profile", true, true, null);
		addArtifactTreeNode(subRegList, "Recent Docs", true, true, null);
		addArtifactTreeNode(subRegList, "Run Command", true, true, null);
		addArtifactTreeNode(subRegList, "Search Keyword", true, true, null);
		addArtifactTreeNode(subRegList, "Shim Cache", true, true, null);
		addArtifactTreeNode(subRegList, "Start List", true, true, null);
		addArtifactTreeNode(subRegList, "System Service", true, true, null);

		
		List subEvtList = new ArrayList();
		addArtifactTreeNode(subEvtList, "All", true, true, null); // Event logs all
		addArtifactTreeNode(subEvtList, "Antiforensics", true, true, null);
		addArtifactTreeNode(subEvtList, "Applications", true, true, null);
		addArtifactTreeNode(subEvtList, "DNS", true, true, null);
		addArtifactTreeNode(subEvtList, "File Handling", true, true, null);
		addArtifactTreeNode(subEvtList, "Log On/Off", true, true, null);
		addArtifactTreeNode(subEvtList, "MS Alerts", true, true, null);
		addArtifactTreeNode(subEvtList, "MSI Installer", true, true, null);
		addArtifactTreeNode(subEvtList, "Network", true, true, null);
		addArtifactTreeNode(subEvtList, "Others", true, true, null);
		addArtifactTreeNode(subEvtList, "PC On/Off", true, true, null);
		addArtifactTreeNode(subEvtList, "Printer", true, true, null);
		addArtifactTreeNode(subEvtList, "Process", true, true, null);
		addArtifactTreeNode(subEvtList, "Registry Handling", true, true, null);
		addArtifactTreeNode(subEvtList, "Remote On/Off", true, true, null);
		addArtifactTreeNode(subEvtList, "Screen Saver", true, true, null);
		addArtifactTreeNode(subEvtList, "Shared Folder", true, true, null);
		addArtifactTreeNode(subEvtList, "Sleep On/Off", true, true, null);
		addArtifactTreeNode(subEvtList, "Telemetry", true, true, null);
		addArtifactTreeNode(subEvtList, "Time Changed", true, true, null);
		addArtifactTreeNode(subEvtList, "USB Devices", true, true, null);

		List subLv1List = new ArrayList();
		addArtifactTreeNode(subLv1List, "Registry", false, false, subRegList);
		addArtifactTreeNode(subLv1List, "Event Logs", false, false, subEvtList);
		
		
		
		
		addArtifactTreeNode(subLv1List, "NTFS $LogFile", true, true, null);
		addArtifactTreeNode(subLv1List, "NTFS USN Journal", true, true, null);

		addArtifactTreeNode(subLv1List, "JumpList", true, true, null);
		addArtifactTreeNode(subLv1List, "LNK File", true, true, null);
		addArtifactTreeNode(subLv1List, "Prefetch", true, true, null);

		addArtifactTreeNode(subLv1List, "Chrome Visit Urls", true, true, null);
		addArtifactTreeNode(subLv1List, "Chrome Search Terms", true, true, null);
		addArtifactTreeNode(subLv1List, "Chrome Download", true, true, null);
		addArtifactTreeNode(subLv1List, "Chrome Cookies", true, true, null);
		addArtifactTreeNode(subLv1List, "Chrome Cache", true, true, null);

		
		List subLv2List = new ArrayList();
		addArtifactTreeNode(subLv2List, "Application History", true, true, null);


		
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

		List subListMobile = new ArrayList();
		addArtifactTreeNode(subListMobile, "Application List", true, true, null);
		addArtifactTreeNode(subListMobile, "Call History", true, true, null);
		addArtifactTreeNode(subListMobile, "File History", true, true, null);
		addArtifactTreeNode(subListMobile, "Geo Data", true, true, null);
		addArtifactTreeNode(subListMobile, "ID/Password Hash", true, true, null);
		addArtifactTreeNode(subListMobile, "Web Browser", true, true, null);

		List list = new ArrayList();
		addArtifactTreeNode(list, "~2019", false, false, subList);
		addArtifactTreeNode(list, "Lv2 Tables", false, false, subLv2List);
		addArtifactTreeNode(list, "Lv1 Tables", false, false, subLv1List);


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
	
	// lv1_os_win_event_logs_antiforensics
	@RequestMapping(value = "/eventlogs_antiforensics.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsAntiforensics(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsAntiforensicsList = service.selectEventLogsAntiforensicsList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsAntiforensicsListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsAntiforensicsList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_applications
	@RequestMapping(value = "/eventlogs_apps.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsApps(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsAppList = service.selectEventLogsApplicationsList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsApplicationsListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsAppList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_dns
	@RequestMapping(value = "/eventlogs_dns.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsDNS(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsDNSList = service.selectEventLogsDNSList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsDNSListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsDNSList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_file_handling
	@RequestMapping(value = "/eventlogs_file_handle.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsFileHandle(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsFileHandleList = service.selectEventLogsFileHandlingList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsFileHandlingListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsFileHandleList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_logonoff
	@RequestMapping(value = "/eventlogs_log_onoff.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsLogon(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsLogonoffList = service.selectEventLogsLogonoffList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsLogonoffListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsLogonoffList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_ms_alerts
	@RequestMapping(value = "/eventlogs_ms_alerts.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsMsAlerts(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsMsAlertsList = service.selectEventLogsMsAlertsList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsMsAlertsListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsMsAlertsList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_msi_installer
	@RequestMapping(value = "/eventlogs_msi.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsMsi(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsMsiList = service.selectEventLogsMsiInstallerList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsMsiInstallerListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsMsiList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_network
	@RequestMapping(value = "/eventlogs_network.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsNetwork(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsNetworkList = service.selectEventLogsNetworkList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsNetworkListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsNetworkList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_others
	@RequestMapping(value = "/eventlogs_others.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsOthers(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsOthersList = service.selectEventLogsOthersList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsOthersListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsOthersList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_pconoff
	@RequestMapping(value = "/eventlogs_pc_onoff.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsPConoff(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsPConoffList = service.selectEventLogsPConoffList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsPConoffListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsPConoffList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_printer
	@RequestMapping(value = "/eventlogs_printer.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsPrinter(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsPrinterList = service.selectEventLogsPrinterList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsPrinterListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsPrinterList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_process
	@RequestMapping(value = "/eventlogs_process.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsProcess(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsProcessList = service.selectEventLogsProcessList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsProcessListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsProcessList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_registry_handling
	@RequestMapping(value = "/eventlogs_reg_handle.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsRegHandle(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsRegHandleList = service.selectEventLogsRegistryHandlingList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsRegistryHandlingListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsRegHandleList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_remoteonoff
	@RequestMapping(value = "/eventlogs_remote_onoff.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsRemoteOnOff (Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsRemoteList = service.selectEventLogsRemoteonoffList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsRemoteonoffListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsRemoteList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_screen_saver
	@RequestMapping(value = "/eventlogs_screen_saver.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsScreen(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsScreenSaveList = service.selectEventLogsScreenSaverList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsScreenSaverListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsScreenSaveList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_shared_folder
	@RequestMapping(value = "/eventlogs_shared.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsShared(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsSharedList = service.selectEventLogsSharedFolderList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsSharedFolderListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsSharedList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_sleeponoff
	@RequestMapping(value = "/eventlogs_sleep.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsSleep(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsSleepList = service.selectEventLogsSleeponoffList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsSleeponoffListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsSleepList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_telemetry
	@RequestMapping(value = "/eventlogs_telemetry.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsTelemetry(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsTelemetryList = service.selectEventLogsTelemetryList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsTelemetryListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsTelemetryList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_time_changed
	@RequestMapping(value = "/eventlogs_time_changed.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsTimeChanged(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsTimeChangedList = service.selectEventLogsTimeChangedList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsTimeChangedListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsTimeChangedList);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_event_logs_usb_devices
	@RequestMapping(value = "/eventlogs_usb.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getEventLogsUSB(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> EventLogsUSBList = service.selectEventLogsUsbDevicesList(paramMap);
		int totalCnt = ((Long) service.selectEventLogsUsbDevicesListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", EventLogsUSBList);
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
	
	// lv1_os_win_reg_amcache_program_entries
	@RequestMapping(value = "/reg_amcache_program_entries.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getRegAmcacheProgramEntries(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> RegAmcacheProgramEntriesList = service.selectRegAmcacheProgramEntriesList(paramMap);
		int totalCnt = ((Long) service.selectRegAmcacheProgramEntriesListCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", RegAmcacheProgramEntriesList);
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

		List<Map> RegInstalledProgramsList = service.selectRegInstalledProgramsList(paramMap);
		int totalCnt = ((Long) service.selectRegInstalledProgramsListCount(paramMap).get("cnt")).intValue();

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
	
	// lv1_os_win_reg_file_connection
		@RequestMapping(value = "/reg_file_connection.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegFileConnection(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegFileConnection = service.selectRegFileConnection(paramMap);
			int totalCnt = ((Long) service.selectRegFileConnectionCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegFileConnection);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_known_dll
		@RequestMapping(value = "/reg_known_dll.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegKnownDll(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegKnownDll = service.selectRegKnownDll(paramMap);
			int totalCnt = ((Long) service.selectRegKnownDllCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegKnownDll);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_mac_address
		@RequestMapping(value = "/reg_mac_address.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegMacAddress(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegMacAddress = service.selectRegMacAddress(paramMap);
			int totalCnt = ((Long) service.selectRegMacAddressCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegMacAddress);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_mru_folder
		@RequestMapping(value = "/reg_mru_folder.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegMruFolder(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegMruFolder = service.selectRegMruFolder(paramMap);
			int totalCnt = ((Long) service.selectRegMruFolderCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegMruFolder);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_mui_cache
		@RequestMapping(value = "/reg_mui_cache.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegMuiCache(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegMuiCache = service.selectRegMuiCache(paramMap);
			int totalCnt = ((Long) service.selectRegMuiCacheCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegMuiCache);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_network_drive
		@RequestMapping(value = "/reg_network_drive.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegNetworkDrive(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegNetworkDrive = service.selectRegNetworkDrive(paramMap);
			int totalCnt = ((Long) service.selectRegNetworkDriveCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegNetworkDrive);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_network_interface
		@RequestMapping(value = "/reg_network_interface.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegNetworkInterface(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegNetworkInterface = service.selectRegNetworkInterface(paramMap);
			int totalCnt = ((Long) service.selectRegNetworkInterfaceCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegNetworkInterface);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_network_profile
		@RequestMapping(value = "/reg_network_profile.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegNetworkProfile(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegNetworkProfile = service.selectRegNetworkProfile(paramMap);
			int totalCnt = ((Long) service.selectRegNetworkProfileCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegNetworkProfile);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_recent_docs
		@RequestMapping(value = "/reg_recent_docs.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegRecentDocs(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegRecentDocs = service.selectRegRecentDocs(paramMap);
			int totalCnt = ((Long) service.selectRegRecentDocsCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegRecentDocs);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_run_command
		@RequestMapping(value = "/reg_run_command.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegRunCommand(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegRunCommand = service.selectRegRunCommand(paramMap);
			int totalCnt = ((Long) service.selectRegRunCommandCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegRunCommand);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_search_keyword
		@RequestMapping(value = "/reg_search_keyword.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegSearchKeyword(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegSearchKeyword = service.selectRegSearchKeyword(paramMap);
			int totalCnt = ((Long) service.selectRegSearchKeywordCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegSearchKeyword);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_shim_cache
		@RequestMapping(value = "/reg_shim_cache.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegShimCache(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegShimCache = service.selectRegShimCache(paramMap);
			int totalCnt = ((Long) service.selectRegShimCacheCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegShimCache);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_start_list
		@RequestMapping(value = "/reg_start_list.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegStartList(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegStartList = service.selectRegStartList(paramMap);
			int totalCnt = ((Long) service.selectRegStartListCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegStartList);
			mav.addObject("totalcount", totalCnt);

			return mav;
		}
		
		// lv1_os_win_reg_system_service
		@RequestMapping(value = "/reg_system_service.do", method = { RequestMethod.GET, RequestMethod.POST })
		public ModelAndView getRegSystemService(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

			List<Map> RegSystemService = service.selectRegSystemService(paramMap);
			int totalCnt = ((Long) service.selectRegSystemServiceCount(paramMap).get("cnt")).intValue();

			mav.addObject("list", RegSystemService);
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
	
	// lv1_os_win_reg_userassist
	@RequestMapping(value = "/reg_userassist.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getRegUserAssist(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> RegUserAssist = service.selectRegUserAssist(paramMap);
		int totalCnt = ((Long) service.selectRegUserAssistCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", RegUserAssist);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_lnk_files
	@RequestMapping(value = "/lnk_file.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getLnkFiles(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> LnkFiles = service.selectLnkFiles(paramMap);
		int totalCnt = ((Long) service.selectLnkFilesCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", LnkFiles);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_os_win_prefetch
	@RequestMapping(value = "/prefetch.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getPrefetch(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> Prefetch = service.selectPrefetch(paramMap);
		int totalCnt = ((Long) service.selectPrefetchCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", Prefetch);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_app_web_chrome_download
	@RequestMapping(value = "/chrome_download.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getChromeDownload(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> ChromeDownload = service.selectChromeDownload(paramMap);
		int totalCnt = ((Long) service.selectChromeDownloadCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", ChromeDownload);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_app_web_chrome_cookies
	@RequestMapping(value = "/chrome_cookies.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getChromeCookie(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> ChromeCookie = service.selectChromeCookie(paramMap);
		int totalCnt = ((Long) service.selectChromeCookieCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", ChromeCookie);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_app_web_chrome_cache
	@RequestMapping(value = "/chrome_cache.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getChromeCache(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> ChromeCache = service.selectChromeCache(paramMap);
		int totalCnt = ((Long) service.selectChromeCacheCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", ChromeCache);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}	

	// lv1_app_web_chrome_search_terms
	@RequestMapping(value = "/chrome_search_terms.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getChromeSearchTerms(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> ChromeSearchTerms = service.selectChromeSearchTerms(paramMap);
		int totalCnt = ((Long) service.selectChromeSearchTermsCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", ChromeSearchTerms);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_fs_ntfs_logfile
	@RequestMapping(value = "/ntfs_logfile.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getNtfsLogfile(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> NtfsLogfile = service.selectNtfsLogfile(paramMap);
		int totalCnt = ((Long) service.selectNtfsLogfileCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", NtfsLogfile);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}
	
	// lv1_fs_ntfs_usnjrnl
	@RequestMapping(value = "/ntfs_usnjrnl.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getNtfsUsnjrnl(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> NtfsUsnjrnl = service.selectNtfsUsnjrnl(paramMap);
		int totalCnt = ((Long) service.selectNtfsUsnjrnlCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", NtfsUsnjrnl);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

	
	// lv2_os_app_history
	@RequestMapping(value = "/app_history.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView getAppHistory(Locale locale, @RequestParam HashMap<String, String> map, HttpSession session,
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

		List<Map> AppHistory = service.selectAppHistory(paramMap);
		int totalCnt = ((Long) service.selectAppHistoryCount(paramMap).get("cnt")).intValue();

		mav.addObject("list", AppHistory);
		mav.addObject("totalcount", totalCnt);

		return mav;
	}

}