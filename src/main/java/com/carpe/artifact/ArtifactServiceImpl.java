package com.carpe.artifact;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class ArtifactServiceImpl implements ArtifactService {

	@Inject
	private ArtifactDAO dao;

	// Plaso Result
	@Override
	public List<Map> selectSystemLogOverviewList(Map<String, Object> paramMap) throws Exception {
		return dao.selectSystemLogOverviewList(paramMap);
	}

	@Override
	public Map selectSystemLogOverviewListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectSystemLogOverviewListCount(paramMap);
	}

	// Operating System
	@Override
	public List<Map> selectOSInstallationList(Map<String, Object> paramMap) throws Exception {
		return dao.selectOSInstallationList(paramMap);
	}

	@Override
	public Map selectOSInstallationListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectOSInstallationListCount(paramMap);
	}

	// Windows Storage Device
	public List<Map> selectStorageDeviceList(Map<String, Object> paramMap) throws Exception {
		return dao.selectStorageDeviceList(paramMap);
	}

	@Override
	public Map selectStorageDeviceListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectStorageDeviceListCount(paramMap);
	}

	// Installed Application
	public List<Map> selectInstalledAppList(Map<String, Object> paramMap) throws Exception {
		return dao.selectInstalledAppList(paramMap);
	}

	@Override
	public Map selectInstalledAppListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectInstalledAppListCount(paramMap);
	}

	// Web History
	public List<Map> selectWebHistoryList(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebHistoryList(paramMap);
	}

	@Override
	public Map selectWebHistoryListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebHistoryListCount(paramMap);
	}

	// Web Download
	public List<Map> selectWebDownloadList(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebDownloadList(paramMap);
	}

	@Override
	public Map selectWebDownloadListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebDownloadListCount(paramMap);
	}

	// Web Cache
	public List<Map> selectWebCacheList(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebCacheList(paramMap);
	}

	@Override
	public Map selectWebCacheListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebCacheListCount(paramMap);
	}

	// Web Cookie
	public List<Map> selectWebCookieList(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebCookieList(paramMap);
	}

	@Override
	public Map selectWebCookieListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebCookieListCount(paramMap);
	}

	@Override
	public List<Map> selectTimelineList(Map<String, Object> paramMap) throws Exception {
		return dao.selectTimelineList(paramMap);
	}

	// lv1
	// lv1_os_win_event_logs
	@Override
	public List<Map> selectEventLogsList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsList(paramMap);
	}

	@Override
	public Map selectEventLogsListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsListCount(paramMap);
	}

	// lv1_os_win_event_logs_antiforensics
	@Override
	public List<Map> selectEventLogsAntiforensicsList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsAntiforensicsList(paramMap);
	}

	@Override
	public Map selectEventLogsAntiforensicsListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsAntiforensicsListCount(paramMap);
	}

	// lv1_os_win_event_logs_applications
	@Override
	public List<Map> selectEventLogsApplicationsList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsApplicationsList(paramMap);
	}

	@Override
	public Map selectEventLogsApplicationsListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsApplicationsListCount(paramMap);
	}

	// lv1_os_win_event_logs_dns
	@Override
	public List<Map> selectEventLogsDNSList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsDNSList(paramMap);
	}

	@Override
	public Map selectEventLogsDNSListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsDNSListCount(paramMap);
	}

	// lv1_os_win_event_logs_file_handling
	@Override
	public List<Map> selectEventLogsFileHandlingList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsFileHandlingList(paramMap);
	}

	@Override
	public Map selectEventLogsFileHandlingListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsFileHandlingListCount(paramMap);
	}

	// lv1_os_win_event_logs_logonoff
	@Override
	public List<Map> selectEventLogsLogonoffList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsLogonoffList(paramMap);
	}

	@Override
	public Map selectEventLogsLogonoffListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsLogonoffListCount(paramMap);
	}

	// lv1_os_win_event_logs_ms_alerts
	@Override
	public List<Map> selectEventLogsMsAlertsList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsMsAlertsList(paramMap);
	}

	@Override
	public Map selectEventLogsMsAlertsListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsMsAlertsListCount(paramMap);
	}

	// lv1_os_win_event_logs_msi_installer
	@Override
	public List<Map> selectEventLogsMsiInstallerList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsMsiInstallerList(paramMap);
	}

	@Override
	public Map selectEventLogsMsiInstallerListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsMsiInstallerListCount(paramMap);
	}

	// lv1_os_win_event_logs_network
	@Override
	public List<Map> selectEventLogsNetworkList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsNetworkList(paramMap);
	}

	@Override
	public Map selectEventLogsNetworkListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsNetworkListCount(paramMap);
	}

	// lv1_os_win_event_logs_others
	@Override
	public List<Map> selectEventLogsOthersList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsOthersList(paramMap);
	}

	@Override
	public Map selectEventLogsOthersListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsOthersListCount(paramMap);
	}

	// lv1_os_win_event_logs_pconoff
	@Override
	public List<Map> selectEventLogsPConoffList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsPConoffList(paramMap);
	}

	@Override
	public Map selectEventLogsPConoffListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsPConoffListCount(paramMap);
	}

	// lv1_os_win_event_logs_printer
	@Override
	public List<Map> selectEventLogsPrinterList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsPrinterList(paramMap);
	}

	@Override
	public Map selectEventLogsPrinterListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsPrinterListCount(paramMap);
	}

	// lv1_os_win_event_logs_process
	@Override
	public List<Map> selectEventLogsProcessList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsProcessList(paramMap);
	}

	@Override
	public Map selectEventLogsProcessListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsProcessListCount(paramMap);
	}

	// lv1_os_win_event_logs_registry_handling
	@Override
	public List<Map> selectEventLogsRegistryHandlingList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsRegistryHandlingList(paramMap);
	}

	@Override
	public Map selectEventLogsRegistryHandlingListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsRegistryHandlingListCount(paramMap);
	}

	// lv1_os_win_event_logs_remoteonoff
	@Override
	public List<Map> selectEventLogsRemoteonoffList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsRemoteonoffList(paramMap);
	}

	@Override
	public Map selectEventLogsRemoteonoffListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsRemoteonoffListCount(paramMap);
	}

	// lv1_os_win_event_logs_screen_saver
	@Override
	public List<Map> selectEventLogsScreenSaverList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsScreenSaverList(paramMap);
	}

	@Override
	public Map selectEventLogsScreenSaverListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsScreenSaverListCount(paramMap);
	}

	// lv1_os_win_event_logs_shared_folder
	@Override
	public List<Map> selectEventLogsSharedFolderList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsSharedFolderList(paramMap);
	}

	@Override
	public Map selectEventLogsSharedFolderListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsSharedFolderListCount(paramMap);
	}

	// lv1_os_win_event_logs_sleeponoff
	@Override
	public List<Map> selectEventLogsSleeponoffList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsSleeponoffList(paramMap);
	}

	@Override
	public Map selectEventLogsSleeponoffListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsSleeponoffListCount(paramMap);
	}

	// lv1_os_win_event_logs_telemetry
	@Override
	public List<Map> selectEventLogsTelemetryList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsTelemetryList(paramMap);
	}

	@Override
	public Map selectEventLogsTelemetryListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsTelemetryListCount(paramMap);
	}

	// lv1_os_win_event_logs_time_changed
	@Override
	public List<Map> selectEventLogsTimeChangedList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsTimeChangedList(paramMap);
	}

	@Override
	public Map selectEventLogsTimeChangedListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsTimeChangedListCount(paramMap);
	}

	// lv1_os_win_event_logs_usb_devices
	@Override
	public List<Map> selectEventLogsUsbDevicesList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsUsbDevicesList(paramMap);
	}

	@Override
	public Map selectEventLogsUsbDevicesListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEventLogsUsbDevicesListCount(paramMap);
	}

	// lv1_os_win_jumplist
	@Override
	public List<Map> selectJumplistList(Map<String, Object> paramMap) throws Exception {
		return dao.selectJumplistList(paramMap);
	}

	@Override
	public Map selectJumplistListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectJumplistListCount(paramMap);
	}

	// lv1_os_win_reg_amcache_file_entries
	@Override
	public List<Map> selectRegAmcacheFileEntriesList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegAmcacheFileEntriesList(paramMap);
	}

	@Override
	public Map selectRegAmcacheFileEntriesListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegAmcacheFileEntriesListCount(paramMap);
	}

	// lv1_os_win_reg_amcache_program_entries
	@Override
	public List<Map> selectRegAmcacheProgramEntriesList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegAmcacheProgramEntriesList(paramMap);
	}

	@Override
	public Map selectRegAmcacheProgramEntriesListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegAmcacheProgramEntriesListCount(paramMap);
	}

	// lv1_os_win_reg_installed_programs
	@Override
	public List<Map> selectRegInstalledProgramsList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegInstalledProgramsList(paramMap);
	}

	@Override
	public Map selectRegInstalledProgramsListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegInstalledProgramsListCount(paramMap);
	}

	// lv1_os_win_reg_os_info
	@Override
	public List<Map> selectRegOSInfoList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegOSInfoList(paramMap);
	}

	@Override
	public Map selectRegOSInfoListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegOSInfoListCount(paramMap);
	}

	// lv1_os_win_reg_usb_devices
	@Override
	public List<Map> selectRegUSBDevicesList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegUSBDevicesList(paramMap);
	}

	@Override
	public Map selectRegUSBDevicesListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegUSBDevicesListCount(paramMap);
	}

	// lv1_os_win_reg_user_accounts
	@Override
	public List<Map> selectRegUserAccountsList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegUserAccountsList(paramMap);
	}

	@Override
	public Map selectRegUserAccountsListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegUserAccountsListCount(paramMap);
	}

	// lv1_os_win_reg_file_connection
	@Override
	public List<Map> selectRegFileConnection(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegFileConnection(paramMap);
	}

	@Override
	public Map selectRegFileConnectionCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegFileConnectionCount(paramMap);
	}

	// lv1_os_win_reg_known_dll
	@Override
	public List<Map> selectRegKnownDll(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegKnownDll(paramMap);
	}

	@Override
	public Map selectRegKnownDllCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegKnownDllCount(paramMap);
	}

	// lv1_os_win_reg_mac_address
	@Override
	public List<Map> selectRegMacAddress(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegMacAddress(paramMap);
	}

	@Override
	public Map selectRegMacAddressCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegMacAddressCount(paramMap);
	}

	// lv1_os_win_reg_mru_folder
	@Override
	public List<Map> selectRegMruFolder(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegMruFolder(paramMap);
	}

	@Override
	public Map selectRegMruFolderCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegMruFolderCount(paramMap);
	}

	// lv1_os_win_reg_mru_file
	@Override
	public List<Map> selectMRUFile(Map<String, Object> paramMap) throws Exception {
		return dao.selectMRUFile(paramMap);
	}

	@Override
	public Map selectMRUFileCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectMRUFileCount(paramMap);
	}

	// lv1_os_win_reg_mui_cache
	@Override
	public List<Map> selectRegMuiCache(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegMuiCache(paramMap);
	}

	@Override
	public Map selectRegMuiCacheCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegMuiCacheCount(paramMap);
	}

	// lv1_os_win_reg_network_drive
	@Override
	public List<Map> selectRegNetworkDrive(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegNetworkDrive(paramMap);
	}

	@Override
	public Map selectRegNetworkDriveCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegNetworkDriveCount(paramMap);
	}

	// lv1_os_win_reg_network_interface
	@Override
	public List<Map> selectRegNetworkInterface(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegNetworkInterface(paramMap);
	}

	@Override
	public Map selectRegNetworkInterfaceCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegNetworkInterfaceCount(paramMap);
	}

	// lv1_os_win_reg_network_profile
	@Override
	public List<Map> selectRegNetworkProfile(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegNetworkProfile(paramMap);
	}

	@Override
	public Map selectRegNetworkProfileCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegNetworkProfileCount(paramMap);
	}

	// lv1_os_win_reg_recent_docs
	@Override
	public List<Map> selectRegRecentDocs(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegRecentDocs(paramMap);
	}

	@Override
	public Map selectRegRecentDocsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegRecentDocsCount(paramMap);
	}

	// lv1_os_win_reg_run_command
	@Override
	public List<Map> selectRegRunCommand(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegRunCommand(paramMap);
	}

	@Override
	public Map selectRegRunCommandCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegRunCommandCount(paramMap);
	}

	// lv1_os_win_reg_search_keyword
	@Override
	public List<Map> selectRegSearchKeyword(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegSearchKeyword(paramMap);
	}

	@Override
	public Map selectRegSearchKeywordCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegSearchKeywordCount(paramMap);
	}

	// lv1_os_win_reg_shellbag
	@Override
	public List<Map> selectShellbag(Map<String, Object> paramMap) throws Exception {
		return dao.selectShellbag(paramMap);
	}

	@Override
	public Map selectShellbagCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectShellbagCount(paramMap);
	}

	// lv1_os_win_reg_shim_cache
	@Override
	public List<Map> selectRegShimCache(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegShimCache(paramMap);
	}

	@Override
	public Map selectRegShimCacheCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegShimCacheCount(paramMap);
	}

	// lv1_os_win_reg_start_list
	@Override
	public List<Map> selectRegStartList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegStartList(paramMap);
	}

	@Override
	public Map selectRegStartListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegStartListCount(paramMap);
	}

	// lv1_os_win_reg_system_service
	@Override
	public List<Map> selectRegSystemService(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegSystemService(paramMap);
	}

	@Override
	public Map selectRegSystemServiceCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegSystemServiceCount(paramMap);
	}

	// lv1_app_web_chrome_visit_urls
	@Override
	public List<Map> selectChromeVisitUrlsList(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeVisitUrlsList(paramMap);
	}

	@Override
	public Map selectChromeVisitUrlsListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeVisitUrlsListCount(paramMap);
	}

	// lv1_os_win_reg_userassist
	@Override
	public List<Map> selectRegUserAssist(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegUserAssist(paramMap);
	}

	@Override
	public Map selectRegUserAssistCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegUserAssistCount(paramMap);
	}

	/*
	 * 
	 * // lv1_os_win_lnk_files
	 * 
	 * @Override public List<Map> selectLnkFiles(Map<String, Object> paramMap)
	 * throws Exception { return dao.selectLnkFiles(paramMap); }
	 * 
	 * @Override public Map selectLnkFilesCount(Map<String, Object> paramMap) throws
	 * Exception { return dao.selectLnkFilesCount(paramMap); }
	 */
	/*
	 * // lv1_os_win_prefetch
	 * 
	 * @Override public List<Map> selectPrefetch(Map<String, Object> paramMap)
	 * throws Exception { return dao.selectPrefetch(paramMap); }
	 * 
	 * @Override public Map selectPrefetchCount(Map<String, Object> paramMap) throws
	 * Exception { return dao.selectPrefetchCount(paramMap); }
	 */
	/*
	 * // lv1_app_web_chrome_download
	 * 
	 * @Override public List<Map> selectChromeDownload(Map<String, Object> paramMap)
	 * throws Exception { return dao.selectChromeDownload(paramMap); }
	 * 
	 * @Override public Map selectChromeDownloadCount(Map<String, Object> paramMap)
	 * throws Exception { return dao.selectChromeDownloadCount(paramMap); }
	 * 
	 * // lv1_app_web_chrome_cookies
	 * 
	 * @Override public List<Map> selectChromeCookie(Map<String, Object> paramMap)
	 * throws Exception { return dao.selectChromeCookie(paramMap); }
	 * 
	 * @Override public Map selectChromeCookieCount(Map<String, Object> paramMap)
	 * throws Exception { return dao.selectChromeCookieCount(paramMap); }
	 * 
	 * // lv1_app_web_chrome_cache
	 * 
	 * @Override public List<Map> selectChromeCache(Map<String, Object> paramMap)
	 * throws Exception { return dao.selectChromeCache(paramMap); }
	 * 
	 * @Override public Map selectChromeCacheCount(Map<String, Object> paramMap)
	 * throws Exception { return dao.selectChromeCacheCount(paramMap); }
	 * 
	 * // lv1_app_web_chrome_search_terms
	 * 
	 * @Override public List<Map> selectChromeSearchTerms(Map<String, Object>
	 * paramMap) throws Exception { return dao.selectChromeSearchTerms(paramMap); }
	 * 
	 * @Override public Map selectChromeSearchTermsCount(Map<String, Object>
	 * paramMap) throws Exception { return
	 * dao.selectChromeSearchTermsCount(paramMap); }
	 */
	// lv1_app_web_chrome_autofill
	@Override
	public List<Map> selectChromeAutofill(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeAutofill(paramMap);
	}

	@Override
	public Map selectChromeAutofillCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeAutofillCount(paramMap);
	}

	// lv1_app_web_chrome_bookmarks
	@Override
	public List<Map> selectChromeBookmarks(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeBookmarks(paramMap);
	}

	@Override
	public Map selectChromeBookmarksCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeBookmarksCount(paramMap);
	}

	// lv1_app_web_chrome_cookies
	@Override
	public List<Map> selectChromeCookies(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeCookies(paramMap);
	}

	@Override
	public Map selectChromeCookiesCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeCookiesCount(paramMap);
	}

	// lv1_app_web_chrome_download
	@Override
	public List<Map> selectChromeDownload(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeDownload(paramMap);
	}

	@Override
	public Map selectChromeDownloadCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeDownloadCount(paramMap);
	}

	// lv1_app_web_chrome_favicons
	@Override
	public List<Map> selectChromeFavicons(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeFavicons(paramMap);
	}

	@Override
	public Map selectChromeFaviconsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeFaviconsCount(paramMap);
	}

	// lv1_app_web_chrome_logindata
	@Override
	public List<Map> selectChromeLoginData(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeLoginData(paramMap);
	}

	@Override
	public Map selectChromeLoginDataCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeLoginDataCount(paramMap);
	}

	// lv1_app_web_chrome_search_terms
	@Override
	public List<Map> selectChromeSearchTerms(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeSearchTerms(paramMap);
	}

	@Override
	public Map selectChromeSearchTermsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeSearchTermsCount(paramMap);
	}

	// lv1_app_web_chrome_shortcuts
	@Override
	public List<Map> selectChromeShortcuts(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeShortcuts(paramMap);
	}

	@Override
	public Map selectChromeShortcutsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeShortcutsCount(paramMap);
	}

	// lv1_app_web_chrome_top_sites
	@Override
	public List<Map> selectChromeTopSites(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeTopSites(paramMap);
	}

	@Override
	public Map selectChromeTopSitesCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeTopSitesCount(paramMap);
	}

	// lv1_app_web_chrome_visit_urls
	@Override
	public List<Map> selectChromeVisitUrls(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeVisitUrls(paramMap);
	}

	@Override
	public Map selectChromeVisitUrlsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeVisitUrlsCount(paramMap);
	}

	// lv1_app_web_chrome_domain
	@Override
	public List<Map> selectChromeDomain(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeDomain(paramMap);
	}

	@Override
	public Map selectChromeDomainCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeDomainCount(paramMap);
	}
	
	// lv1_app_web_chrome_visit_history
	@Override
	public List<Map> selectChromeVisitHistory(Map<String, Object> paramMap) throws Exception {
	    return dao.selectChromeVisitHistory(paramMap);
	}

	@Override
	public Map selectChromeVisitHistoryCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectChromeVisitHistoryCount(paramMap);
	}
	
	// lv1_app_web_chromium_edge_autofill
	@Override
	public List<Map> selectChromiumEdgeAutofill(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeAutofill(paramMap);
	}

	@Override
	public Map selectChromiumEdgeAutofillCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeAutofillCount(paramMap);
	}

	// lv1_app_web_chromium_edge_bookmarks
	@Override
	public List<Map> selectChromiumEdgeBookmarks(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeBookmarks(paramMap);
	}

	@Override
	public Map selectChromiumEdgeBookmarksCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeBookmarksCount(paramMap);
	}

	// lv1_app_web_chromium_edge_cookies
	@Override
	public List<Map> selectChromiumEdgeCookies(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeCookies(paramMap);
	}

	@Override
	public Map selectChromiumEdgeCookiesCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeCookiesCount(paramMap);
	}

	// lv1_app_web_chromium_edge_download
	@Override
	public List<Map> selectChromiumEdgeDownload(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeDownload(paramMap);
	}

	@Override
	public Map selectChromiumEdgeDownloadCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeDownloadCount(paramMap);
	}

	// lv1_app_web_chromium_edge_favicons
	@Override
	public List<Map> selectChromiumEdgeFavicons(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeFavicons(paramMap);
	}

	@Override
	public Map selectChromiumEdgeFaviconsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeFaviconsCount(paramMap);
	}

	// lv1_app_web_chromium_edge_logindata
	@Override
	public List<Map> selectChromiumEdgeLogindata(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeLogindata(paramMap);
	}

	@Override
	public Map selectChromiumEdgeLogindataCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeLogindataCount(paramMap);
	}

	// lv1_app_web_chromium_edge_search_terms
	@Override
	public List<Map> selectChromiumEdgeSearch(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeSearch(paramMap);
	}

	@Override
	public Map selectChromiumEdgeSearchCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeSearchCount(paramMap);
	}

	// lv1_app_web_chromium_edge_shortcuts
	@Override
	public List<Map> selectChromiumEdgeShortcuts(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeShortcuts(paramMap);
	}

	@Override
	public Map selectChromiumEdgeShortcutsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeShortcutsCount(paramMap);
	}

	// lv1_app_web_chromium_edge_top_sites
	@Override
	public List<Map> selectChromiumEdgeTop(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeTop(paramMap);
	}

	@Override
	public Map selectChromiumEdgeTopCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeTopCount(paramMap);
	}

	// lv1_app_web_chromium_edge_visit_urls
	@Override
	public List<Map> selectChromiumEdgeVisit(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeVisit(paramMap);
	}

	@Override
	public Map selectChromiumEdgeVisitCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromiumEdgeVisitCount(paramMap);
	}
	
	// lv1_app_web_chromium_edge_visit_history
	@Override
	public List<Map> selectC_EdgeVisitHistory(Map<String, Object> paramMap) throws Exception {
	    return dao.selectC_EdgeVisitHistory(paramMap);
	}

	@Override
	public Map selectC_EdgeVisitHistoryCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectC_EdgeVisitHistoryCount(paramMap);
	}

	// lv1_app_web_firefox_domain
	@Override
	public List<Map> selectFirefoxDomain(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxDomain(paramMap);
	}

	@Override
	public Map selectFirefoxDomainCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxDomainCount(paramMap);
	}

	// lv1_app_web_firefox_download
	@Override
	public List<Map> selectFirefoxDownload(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxDownload(paramMap);
	}

	@Override
	public Map selectFirefoxDownloadCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxDownloadCount(paramMap);
	}

	// lv1_app_web_firefox_visit_history
	@Override
	public List<Map> selectFirefoxVisitHistory(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxVisitHistory(paramMap);
	}

	@Override
	public Map selectFirefoxVisitHistoryCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxVisitHistoryCount(paramMap);
	}

	// lv1_app_web_firefox_visit_urls
	@Override
	public List<Map> selectFirefoxVisitUrls(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxVisitUrls(paramMap);
	}

	@Override
	public Map selectFirefoxVisitUrlsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxVisitUrlsCount(paramMap);
	}

	// lv1_app_web_firefox_bookmarks
	@Override
	public List<Map> selectFirefoxBookmarks(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxBookmarks(paramMap);
	}

	@Override
	public Map selectFirefoxBookmarksCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxBookmarksCount(paramMap);
	}

	// lv1_app_web_firefox_content_prefs
	@Override
	public List<Map> selectFirefoxContentPrefs(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxContentPrefs(paramMap);
	}

	@Override
	public Map selectFirefoxContentPrefsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxContentPrefsCount(paramMap);
	}

	// lv1_app_web_firefox_cookies
	@Override
	public List<Map> selectFirefoxCookies(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxCookies(paramMap);
	}

	@Override
	public Map selectFirefoxCookiesCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxCookiesCount(paramMap);
	}

	// lv1_app_web_firefox_favicons
	@Override
	public List<Map> selectFirefoxFavicons(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxFavicons(paramMap);
	}

	@Override
	public Map selectFirefoxFaviconsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxFaviconsCount(paramMap);
	}

	// lv1_app_web_firefox_formhistory
	@Override
	public List<Map> selectFirefoxFormhistory(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxFormhistory(paramMap);
	}

	@Override
	public Map selectFirefoxFormhistoryCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxFormhistoryCount(paramMap);
	}

	// lv1_app_web_firefox_permissions
	@Override
	public List<Map> selectFirefoxPermissions(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxPermissions(paramMap);
	}

	@Override
	public Map selectFirefoxPermissionsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFirefoxPermissionsCount(paramMap);
	}
	
	// lv1_app_web_opera_autofill
	@Override
	public List<Map> selectOperaAutofill(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaAutofill(paramMap);
	}

	@Override
	public Map selectOperaAutofillCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaAutofillCount(paramMap);
	}

	// lv1_app_web_opera_bookmarks
	@Override
	public List<Map> selectOperaBookmarks(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaBookmarks(paramMap);
	}

	@Override
	public Map selectOperaBookmarksCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaBookmarksCount(paramMap);
	}

	// lv1_app_web_opera_cookies
	@Override
	public List<Map> selectOperaCookies(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaCookies(paramMap);
	}

	@Override
	public Map selectOperaCookiesCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaCookiesCount(paramMap);
	}

	// lv1_app_web_opera_favicons
	@Override
	public List<Map> selectOperaFavicons(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaFavicons(paramMap);
	}

	@Override
	public Map selectOperaFaviconsCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaFaviconsCount(paramMap);
	}

	// lv1_app_web_opera_logindata
	@Override
	public List<Map> selectOperaLoginData(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaLoginData(paramMap);
	}

	@Override
	public Map selectOperaLoginDataCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaLoginDataCount(paramMap);
	}

	// lv1_app_web_opera_search_terms
	@Override
	public List<Map> selectOperaSearchTerms(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaSearchTerms(paramMap);
	}

	@Override
	public Map selectOperaSearchTermsCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaSearchTermsCount(paramMap);
	}

	// lv1_app_web_opera_shortcuts
	@Override
	public List<Map> selectOperaShortcuts(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaShortcuts(paramMap);
	}

	@Override
	public Map selectOperaShortcutsCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaShortcutsCount(paramMap);
	}

	// lv1_app_web_opera_visit_urls
	@Override
	public List<Map> selectOperaVisitUrls(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaVisitUrls(paramMap);
	}

	@Override
	public Map selectOperaVisitUrlsCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaVisitUrlsCount(paramMap);
	}


	
	// lv1_app_web_opera_download
	@Override
	public List<Map> selectOperaDownload(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaDownload(paramMap);
	}

	@Override
	public Map selectOperaDownloadCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaDownloadCount(paramMap);
	}

	// lv1_app_web_opera_visit_history
	@Override
	public List<Map> selectOperaVisitHistory(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaVisitHistory(paramMap);
	}
	

	@Override
	public Map selectOperaVisitHistoryCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectOperaVisitHistoryCount(paramMap);
	}
	
	// lv1_app_web_whale_autofill
	@Override
	public List<Map> selectWhaleAutofill(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleAutofill(paramMap);
	}

	@Override
	public Map selectWhaleAutofillCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleAutofillCount(paramMap);
	}

	// lv1_app_web_whale_bookmarks
	@Override
	public List<Map> selectWhaleBookmarks(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleBookmarks(paramMap);
	}

	@Override
	public Map selectWhaleBookmarksCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleBookmarksCount(paramMap);
	}

	// lv1_app_web_whale_cookies
	@Override
	public List<Map> selectWhaleCookies(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleCookies(paramMap);
	}

	@Override
	public Map selectWhaleCookiesCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleCookiesCount(paramMap);
	}

	// lv1_app_web_whale_download
	@Override
	public List<Map> selectWhaleDownload(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleDownload(paramMap);
	}

	@Override
	public Map selectWhaleDownloadCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleDownloadCount(paramMap);
	}

	// lv1_app_web_whale_favicons
	@Override
	public List<Map> selectWhaleFavicons(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleFavicons(paramMap);
	}

	@Override
	public Map selectWhaleFaviconsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleFaviconsCount(paramMap);
	}

	// lv1_app_web_whale_logindata
	@Override
	public List<Map> selectWhaleLogindata(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleLogindata(paramMap);
	}

	@Override
	public Map selectWhaleLogindataCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleLogindataCount(paramMap);
	}

	// lv1_app_web_whale_search_terms
	@Override
	public List<Map> selectWhaleSearchTerms(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleSearchTerms(paramMap);
	}

	@Override
	public Map selectWhaleSearchTermsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleSearchTermsCount(paramMap);
	}

	// lv1_app_web_whale_shortcuts
	@Override
	public List<Map> selectWhaleShortcuts(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleShortcuts(paramMap);
	}

	@Override
	public Map selectWhaleShortcutsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleShortcutsCount(paramMap);
	}

	// lv1_app_web_whale_top_sites
	@Override
	public List<Map> selectWhaleTopSites(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleTopSites(paramMap);
	}

	@Override
	public Map selectWhaleTopSitesCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleTopSitesCount(paramMap);
	}

	// lv1_app_web_whale_visit_urls
	@Override
	public List<Map> selectWhaleVisitUrls(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleVisitUrls(paramMap);
	}

	@Override
	public Map selectWhaleVisitUrlsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWhaleVisitUrlsCount(paramMap);
	}
	
	
	// lv1_app_web_whale_visit_history
	@Override
	public List<Map> selectWhaleVisitHistory(Map<String, Object> paramMap) throws Exception {
	    return dao.selectWhaleVisitHistory(paramMap);
	}

	@Override
	public Map selectWhaleVisitHistoryCount(Map<String, Object> paramMap) throws Exception {
	    return dao.selectWhaleVisitHistoryCount(paramMap);
	}

	/*
	 * // lv1_fs_ntfs_logfile
	 * 
	 * @Override public List<Map> selectNtfsLogfile(Map<String, Object> paramMap)
	 * throws Exception { return dao.selectNtfsLogfile(paramMap); }
	 * 
	 * @Override public Map selectNtfsLogfileCount(Map<String, Object> paramMap)
	 * throws Exception { return dao.selectNtfsLogfileCount(paramMap); }
	 * 
	 * // lv1_fs_ntfs_usnjrnl
	 * 
	 * @Override public List<Map> selectNtfsUsnjrnl(Map<String, Object> paramMap)
	 * throws Exception { return dao.selectNtfsUsnjrnl(paramMap); }
	 * 
	 * @Override public Map selectNtfsUsnjrnlCount(Map<String, Object> paramMap)
	 * throws Exception { return dao.selectNtfsUsnjrnlCount(paramMap); }
	 */

	// lv2_os_app_history
	@Override
	public List<Map> selectAppHistory(Map<String, Object> paramMap) throws Exception {
		return dao.selectAppHistory(paramMap);
	}

	@Override
	public Map selectAppHistoryCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectAppHistoryCount(paramMap);
	}

	// lv1_os_win_notification
	@Override
	public List<Map> selectNotification(Map<String, Object> paramMap) throws Exception {
		return dao.selectNotification(paramMap);
	}

	@Override
	public Map selectNotificationCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectNotificationCount(paramMap);
	}

	// lv1_os_win_prefetch
	@Override
	public List<Map> selectPrefetch(Map<String, Object> paramMap) throws Exception {
		return dao.selectPrefetch(paramMap);
	}

	@Override
	public Map selectPrefetchCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectPrefetchCount(paramMap);
	}

	// lv1_os_win_prefetch_run_info
	@Override
	public List<Map> selectPrefetchRunInfo(Map<String, Object> paramMap) throws Exception {
		return dao.selectPrefetchRunInfo(paramMap);
	}

	@Override
	public Map selectPrefetchRunInfoCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectPrefetchRunInfoCount(paramMap);
	}

	// lv1_os_win_prefetch_volume_info
	@Override
	public List<Map> selectPrefetchVolumeInfo(Map<String, Object> paramMap) throws Exception {
		return dao.selectPrefetchVolumeInfo(paramMap);
	}

	@Override
	public Map selectPrefetchVolumeInfoCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectPrefetchVolumeInfoCount(paramMap);
	}

	// lv1_os_win_recyclebin
	@Override
	public List<Map> selectRecycleBin(Map<String, Object> paramMap) throws Exception {
		return dao.selectRecycleBin(paramMap);
	}

	@Override
	public Map selectRecycleBinCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRecycleBinCount(paramMap);
	}

	// lv1_os_win_sticky_note
	@Override
	public List<Map> selectStickyNote(Map<String, Object> paramMap) throws Exception {
		return dao.selectStickyNote(paramMap);
	}

	@Override
	public Map selectStickyNoteCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectStickyNoteCount(paramMap);
	}

	// lv1_os_win_windows_timeline
	@Override
	public List<Map> selectWindowsTimeline(Map<String, Object> paramMap) throws Exception {
		return dao.selectWindowsTimeline(paramMap);
	}

	@Override
	public Map selectWindowsTimelineCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWindowsTimelineCount(paramMap);
	}

	// lv1_app_kakaotalk_new_chatLogs
	@Override
	public List<Map> selectKakaotalkNewChatlogs(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkNewChatlogs(paramMap);
	}

	@Override
	public Map selectKakaotalkNewChatlogsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkNewChatlogsCount(paramMap);
	}

	// lv1_app_kakaotalk_chatLogs
	@Override
	public List<Map> selectKakaotalkChatlogs(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkChatlogs(paramMap);
	}

	@Override
	public Map selectKakaotalkChatlogsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkChatlogsCount(paramMap);
	}

	// lv1_app_kakaotalk_chatLog_attachment
	@Override
	public List<Map> selectKakaotalkChatlogAttachment(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkChatlogAttachment(paramMap);
	}

	@Override
	public Map selectKakaotalkChatlogAttachmentCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkChatlogAttachmentCount(paramMap);
	}

	// lv1_app_kakaotalk_chatLogDrafts
	@Override
	public List<Map> selectKakaotalkChatlogDrafts(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkChatlogDrafts(paramMap);
	}

	@Override
	public Map selectKakaotalkChatlogDraftsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkChatlogDraftsCount(paramMap);
	}

	// lv1_fs_ntfs_logfile_log_record
	@Override
	public List<Map> selectLogRecord(Map<String, Object> paramMap) throws Exception {
		return dao.selectLogRecord(paramMap);
	}

	@Override
	public Map selectLogRecordCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectLogRecordCount(paramMap);
	}

	// lv1_fs_ntfs_logfile_restart_area
	@Override
	public List<Map> selectRestartArea(Map<String, Object> paramMap) throws Exception {
		return dao.selectRestartArea(paramMap);
	}

	@Override
	public Map selectRestartAreaCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRestartAreaCount(paramMap);
	}

	// lv1_fs_ntfs_mft
	@Override
	public List<Map> selectMFT(Map<String, Object> paramMap) throws Exception {
		return dao.selectMFT(paramMap);
	}

	@Override
	public Map selectMFTCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectMFTCount(paramMap);
	}

	// lv1_fs_ntfs_usnjrnl
	@Override
	public List<Map> selectUsnJrnl(Map<String, Object> paramMap) throws Exception {
		return dao.selectUsnJrnl(paramMap);
	}

	@Override
	public Map selectUsnJrnlCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectUsnJrnlCount(paramMap);
	}

	// lv1_os_win_filehistory_file
	@Override
	public List<Map> selectFile(Map<String, Object> paramMap) throws Exception {
		return dao.selectFile(paramMap);
	}

	@Override
	public Map selectFileCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFileCount(paramMap);
	}

	// lv1_os_win_filehistory_namespace
	@Override
	public List<Map> selectNamespace(Map<String, Object> paramMap) throws Exception {
		return dao.selectNamespace(paramMap);
	}

	@Override
	public Map selectNamespaceCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectNamespaceCount(paramMap);
	}

	// lv1_os_win_filehistory_string
	@Override
	public List<Map> selectString(Map<String, Object> paramMap) throws Exception {
		return dao.selectString(paramMap);
	}

	@Override
	public Map selectStringCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectStringCount(paramMap);
	}

	// lv1_os_win_jumplist_custom
	@Override
	public List<Map> selectJumplistCustom(Map<String, Object> paramMap) throws Exception {
		return dao.selectJumplistCustom(paramMap);
	}

	@Override
	public Map selectJumplistCustomCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectJumplistCustomCount(paramMap);
	}

	// lv1_os_win_link
	@Override
	public List<Map> selectLNKFile(Map<String, Object> paramMap) throws Exception {
		return dao.selectLNKFile(paramMap);
	}

	@Override
	public Map selectLNKFileCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectLNKFileCount(paramMap);
	}

	// lv1_os_win_searchdb_gthr
	@Override
	public List<Map> selectSearchDBGthr(Map<String, Object> paramMap) throws Exception {
		return dao.selectSearchDBGthr(paramMap);
	}

	@Override
	public Map selectSearchDBGthrCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectSearchDBGthrCount(paramMap);
	}

	// lv1_os_win_searchdb_gthrpth
	@Override
	public List<Map> selectSearchDBGthrPth(Map<String, Object> paramMap) throws Exception {
		return dao.selectSearchDBGthrPth(paramMap);
	}

	@Override
	public Map selectSearchDBGthrPthCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectSearchDBGthrPthCount(paramMap);
	}

	// lv1_os_win_superfetch
	@Override
	public List<Map> selectSuperfetch(Map<String, Object> paramMap) throws Exception {
		return dao.selectSuperfetch(paramMap);
	}

	@Override
	public Map selectSuperfetchCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectSuperfetchCount(paramMap);
	}

	// lv1_app_kakaotalk_mobile_chatlogs
	@Override
	public List<Map> selectKakaotalkMobileChatlogs(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkMobileChatlogs(paramMap);
	}

	@Override
	public Map selectKakaotalkMobileChatlogsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkMobileChatlogsCount(paramMap);
	}

	// lv1_app_kakaotalk_mobile_chatrooms
	@Override
	public List<Map> selectKakaotalkMobileChatrooms(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkMobileChatrooms(paramMap);
	}

	@Override
	public Map selectKakaotalkMobileChatroomsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkMobileChatroomsCount(paramMap);
	}

	// lv1_app_kakaotalk_mobile_friends
	@Override
	public List<Map> selectKakaotalkMobileFriends(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkMobileFriends(paramMap);
	}

	@Override
	public Map selectKakaotalkMobileFriendsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectKakaotalkMobileFriendsCount(paramMap);
	}

	// lv1_os_and_app_list
	@Override
	public List<Map> selectAppList(Map<String, Object> paramMap) throws Exception {
		return dao.selectAppList(paramMap);
	}

	@Override
	public Map selectAppListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectAppListCount(paramMap);
	}

	// lv1_os_and_call_history
	@Override
	public List<Map> selectCallHistory(Map<String, Object> paramMap) throws Exception {
		return dao.selectCallHistory(paramMap);
	}

	@Override
	public Map selectCallHistoryCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectCallHistoryCount(paramMap);
	}

	// lv1_os_and_emb_file
	@Override
	public List<Map> selectEmbFile(Map<String, Object> paramMap) throws Exception {
		return dao.selectEmbFile(paramMap);
	}

	@Override
	public Map selectEmbFileCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectEmbFileCount(paramMap);
	}

	// lv1_os_and_file_history
	@Override
	public List<Map> selectFileHistory(Map<String, Object> paramMap) throws Exception {
		return dao.selectFileHistory(paramMap);
	}

	@Override
	public Map selectFileHistoryCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFileHistoryCount(paramMap);
	}

	// lv1_os_and_geodata
	@Override
	public List<Map> selectGeodata(Map<String, Object> paramMap) throws Exception {
		return dao.selectGeodata(paramMap);
	}

	@Override
	public Map selectGeodataCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectGeodataCount(paramMap);
	}

	// lv1_os_and_id_pw_hash
	@Override
	public List<Map> selectIdpwhash(Map<String, Object> paramMap) throws Exception {
		return dao.selectIdpwhash(paramMap);
	}

	@Override
	public Map selectIdpwhashCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectIdpwhashCount(paramMap);
	}

	// lv1_os_and_web_browser_history
	@Override
	public List<Map> selectWebBrowserHistory(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebBrowserHistory(paramMap);
	}

	@Override
	public Map selectWebBrowserHistoryCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebBrowserHistoryCount(paramMap);
	}

	// lv1_os_win_icon_cache
	@Override
	public List<Map> selectIconCache(Map<String, Object> paramMap) throws Exception {
		return dao.selectIconCache(paramMap);
	}

	@Override
	public Map selectIconCacheCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectIconCacheCount(paramMap);
	}

	// lv1_os_win_jumplist_automatics
	@Override
	public List<Map> selectJumplistAutomatics(Map<String, Object> paramMap) throws Exception {
		return dao.selectJumplistAutomatics(paramMap);
	}

	@Override
	public Map selectJumplistAutomaticsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectJumplistAutomaticsCount(paramMap);
	}

	// lv1_os_win_thumbnail_cache
	@Override
	public List<Map> selectThumbnailCache(Map<String, Object> paramMap) throws Exception {
		return dao.selectThumbnailCache(paramMap);
	}

	@Override
	public Map selectThumbnailCacheCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectThumbnailCacheCount(paramMap);
	}

	// lv1_os_and_basic_app_accounts_ce_0
	@Override
	public List<Map> selectAccountsCE0(Map<String, Object> paramMap) throws Exception {
		return dao.selectAccountsCE0(paramMap);
	}

	@Override
	public Map selectAccountsCE0Count(Map<String, Object> paramMap) throws Exception {
		return dao.selectAccountsCE0Count(paramMap);
	}

	// lv1_os_and_basic_app_accounts_de_0
	@Override
	public List<Map> selectAccountsDE0(Map<String, Object> paramMap) throws Exception {
		return dao.selectAccountsDE0(paramMap);
	}

	@Override
	public Map selectAccountsDE0Count(Map<String, Object> paramMap) throws Exception {
		return dao.selectAccountsDE0Count(paramMap);
	}

	// lv1_os_and_basic_app_call_logs
	@Override
	public List<Map> selectCallLogs(Map<String, Object> paramMap) throws Exception {
		return dao.selectCallLogs(paramMap);
	}

	@Override
	public Map selectCallLogsCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectCallLogsCount(paramMap);
	}

	// lv1_os_and_basic_app_file_cache
	@Override
	public List<Map> selectFileCache(Map<String, Object> paramMap) throws Exception {
		return dao.selectFileCache(paramMap);
	}

	@Override
	public Map selectFileCacheCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFileCacheCount(paramMap);
	}

	// lv1_os_and_basic_app_mms
	@Override
	public List<Map> selectMMS(Map<String, Object> paramMap) throws Exception {
		return dao.selectMMS(paramMap);
	}

	@Override
	public Map selectMMSCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectMMSCount(paramMap);
	}

	// lv1_os_and_basic_app_recent_files
	@Override
	public List<Map> selectRecentFiles(Map<String, Object> paramMap) throws Exception {
		return dao.selectRecentFiles(paramMap);
	}

	@Override
	public Map selectRecentFilesCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRecentFilesCount(paramMap);
	}

	// lv1_os_and_basic_app_sim_info
	@Override
	public List<Map> selectSimInfo(Map<String, Object> paramMap) throws Exception {
		return dao.selectSimInfo(paramMap);
	}

	@Override
	public Map selectSimInfoCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectSimInfoCount(paramMap);
	}

	// lv1_os_and_basic_app_sim_info_dat
	@Override
	public List<Map> selectSimInfoDat(Map<String, Object> paramMap) throws Exception {
		return dao.selectSimInfoDat(paramMap);
	}

	@Override
	public Map selectSimInfoDatCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectSimInfoDatCount(paramMap);
	}

	// lv1_os_and_basic_app_sms
	@Override
	public List<Map> selectSMS(Map<String, Object> paramMap) throws Exception {
		return dao.selectSMS(paramMap);
	}

	@Override
	public Map selectSMSCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectSMSCount(paramMap);
	}

	// lv1_os_and_basic_app_usagestats_0
	@Override
	public List<Map> selectUsagestats0(Map<String, Object> paramMap) throws Exception {
		return dao.selectUsagestats0(paramMap);
	}

	@Override
	public Map selectUsagestats0Count(Map<String, Object> paramMap) throws Exception {
		return dao.selectUsagestats0Count(paramMap);
	}

	// lv1_os_and_basic_app_wifi_info
	@Override
	public List<Map> selectWifiInfo(Map<String, Object> paramMap) throws Exception {
		return dao.selectWifiInfo(paramMap);
	}

	@Override
	public Map selectWifiInfoCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWifiInfoCount(paramMap);
	}

}