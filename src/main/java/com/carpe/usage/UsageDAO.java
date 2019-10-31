package com.carpe.usage;

import java.util.List;
import java.util.Map;

public interface UsageDAO {
	public List<Map> selectUsageYearList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectUsageMonthList(Map<String, Object> paramMap) throws Exception;
}