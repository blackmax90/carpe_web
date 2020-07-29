package com.carpe.application;

import java.util.List;
import java.util.Map;

public interface ApplicationService {
	public List<Map> selectAppHistoryList(Map<String, Object> paramMap) throws Exception;

	public Map selectAppHistoryListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map> selectAppHistoryListGroup(Map<String, Object> paramMap) throws Exception;
}