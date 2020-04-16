package com.carpe.config;

import java.util.List;
import java.util.Map;

public interface ConfigDAO {
	public List<Map> selectUserList(Map<String, Object> paramMap) throws Exception;

	public List<Map> selectCaseUserAuthList(Map<String, Object> paramMap) throws Exception;

	public List<Map> selectCaseList(Map<String, Object> paramMap) throws Exception;

	public Map selectCaseListCount(Map<String, Object> paramMap) throws Exception;

	public int insertCaseUserAuth(Map<String, Object> paramMap) throws Exception;

	public int deleteCaseUserAuth(Map<String, Object> paramMap) throws Exception;
}