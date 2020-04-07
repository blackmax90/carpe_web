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
	
	//	Installed Application
	public List<Map> selectInstalledAppList(Map<String, Object> paramMap) throws Exception {
		return dao.selectInstalledAppList(paramMap);
	}

	@Override
	public Map selectInstalledAppListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectInstalledAppListCount(paramMap);
	}
	
	//	Web History
	public List<Map> selectWebHistoryList(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebHistoryList(paramMap);
	}

	@Override
	public Map selectWebHistoryListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebHistoryListCount(paramMap);
	}
	
	//	Web Download
	public List<Map> selectWebDownloadList(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebDownloadList(paramMap);
	}

	@Override
	public Map selectWebDownloadListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebDownloadListCount(paramMap);
	}
	
	//	Web Cache
	public List<Map> selectWebCacheList(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebCacheList(paramMap);
	}

	@Override
	public Map selectWebCacheListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectWebCacheListCount(paramMap);
	}
	
	//	Web Cookie
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
	
	// lv1_os_win_lnk_files
	@Override
	public List<Map> selectLnkFiles(Map<String, Object> paramMap) throws Exception {
		return dao.selectLnkFiles(paramMap);
	}

	@Override
	public Map selectLnkFilesCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectLnkFilesCount(paramMap);
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
	
	// lv1_app_web_chrome_download
	@Override
	public List<Map> selectChromeDownload(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeDownload(paramMap);
	}

	@Override
	public Map selectChromeDownloadCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeDownloadCount(paramMap);
	}
	
	// lv1_app_web_chrome_cookies
	@Override
	public List<Map> selectChromeCookie(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeCookie(paramMap);
	}

	@Override
	public Map selectChromeCookieCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeCookieCount(paramMap);
	}
	
	// lv1_app_web_chrome_cache
	@Override
	public List<Map> selectChromeCache(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeCache(paramMap);
	}

	@Override
	public Map selectChromeCacheCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectChromeCacheCount(paramMap);
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
	
	// lv1_fs_ntfs_logfile
	@Override
	public List<Map> selectNtfsLogfile(Map<String, Object> paramMap) throws Exception {
		return dao.selectNtfsLogfile(paramMap);
	}

	@Override
	public Map selectNtfsLogfileCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectNtfsLogfileCount(paramMap);
	}
	
	// lv1_fs_ntfs_usnjrnl
	@Override
	public List<Map> selectNtfsUsnjrnl(Map<String, Object> paramMap) throws Exception {
		return dao.selectNtfsUsnjrnl(paramMap);
	}

	@Override
	public Map selectNtfsUsnjrnlCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectNtfsUsnjrnlCount(paramMap);
	}
}