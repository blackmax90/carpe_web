package com.carpe.mft;

import java.util.List;
import java.util.Map;

public interface MftService {
	public List<Map> selectMftHistoryList(Map<String, Object> paramMap) throws Exception;
	public Map selectMftHistoryCopyRate(Map<String, Object> paramMap) throws Exception;
}