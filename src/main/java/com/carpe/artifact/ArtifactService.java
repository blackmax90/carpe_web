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

	// lv1_os_win_reg_file_connection
	public List<Map> selectRegFileConnection(Map<String, Object> paramMap) throws Exception;
	public Map selectRegFileConnectionCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_known_dll
	public List<Map> selectRegKnownDll(Map<String, Object> paramMap) throws Exception;
	public Map selectRegKnownDllCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_mac_address
	public List<Map> selectRegMacAddress(Map<String, Object> paramMap) throws Exception;
	public Map selectRegMacAddressCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_mru_folder
	public List<Map> selectRegMruFolder(Map<String, Object> paramMap) throws Exception;
	public Map selectRegMruFolderCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_mru_file
	public List<Map> selectMRUFile(Map<String, Object> paramMap) throws Exception;
	public Map selectMRUFileCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_mui_cache
	public List<Map> selectRegMuiCache(Map<String, Object> paramMap) throws Exception;
	public Map selectRegMuiCacheCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_network_drive
	public List<Map> selectRegNetworkDrive(Map<String, Object> paramMap) throws Exception;
	public Map selectRegNetworkDriveCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_network_interface
	public List<Map> selectRegNetworkInterface(Map<String, Object> paramMap) throws Exception;
	public Map selectRegNetworkInterfaceCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_network_profile
	public List<Map> selectRegNetworkProfile(Map<String, Object> paramMap) throws Exception;
	public Map selectRegNetworkProfileCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_recent_docs
	public List<Map> selectRegRecentDocs(Map<String, Object> paramMap) throws Exception;
	public Map selectRegRecentDocsCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_run_command
	public List<Map> selectRegRunCommand(Map<String, Object> paramMap) throws Exception;
	public Map selectRegRunCommandCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_search_keyword
	public List<Map> selectRegSearchKeyword(Map<String, Object> paramMap) throws Exception;
	public Map selectRegSearchKeywordCount(Map<String, Object> paramMap) throws Exception;
	
	
	// lv1_os_win_reg_shellbag
	public List<Map> selectShellbag(Map<String, Object> paramMap) throws Exception;
	public Map selectShellbagCount(Map<String, Object> paramMap) throws Exception;


	// lv1_os_win_reg_shim_cache
	public List<Map> selectRegShimCache(Map<String, Object> paramMap) throws Exception;
	public Map selectRegShimCacheCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_start_list
	public List<Map> selectRegStartList(Map<String, Object> paramMap) throws Exception;
	public Map selectRegStartListCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_system_service
	public List<Map> selectRegSystemService(Map<String, Object> paramMap) throws Exception;
	public Map selectRegSystemServiceCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_app_web_chrome_visit_urls
	public List<Map> selectChromeVisitUrlsList(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeVisitUrlsListCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_reg_userassist
	public List<Map> selectRegUserAssist(Map<String, Object> paramMap) throws Exception;
	public Map selectRegUserAssistCount(Map<String, Object> paramMap) throws Exception;
	
	/*
	// lv1_os_win_lnk_files
	public List<Map> selectLnkFiles(Map<String, Object> paramMap) throws Exception;
	public Map selectLnkFilesCount(Map<String, Object> paramMap) throws Exception;
	*/
	/*
	// lv1_os_win_prefetch
	public List<Map> selectPrefetch(Map<String, Object> paramMap) throws Exception;
	public Map selectPrefetchCount(Map<String, Object> paramMap) throws Exception;
	*/
	/*
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
	*/
	
	// lv1_app_web_chrome_autofill
	public List<Map> selectChromeAutofill(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeAutofillCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chrome_bookmarks
	public List<Map> selectChromeBookmarks(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeBookmarksCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chrome_cookies
	public List<Map> selectChromeCookies(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeCookiesCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chrome_download
	public List<Map> selectChromeDownload(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeDownloadCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chrome_favicons
	public List<Map> selectChromeFavicons(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeFaviconsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chrome_logindata
	public List<Map> selectChromeLoginData(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeLoginDataCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chrome_search_terms
	public List<Map> selectChromeSearchTerms(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeSearchTermsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chrome_shortcuts
	public List<Map> selectChromeShortcuts(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeShortcutsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chrome_top_sites
	public List<Map> selectChromeTopSites(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeTopSitesCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chrome_visit_urls
	public List<Map> selectChromeVisitUrls(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeVisitUrlsCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_app_web_chrome_domain
	public List<Map> selectChromeDomain(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeDomainCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_app_web_chrome_visit_history
	public List<Map> selectChromeVisitHistory(Map<String, Object> paramMap) throws Exception;
	public Map selectChromeVisitHistoryCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_app_web_chromium_edge_autofill
	public List<Map> selectChromiumEdgeAutofill(Map<String, Object> paramMap) throws Exception;
	public Map selectChromiumEdgeAutofillCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chromium_edge_bookmarks
	public List<Map> selectChromiumEdgeBookmarks(Map<String, Object> paramMap) throws Exception;
	public Map selectChromiumEdgeBookmarksCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chromium_edge_cookies
	public List<Map> selectChromiumEdgeCookies(Map<String, Object> paramMap) throws Exception;
	public Map selectChromiumEdgeCookiesCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chromium_edge_download
	public List<Map> selectChromiumEdgeDownload(Map<String, Object> paramMap) throws Exception;
	public Map selectChromiumEdgeDownloadCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chromium_edge_favicons
	public List<Map> selectChromiumEdgeFavicons(Map<String, Object> paramMap) throws Exception;
	public Map selectChromiumEdgeFaviconsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chromium_edge_logindata
	public List<Map> selectChromiumEdgeLogindata(Map<String, Object> paramMap) throws Exception;
	public Map selectChromiumEdgeLogindataCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chromium_edge_search_terms
	public List<Map> selectChromiumEdgeSearch(Map<String, Object> paramMap) throws Exception;
	public Map selectChromiumEdgeSearchCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chromium_edge_shortcuts
	public List<Map> selectChromiumEdgeShortcuts(Map<String, Object> paramMap) throws Exception;
	public Map selectChromiumEdgeShortcutsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chromium_edge_top_sites
	public List<Map> selectChromiumEdgeTop(Map<String, Object> paramMap) throws Exception;
	public Map selectChromiumEdgeTopCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_chromium_edge_visit_urls
	public List<Map> selectChromiumEdgeVisit(Map<String, Object> paramMap) throws Exception;
	public Map selectChromiumEdgeVisitCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_app_web_chromium_edge_visit_history
	public List<Map> selectC_EdgeVisitHistory(Map<String, Object> paramMap) throws Exception;
	public Map selectC_EdgeVisitHistoryCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_firefox_domain
	public List<Map> selectFirefoxDomain(Map<String, Object> paramMap) throws Exception;
	public Map selectFirefoxDomainCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_firefox_download
	public List<Map> selectFirefoxDownload(Map<String, Object> paramMap) throws Exception;
	public Map selectFirefoxDownloadCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_firefox_visit_history
	public List<Map> selectFirefoxVisitHistory(Map<String, Object> paramMap) throws Exception;
	public Map selectFirefoxVisitHistoryCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_firefox_visit_urls
	public List<Map> selectFirefoxVisitUrls(Map<String, Object> paramMap) throws Exception;
	public Map selectFirefoxVisitUrlsCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_app_web_firefox_bookmarks
	public List<Map> selectFirefoxBookmarks(Map<String, Object> paramMap) throws Exception;
	public Map selectFirefoxBookmarksCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_firefox_content_prefs
	public List<Map> selectFirefoxContentPrefs(Map<String, Object> paramMap) throws Exception;
	public Map selectFirefoxContentPrefsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_firefox_cookies
	public List<Map> selectFirefoxCookies(Map<String, Object> paramMap) throws Exception;
	public Map selectFirefoxCookiesCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_firefox_favicons
	public List<Map> selectFirefoxFavicons(Map<String, Object> paramMap) throws Exception;
	public Map selectFirefoxFaviconsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_firefox_formhistory
	public List<Map> selectFirefoxFormhistory(Map<String, Object> paramMap) throws Exception;
	public Map selectFirefoxFormhistoryCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_firefox_permissions
	public List<Map> selectFirefoxPermissions(Map<String, Object> paramMap) throws Exception;
	public Map selectFirefoxPermissionsCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_app_web_opera_autofill
	public List<Map> selectOperaAutofill(Map<String, Object> paramMap) throws Exception;
	public Map selectOperaAutofillCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_opera_bookmarks
	public List<Map> selectOperaBookmarks(Map<String, Object> paramMap) throws Exception;
	public Map selectOperaBookmarksCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_opera_cookies
	public List<Map> selectOperaCookies(Map<String, Object> paramMap) throws Exception;
	public Map selectOperaCookiesCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_opera_favicons
	public List<Map> selectOperaFavicons(Map<String, Object> paramMap) throws Exception;
	public Map selectOperaFaviconsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_opera_logindata
	public List<Map> selectOperaLoginData(Map<String, Object> paramMap) throws Exception;
	public Map selectOperaLoginDataCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_opera_search_terms
	public List<Map> selectOperaSearchTerms(Map<String, Object> paramMap) throws Exception;
	public Map selectOperaSearchTermsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_opera_shortcuts
	public List<Map> selectOperaShortcuts(Map<String, Object> paramMap) throws Exception;
	public Map selectOperaShortcutsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_opera_visit_urls
	public List<Map> selectOperaVisitUrls(Map<String, Object> paramMap) throws Exception;
	public Map selectOperaVisitUrlsCount(Map<String, Object> paramMap) throws Exception;


	
	// lv1_app_web_opera_download
	public List<Map> selectOperaDownload(Map<String, Object> paramMap) throws Exception;
	public Map selectOperaDownloadCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_opera_visit_history
	public List<Map> selectOperaVisitHistory(Map<String, Object> paramMap) throws Exception;
	public Map selectOperaVisitHistoryCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_app_web_whale_autofill
	public List<Map> selectWhaleAutofill(Map<String, Object> paramMap) throws Exception;
	public Map selectWhaleAutofillCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_whale_bookmarks
	public List<Map> selectWhaleBookmarks(Map<String, Object> paramMap) throws Exception;
	public Map selectWhaleBookmarksCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_whale_cookies
	public List<Map> selectWhaleCookies(Map<String, Object> paramMap) throws Exception;
	public Map selectWhaleCookiesCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_whale_download
	public List<Map> selectWhaleDownload(Map<String, Object> paramMap) throws Exception;
	public Map selectWhaleDownloadCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_whale_favicons
	public List<Map> selectWhaleFavicons(Map<String, Object> paramMap) throws Exception;
	public Map selectWhaleFaviconsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_whale_logindata
	public List<Map> selectWhaleLogindata(Map<String, Object> paramMap) throws Exception;
	public Map selectWhaleLogindataCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_whale_search_terms
	public List<Map> selectWhaleSearchTerms(Map<String, Object> paramMap) throws Exception;
	public Map selectWhaleSearchTermsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_whale_shortcuts
	public List<Map> selectWhaleShortcuts(Map<String, Object> paramMap) throws Exception;
	public Map selectWhaleShortcutsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_whale_top_sites
	public List<Map> selectWhaleTopSites(Map<String, Object> paramMap) throws Exception;
	public Map selectWhaleTopSitesCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_whale_visit_urls
	public List<Map> selectWhaleVisitUrls(Map<String, Object> paramMap) throws Exception;
	public Map selectWhaleVisitUrlsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_web_whale_visit_history
	public List<Map> selectWhaleVisitHistory(Map<String, Object> paramMap) throws Exception;
	public Map selectWhaleVisitHistoryCount(Map<String, Object> paramMap) throws Exception;

	
	/*
	// lv1_fs_ntfs_logfile
	public List<Map> selectNtfsLogfile(Map<String, Object> paramMap) throws Exception;
	public Map selectNtfsLogfileCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_fs_ntfs_usnjrnl
	public List<Map> selectNtfsUsnjrnl(Map<String, Object> paramMap) throws Exception;
	public Map selectNtfsUsnjrnlCount(Map<String, Object> paramMap) throws Exception;
	*/
	
	// lv2_os_app_history
	public List<Map> selectAppHistory(Map<String, Object> paramMap) throws Exception;
	public Map selectAppHistoryCount(Map<String, Object> paramMap) throws Exception;
	
	
	// lv1_os_win_notification
	public List<Map> selectNotification(Map<String, Object> paramMap) throws Exception;
	public Map selectNotificationCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_prefetch
	public List<Map> selectPrefetch(Map<String, Object> paramMap) throws Exception;
	public Map selectPrefetchCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_prefetch_run_info
	public List<Map> selectPrefetchRunInfo(Map<String, Object> paramMap) throws Exception;
	public Map selectPrefetchRunInfoCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_prefetch_volume_info
	public List<Map> selectPrefetchVolumeInfo(Map<String, Object> paramMap) throws Exception;
	public Map selectPrefetchVolumeInfoCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_recyclebin
	public List<Map> selectRecycleBin(Map<String, Object> paramMap) throws Exception;
	public Map selectRecycleBinCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_sticky_note
	public List<Map> selectStickyNote(Map<String, Object> paramMap) throws Exception;
	public Map selectStickyNoteCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_windows_timeline
	public List<Map> selectWindowsTimeline(Map<String, Object> paramMap) throws Exception;
	public Map selectWindowsTimelineCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_filehistory_file
	public List<Map> selectFile(Map<String, Object> paramMap) throws Exception;
	public Map selectFileCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_filehistory_namespace
	public List<Map> selectNamespace(Map<String, Object> paramMap) throws Exception;
	public Map selectNamespaceCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_filehistory_string
	public List<Map> selectString(Map<String, Object> paramMap) throws Exception;
	public Map selectStringCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_jumplist_custom
	public List<Map> selectJumplistCustom(Map<String, Object> paramMap) throws Exception;
	public Map selectJumplistCustomCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_link
	public List<Map> selectLNKFile(Map<String, Object> paramMap) throws Exception;
	public Map selectLNKFileCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_searchdb_gthr
	public List<Map> selectSearchDBGthr(Map<String, Object> paramMap) throws Exception;
	public Map selectSearchDBGthrCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_searchdb_gthrpth
	public List<Map> selectSearchDBGthrPth(Map<String, Object> paramMap) throws Exception;
	public Map selectSearchDBGthrPthCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_superfetch
	public List<Map> selectSuperfetch(Map<String, Object> paramMap) throws Exception;
	public Map selectSuperfetchCount(Map<String, Object> paramMap) throws Exception;


	
	// lv1_app_kakaotalk_new_chatLogs
	public List<Map> selectKakaotalkNewChatlogs(Map<String, Object> paramMap) throws Exception;
	public Map selectKakaotalkNewChatlogsCount(Map<String, Object> paramMap) throws Exception;

	
	// lv1_app_kakaotalk_chatLogs
	public List<Map> selectKakaotalkChatlogs(Map<String, Object> paramMap) throws Exception;
	public Map selectKakaotalkChatlogsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_kakaotalk_chatLog_attachment
	public List<Map> selectKakaotalkChatlogAttachment(Map<String, Object> paramMap) throws Exception;
	public Map selectKakaotalkChatlogAttachmentCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_kakaotalk_chatLogDrafts
	public List<Map> selectKakaotalkChatlogDrafts(Map<String, Object> paramMap) throws Exception;
	public Map selectKakaotalkChatlogDraftsCount(Map<String, Object> paramMap) throws Exception;
	
	
	// lv1_fs_ntfs_logfile_log_record
	public List<Map> selectLogRecord(Map<String, Object> paramMap) throws Exception;
	public Map selectLogRecordCount(Map<String, Object> paramMap) throws Exception;

	// lv1_fs_ntfs_logfile_restart_area
	public List<Map> selectRestartArea(Map<String, Object> paramMap) throws Exception;
	public Map selectRestartAreaCount(Map<String, Object> paramMap) throws Exception;

	// lv1_fs_ntfs_mft
	public List<Map> selectMFT(Map<String, Object> paramMap) throws Exception;
	public Map selectMFTCount(Map<String, Object> paramMap) throws Exception;

	// lv1_fs_ntfs_usnjrnl
	public List<Map> selectUsnJrnl(Map<String, Object> paramMap) throws Exception;
	public Map selectUsnJrnlCount(Map<String, Object> paramMap) throws Exception;


	// lv1_app_kakaotalk_mobile_chatlogs
	public List<Map> selectKakaotalkMobileChatlogs(Map<String, Object> paramMap) throws Exception;
	public Map selectKakaotalkMobileChatlogsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_kakaotalk_mobile_chatrooms
	public List<Map> selectKakaotalkMobileChatrooms(Map<String, Object> paramMap) throws Exception;
	public Map selectKakaotalkMobileChatroomsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_app_kakaotalk_mobile_friends
	public List<Map> selectKakaotalkMobileFriends(Map<String, Object> paramMap) throws Exception;
	public Map selectKakaotalkMobileFriendsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_app_list
	public List<Map> selectAppList(Map<String, Object> paramMap) throws Exception;
	public Map selectAppListCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_call_history
	public List<Map> selectCallHistory(Map<String, Object> paramMap) throws Exception;
	public Map selectCallHistoryCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_emb_file
	public List<Map> selectEmbFile(Map<String, Object> paramMap) throws Exception;
	public Map selectEmbFileCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_file_history
	public List<Map> selectFileHistory(Map<String, Object> paramMap) throws Exception;
	public Map selectFileHistoryCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_geodata
	public List<Map> selectGeodata(Map<String, Object> paramMap) throws Exception;
	public Map selectGeodataCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_id_pw_hash
	public List<Map> selectIdpwhash(Map<String, Object> paramMap) throws Exception;
	public Map selectIdpwhashCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_web_browser_history
	public List<Map> selectWebBrowserHistory(Map<String, Object> paramMap) throws Exception;
	public Map selectWebBrowserHistoryCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_icon_cache
	public List<Map> selectIconCache(Map<String, Object> paramMap) throws Exception;
	public Map selectIconCacheCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_jumplist_automatics
	public List<Map> selectJumplistAutomatics(Map<String, Object> paramMap) throws Exception;
	public Map selectJumplistAutomaticsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_win_thumbnail_cache
	public List<Map> selectThumbnailCache(Map<String, Object> paramMap) throws Exception;
	public Map selectThumbnailCacheCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_basic_app_accounts_ce_0
	public List<Map> selectAccountsCE0(Map<String, Object> paramMap) throws Exception;
	public Map selectAccountsCE0Count(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_basic_app_accounts_de_0
	public List<Map> selectAccountsDE0(Map<String, Object> paramMap) throws Exception;
	public Map selectAccountsDE0Count(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_basic_app_call_logs
	public List<Map> selectCallLogs(Map<String, Object> paramMap) throws Exception;
	public Map selectCallLogsCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_basic_app_file_cache
	public List<Map> selectFileCache(Map<String, Object> paramMap) throws Exception;
	public Map selectFileCacheCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_basic_app_mms
	public List<Map> selectMMS(Map<String, Object> paramMap) throws Exception;
	public Map selectMMSCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_basic_app_recent_files
	public List<Map> selectRecentFiles(Map<String, Object> paramMap) throws Exception;
	public Map selectRecentFilesCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_basic_app_sim_info
	public List<Map> selectSimInfo(Map<String, Object> paramMap) throws Exception;
	public Map selectSimInfoCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_basic_app_sim_info_dat
	public List<Map> selectSimInfoDat(Map<String, Object> paramMap) throws Exception;
	public Map selectSimInfoDatCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_basic_app_sms
	public List<Map> selectSMS(Map<String, Object> paramMap) throws Exception;
	public Map selectSMSCount(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_basic_app_usagestats_0
	public List<Map> selectUsagestats0(Map<String, Object> paramMap) throws Exception;
	public Map selectUsagestats0Count(Map<String, Object> paramMap) throws Exception;

	// lv1_os_and_basic_app_wifi_info
	public List<Map> selectWifiInfo(Map<String, Object> paramMap) throws Exception;
	public Map selectWifiInfoCount(Map<String, Object> paramMap) throws Exception;


}