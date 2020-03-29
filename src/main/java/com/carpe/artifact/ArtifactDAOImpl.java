package com.carpe.artifact;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ArtifactDAOImpl implements ArtifactDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.artifact";

	// Plaso Result
	@Override
	public List<Map> selectSystemLogOverviewList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectSystemLogOverviewList", paramMap);
	}

	@Override
	public Map selectSystemLogOverviewListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectSystemLogOverviewListCount", paramMap);
	}

	// Operating System
	@Override
	public List<Map> selectOSInstallationList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectOSInstallationList", paramMap);
	}

	@Override
	public Map selectOSInstallationListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectOSInstallationListCount", paramMap);
	}

	// Windows Storage Device
	@Override
	public List<Map> selectStorageDeviceList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectStorageDeviceList", paramMap);
	}

	@Override
	public Map selectStorageDeviceListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectStorageDeviceListCount", paramMap);
	}

	// Installed Application
	@Override
	public List<Map> selectInstalledAppList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectInstalledAppList", paramMap);
	}

	@Override
	public Map selectInstalledAppListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectInstalledAppListCount", paramMap);
	}

	// Web History
	@Override
	public List<Map> selectWebHistoryList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectWebHistoryList", paramMap);
	}

	@Override
	public Map selectWebHistoryListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectWebHistoryListCount", paramMap);
	}

	// Web Download
	@Override
	public List<Map> selectWebDownloadList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectWebDownloadList", paramMap);
	}

	@Override
	public Map selectWebDownloadListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectWebDownloadListCount", paramMap);
	}

	// Web Cache
	@Override
	public List<Map> selectWebCacheList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectWebCacheList", paramMap);
	}

	@Override
	public Map selectWebCacheListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectWebCacheListCount", paramMap);
	}

	// Web Cookie
	@Override
	public List<Map> selectWebCookieList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectWebCookieList", paramMap);
	}

	@Override
	public Map selectWebCookieListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectWebCookieListCount", paramMap);
	}
	
	@Override
	public List<Map> selectTimelineList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectTimelineList", paramMap);
	}
	
	// lv1
	// lv1_os_win_event_logs
	@Override
	public List<Map> selectEventLogsList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectEventLogsList", paramMap);
	}

	@Override
	public Map selectEventLogsListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectEventLogsListCount", paramMap);
	}

	// lv1_os_win_jumplist
	@Override
	public List<Map> selectJumplistList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectJumplistList", paramMap);
	}

	@Override
	public Map selectJumplistListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectJumplistListCount", paramMap);
	}
	
	// lv1_os_win_reg_amcache_file_entries
	@Override
	public List<Map> selectRegAmcacheFileEntriesList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectRegAmcacheFileEntriesList", paramMap);
	}

	@Override
	public Map selectRegAmcacheFileEntriesListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectRegAmcacheFileEntriesListCount", paramMap);
	}

	// lv1_os_win_reg_amcache_program_entries
	@Override
	public List<Map> selectRegAmcacheProgramEntriesList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectRegAmcacheProgramEntriesList", paramMap);
	}

	@Override
	public Map selectRegAmcacheProgramEntriesListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectRegAmcacheProgramEntriesListCount", paramMap);
	}
	
	// lv1_os_win_reg_installed_programs
	@Override
	public List<Map> selectRegInstalledProgramsList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectRegInstalledProgramsList", paramMap);
	}

	@Override
	public Map selectRegInstalledProgramsListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectRegInstalledProgramsListCount", paramMap);
	}
	
	// lv1_os_win_reg_os_info
	@Override
	public List<Map> selectRegOSInfoList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectRegOSInfoList", paramMap);
	}

	@Override
	public Map selectRegOSInfoListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectRegOSInfoListCount", paramMap);
	}
	
	// lv1_os_win_reg_usb_devices
	@Override
	public List<Map> selectRegUSBDevicesList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectRegUSBDevicesList", paramMap);
	}

	@Override
	public Map selectRegUSBDevicesListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectRegUSBDevicesListCount", paramMap);
	}
	
	// lv1_os_win_reg_user_accounts
	@Override
	public List<Map> selectRegUserAccountsList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectRegUserAccountsList", paramMap);
	}

	@Override
	public Map selectRegUserAccountsListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectRegUserAccountsListCount", paramMap);
	}
	
	// lv1_app_web_chrome_visit_urls
	@Override
	public List<Map> selectChromeVisitUrlsList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectChromeVisitUrlsList", paramMap);
	}

	@Override
	public Map selectChromeVisitUrlsListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectChromeVisitUrlsListCount", paramMap);
	}
	
	// lv1_os_win_reg_userassist
	@Override
	public List<Map> selectRegUserAssist(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectRegUserAssist", paramMap);
	}

	@Override
	public Map selectRegUserAssistCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectRegUserAssistCount", paramMap);
	}
	
	// lv1_os_win_lnk_files
	@Override
	public List<Map> selectLnkFiles(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectLnkFiles", paramMap);
	}

	@Override
	public Map selectLnkFilesCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectLnkFilesCount", paramMap);
	}
	
	// lv1_os_win_prefetch
	@Override
	public List<Map> selectPrefetch(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectPrefetch", paramMap);
	}

	@Override
	public Map selectPrefetchCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectPrefetchCount", paramMap);
	}
	
	// lv1_app_web_chrome_download
	@Override
	public List<Map> selectChromeDownload(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectChromeDownload", paramMap);
	}

	@Override
	public Map selectChromeDownloadCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectChromeDownloadCount", paramMap);
	}
	
	// lv1_app_web_chrome_cookies
	@Override
	public List<Map> selectChromeCookie(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectChromeCookie", paramMap);
	}

	@Override
	public Map selectChromeCookieCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectChromeCookieCount", paramMap);
	}
	
	// lv1_app_web_chrome_cache
	@Override
	public List<Map> selectChromeCache(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectChromeCache", paramMap);
	}

	@Override
	public Map selectChromeCacheCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectChromeCacheCount", paramMap);
	}

	// lv1_app_web_chrome_search_terms
	@Override
	public List<Map> selectChromeSearchTerms(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectChromeSearchTerms", paramMap);
	}

	@Override
	public Map selectChromeSearchTermsCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectChromeSearchTermsCount", paramMap);
	}

	// lv1_fs_ntfs_logfile
	@Override
	public List<Map> selectNtfsLogfile(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectNtfsLogfile", paramMap);
	}

	@Override
	public Map selectNtfsLogfileCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectNtfsLogfileCount", paramMap);
	}
	
	// lv1_fs_ntfs_usnjrnl
	@Override
	public List<Map> selectNtfsUsnjrnl(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectNtfsUsnjrnl", paramMap);
	}

	@Override
	public Map selectNtfsUsnjrnlCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectNtfsUsnjrnlCount", paramMap);
	}
}