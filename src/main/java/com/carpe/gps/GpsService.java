package com.carpe.gps;

import java.util.List;
import java.util.Map;

public interface GpsService {
	public List<Map> selectGpsList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectGpsLinkList(Map<String, Object> paramMap) throws Exception;
	List<Map> getDetailPath(Map<String, Object> paramMap);
}