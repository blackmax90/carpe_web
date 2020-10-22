package com.carpe.caes;

import java.util.List;
import java.util.Map;

public interface CaseService {
	public List<Map> selectCaseList(Map<String, Object> paramMap) throws Exception;
	public Map selectCaseListCount(Map<String, Object> paramMap) throws Exception;
	public int insertCase(Map<String, Object> paramMap) throws Exception;
	public int updateCaseDeleteFlag(Map<String, Object> paramMap) throws Exception;
	public int deleteCaseList(Map<String, Object> paramMap) throws Exception;
	public Map selectCaseUserAuthCount(Map<String, Object> paramMap) throws Exception;
	public int deleteCaseUserAuth(Map<String, Object> paramMap) throws Exception;
	public List<Map> getEvidenceList(Map<String, Object> paramMap) throws Exception;
}