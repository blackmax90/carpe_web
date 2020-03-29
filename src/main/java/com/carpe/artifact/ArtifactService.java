package com.carpe.artifact;

import java.util.List;
import java.util.Map;

public interface ArtifactService {
	// Plaso Result
	public List<Map> selectSystemLogOverviewList(Map<String, Object> paramMap) throws Exception;
	public Map selectSystemLogOverviewListCount(Map<String, Object> paramMap) throws Exception;
	
	// Operating System
	public List<Map> selectOSInstallationList(Map<String, Object> paramMap) throws Exception;
	public Map selectOSInstallationListCount(Map<String, Object> paramMap) throws Exception;
	
	// Windows Storage Device
	public List<Map> selectStorageDeviceList(Map<String, Object> paramMap) throws Exception;
	public Map selectStorageDeviceListCount(Map<String, Object> paramMap) throws Exception;
	
	//	Installed Application
	public List<Map> selectInstalledAppList(Map<String, Object> paramMap) throws Exception;
	public Map selectInstalledAppListCount(Map<String, Object> paramMap) throws Exception;
	
	//	Web History
	public List<Map> selectWebHistoryList(Map<String, Object> paramMap) throws Exception;
	public Map selectWebHistoryListCount(Map<String, Object> paramMap) throws Exception;
	
	//	Web Download
	public List<Map> selectWebDownloadList(Map<String, Object> paramMap) throws Exception;
	public Map selectWebDownloadListCount(Map<String, Object> paramMap) throws Exception;

	//	Web Cache
	public List<Map> selectWebCacheList(Map<String, Object> paramMap) throws Exception;
	public Map selectWebCacheListCount(Map<String, Object> paramMap) throws Exception;
	
	//	Web Cookie
	public List<Map> selectWebCookieList(Map<String, Object> paramMap) throws Exception;
	public Map selectWebCookieListCount(Map<String, Object> paramMap) throws Exception;
	
	public List<Map> selectTimelineList(Map<String, Object> paramMap) throws Exception;
	
	// lv1
	// lv1_os_win_event_logs
	public List<Map> selectEventLogsList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_jumplist
	public List<Map> selectJumplistList(Map<String, Object> paramMap) throws Exception;
	public Map selectJumplistListCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_amcache_file_entries	
	public List<Map> selectRegAmcacheFileEntriesList(Map<String, Object> paramMap) throws Exception;
	public Map selectRegAmcacheFileEntriesListCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_amcache_program_entries	
	public List<Map> selectRegAmcacheProgramEntriesList(Map<String, Object> paramMap) throws Exception;
	public Map selectRegAmcacheProgramEntriesListCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_installed_programs
	public List<Map> selectRegInstalledProgramsList(Map<String, Object> paramMap) throws Exception;
	public Map selectRegInstalledProgramsListCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_os_info
	public List<Map> selectRegOSInfoList(Map<String, Object> paramMap) throws Exception;
	public Map selectRegOSInfoListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_reg_usb_devices
	public List<Map> selectRegUSBDevicesList(Map<String, Object> paramMap) throws Exception;
	public Map selectRegUSBDevicesListCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_user_accounts
	public List<Map> selectRegUserAccountsList(Map<String, Object> paramMap) throws Exception;
	public Map selectRegUserAccountsListCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_app_web_chrome_visit_urls
	public List<Map> selectChromeVisitUrlsList(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeVisitUrlsListCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_userassist
	public List<Map> selectRegUserAssist(Map<String, Object> paramMap) throws Exception;
	public Map selectRegUserAssistCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_lnk_files
	public List<Map> selectLnkFiles(Map<String, Object> paramMap) throws Exception;
	public Map selectLnkFilesCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_prefetch
	public List<Map> selectPrefetch(Map<String, Object> paramMap) throws Exception;
	public Map selectPrefetchCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_app_web_chrome_download
	public List<Map> selectChromeDownload(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeDownloadCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_app_web_chrome_cookies
	public List<Map> selectChromeCookie(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeCookieCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_app_web_chrome_cache
	public List<Map> selectChromeCache(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeCacheCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chrome_search_terms
	public List<Map> selectChromeSearchTerms(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeSearchTermsCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_fs_ntfs_logfile
	public List<Map> selectNtfsLogfile(Map<String, Object> paramMap) throws Exception;
	public Map selectNtfsLogfileCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_fs_ntfs_usnjrnl
	public List<Map> selectNtfsUsnjrnl(Map<String, Object> paramMap) throws Exception;
	public Map selectNtfsUsnjrnlCount(Map<String, Object> paramMap) throws Exception;
	
}