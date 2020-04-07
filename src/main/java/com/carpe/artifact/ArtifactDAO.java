package com.carpe.artifact;

import java.util.List;
import java.util.Map;

public interface ArtifactDAO {
	// Plaso Result
	public List<Map> selectSystemLogOverviewList(Map<String, Object> paramMap) throws Exception;
	public Map selectSystemLogOverviewListCount(Map<String, Object> paramMap) throws Exception;
	
	// Operating System
	public List<Map> selectOSInstallationList(Map<String, Object> paramMap) throws Exception;
	public Map selectOSInstallationListCount(Map<String, Object> paramMap) throws Exception;
	
	// Windows Storage Device
	public List<Map> selectStorageDeviceList(Map<String, Object> paramMap) throws Exception;
	public Map selectStorageDeviceListCount(Map<String, Object> paramMap) throws Exception;
	
	// Installed Application
	public List<Map> selectInstalledAppList(Map<String, Object> paramMap) throws Exception;
	public Map selectInstalledAppListCount(Map<String, Object> paramMap) throws Exception;
	
	// Web History
	public List<Map> selectWebHistoryList(Map<String, Object> paramMap) throws Exception;
	public Map selectWebHistoryListCount(Map<String, Object> paramMap) throws Exception;
	
	// Web Download
	public List<Map> selectWebDownloadList(Map<String, Object> paramMap) throws Exception;
	public Map selectWebDownloadListCount(Map<String, Object> paramMap) throws Exception;

	// Web Cache
	public List<Map> selectWebCacheList(Map<String, Object> paramMap) throws Exception;
	public Map selectWebCacheListCount(Map<String, Object> paramMap) throws Exception;
	
	// Web Cookie
	public List<Map> selectWebCookieList(Map<String, Object> paramMap) throws Exception;
	public Map selectWebCookieListCount(Map<String, Object> paramMap) throws Exception;
	
	public List<Map> selectTimelineList(Map<String, Object> paramMap) throws Exception;
	
	// lv1
	
	// lv1_os_win_event_logs
	public List<Map> selectEventLogsList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_antiforensics
	public List<Map> selectEventLogsAntiforensicsList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsAntiforensicsListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_applications
	public List<Map> selectEventLogsApplicationsList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsApplicationsListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_dns
	public List<Map> selectEventLogsDNSList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsDNSListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_file_handling
	public List<Map> selectEventLogsFileHandlingList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsFileHandlingListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_logonoff
	public List<Map> selectEventLogsLogonoffList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsLogonoffListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_ms_alerts
	public List<Map> selectEventLogsMsAlertsList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsMsAlertsListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_msi_installer
	public List<Map> selectEventLogsMsiInstallerList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsMsiInstallerListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_network
	public List<Map> selectEventLogsNetworkList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsNetworkListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_others
	public List<Map> selectEventLogsOthersList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsOthersListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_pconoff
	public List<Map> selectEventLogsPConoffList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsPConoffListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_printer
	public List<Map> selectEventLogsPrinterList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsPrinterListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_process
	public List<Map> selectEventLogsProcessList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsProcessListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_registry_handling
	public List<Map> selectEventLogsRegistryHandlingList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsRegistryHandlingListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_remoteonoff
	public List<Map> selectEventLogsRemoteonoffList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsRemoteonoffListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_screen_saver
	public List<Map> selectEventLogsScreenSaverList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsScreenSaverListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_shared_folder
	public List<Map> selectEventLogsSharedFolderList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsSharedFolderListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_sleeponoff
	public List<Map> selectEventLogsSleeponoffList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsSleeponoffListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_telemetry
	public List<Map> selectEventLogsTelemetryList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsTelemetryListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_time_changed
	public List<Map> selectEventLogsTimeChangedList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsTimeChangedListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_event_logs_usb_devices
	public List<Map> selectEventLogsUsbDevicesList(Map<String, Object> paramMap) throws Exception;
	public Map selectEventLogsUsbDevicesListCount(Map<String, Object> paramMap) throws Exception;

	
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
	
	// lv1_win_os_reg_userassist
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