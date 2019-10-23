package com.carpe.gps;

import java.util.List;
import java.util.Map;

public interface GpsDAO {
	public List<Map> selectGpsList(Map<String, Object> paramMap) throws Exception;
}