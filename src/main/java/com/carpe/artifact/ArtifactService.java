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
	
	public List<Map> selectTimelineList(Map<String, Object> paramMap) throws Exception;
}