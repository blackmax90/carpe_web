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
	
	// lv1_win_os_reg_userassist
	public List<Map> selectRegUserAssist(Map<String, Object> paramMap) throws Exception;
	public Map selectRegUserAssistCount(Map<String, Object> paramMap) throws Exception;
	
	// lv1_os_win_lnk_files
	public List<Map> selectLnkFiles(Map<String, Object> paramMap) throws Exception;
	public Map selectLnkFilesCount(Map<String, Object> paramMap) throws Exception;
	
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

	// lv1_os_win_thumbnail_cache
	public List<Map> selectThumbnailCache(Map<String, Object> paramMap) throws Exception;
	public Map selectThumbnailCacheCount(Map<String, Object> paramMap) throws Exception;


	// lv1_os_win_jumplist_automatics
	public List<Map> selectJumplistAutomatics(Map<String, Object> paramMap) throws Exception;
	public Map selectJumplistAutomaticsCount(Map<String, Object> paramMap) throws Exception;
}