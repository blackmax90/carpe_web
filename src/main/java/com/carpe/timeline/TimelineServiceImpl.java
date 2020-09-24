package com.carpe.timeline;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class TimelineServiceImpl implements TimelineService {

	@Inject
	private TimelineDAO dao;

	@Override
	public List<Map> selectTimelineList(Map<String, Object> paramMap) throws Exception {
		return dao.selectTimelineList(paramMap);
	}
}