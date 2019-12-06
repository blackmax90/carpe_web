package com.carpe.carving;

import java.util.List;
import java.util.Map;

public interface CarvingDAO {
	public List<Map> selectCarvingList(Map<String, Object> paramMap) throws Exception;
	public Map selectCarvingListCount(Map<String, Object> paramMap) throws Exception;
}