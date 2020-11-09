package com.carpe.usage;

import java.util.List;
import java.util.Map;

public interface UsageService {
	public List<Map> selectUsageYearList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectUsageMonthList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectUsageDayList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectUsageDayDetailList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectEvdncList(Map<String, Object> paramMap) throws Exception;
}