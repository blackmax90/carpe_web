package com.carpe.gps;

import java.util.List;
import java.util.Map;

public interface GpsService {
	public List<Map> selectGpsList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectGpsLinkList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectGpsDateCount(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectGpsFileList(Map<String, Object> paramMap) throws Exception;
	public Map<String, Object> getDetailPath(Map<String, String> data);
	public List<Map> selectCommunicationRoomList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectCommunicationDataList(Map<String, Object> paramMap) throws Exception;
}