package com.carpe.report;

import java.util.List;
import java.util.Map;

public interface ReportService {
	public Map selectCaseInfo(Map<String, Object> paramMap) throws Exception;

	public List<Map> getEvdncInfo(Map<String, Object> paramMap) throws Exception;

	public Map getCaseInfo(Map<String, Object> paramMap) throws Exception;
}