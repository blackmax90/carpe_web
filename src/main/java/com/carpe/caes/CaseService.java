package com.carpe.caes;

import java.util.List;
import java.util.Map;

public interface CaseService {
	public List<Map> selectCaseList(Map<String, Object> paramMap) throws Exception;
	public int insertCase(Map<String, Object> paramMap) throws Exception;
	public int deleteCaseList(Map<String, Object> paramMap) throws Exception;
}