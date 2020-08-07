package com.carpe.ntfs;

import java.util.List;
import java.util.Map;

public interface NtfsService {
	public List<Map> selectNtfsHistoryYearList(Map<String, Object> paramMap) throws Exception;

	public List<Map> selectNtfsHistoryList(Map<String, Object> paramMap) throws Exception;

	public List<Map> selectNtfsHistoryCountList(Map<String, Object> paramMap) throws Exception;
}