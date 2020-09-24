package com.carpe.timeline;

import java.util.List;
import java.util.Map;

public interface TimelineDAO {
	public List<Map> selectTimelineList(Map<String, Object> paramMap) throws Exception;
}