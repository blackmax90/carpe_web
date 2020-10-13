package com.carpe.evdnc;

import java.util.List;
import java.util.Map;

public interface EvdncService {
	public List<Map> selectEvdncList(Map<String, Object> paramMap) throws Exception;
	public Map selectEvdncListCount(Map<String, Object> paramMap) throws Exception;
	public int insertEvdnc(Map<String, Object> paramMap) throws Exception;
	public Map selectEvdnc(Map<String, Object> paramMap) throws Exception;
	public int updateEvdncDeleteFlag(Map<String, Object> paramMap) throws Exception;
	public int deleteEvdncList(Map<String, Object> paramMap) throws Exception;
}