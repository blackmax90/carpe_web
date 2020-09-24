package com.carpe.timeline;

import java.util.List;
import java.util.Map;

public interface TimelineService {
	public List<Map> selectTimelineList(Map<String, Object> paramMap) throws Exception;
}