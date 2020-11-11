package com.carpe.report;

import java.util.List;
import java.util.Map;

public interface ReportDAO {
	public Map selectCaseInfo(Map<String, Object> paramMap) throws Exception;

	public List<Map> selectEvdncList(Map<String, Object> paramMap) throws Exception;

	public List<Map> selectPartitionList(Map<String, Object> paramMap) throws Exception;

	public List<Map> selectOsList(Map<String, Object> paramMap) throws Exception;

	public List<Map> selectUserAccountList(Map<String, Object> paramMap) throws Exception;

	public Map selectArtifactCount(Map<String, Object> paramMap) throws Exception;
}