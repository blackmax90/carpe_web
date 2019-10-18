package com.carpe.overview;

import java.util.List;
import java.util.Map;

public interface OverviewDAO {

	public Map selectCaseInfo(Map<String, Object> paramMap) throws Exception;

	public List<Map> selectCaseUserList(Map<String, Object> paramMap) throws Exception;
}