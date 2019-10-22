package com.carpe.calls;

import java.util.List;
import java.util.Map;

public interface CallsDAO {
	public List<Map> selectCallsList(Map<String, Object> paramMap) throws Exception;
}