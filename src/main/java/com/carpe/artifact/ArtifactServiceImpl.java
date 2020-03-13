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
	
	// lv1_os_win_reg_installed_programs
	@Override
	public List<Map> selectRegInsatlledProgramsList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegInsatlledProgramsList(paramMap);
	}

	@Override
	public Map selectRegInsatlledProgramsListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectRegInsatlledProgramsListCount(paramMap);
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
	

	
}