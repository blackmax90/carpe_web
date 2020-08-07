package com.carpe.ntfs;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class NtfsServiceImpl implements NtfsService {

	@Inject
	private NtfsDAO dao;

	@Override
	public List<Map> selectNtfsHistoryYearList(Map<String, Object> paramMap) throws Exception {
		return dao.selectNtfsHistoryYearList(paramMap);
	}

	@Override
	public List<Map> selectNtfsHistoryList(Map<String, Object> paramMap) throws Exception {
		return dao.selectNtfsHistoryList(paramMap);
	}

	@Override
	public List<Map> selectNtfsHistoryCountList(Map<String, Object> paramMap) throws Exception {
		return dao.selectNtfsHistoryCountList(paramMap);
	}
}