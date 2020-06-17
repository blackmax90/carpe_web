package com.carpe.recyclebin;

import java.util.List;
import java.util.Map;

public interface RecyclebinService {
	public List<Map> selectYearList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectRecyclebinYearList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectRecyclebinMonthList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectRecyclebinDayList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectRecyclebinHourList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectRecyclebinList(Map<String, Object> paramMap) throws Exception;
}