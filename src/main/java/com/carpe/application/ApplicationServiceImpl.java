package com.carpe.application;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class ApplicationServiceImpl implements ApplicationService {

	@Inject
	private ApplicationDAO dao;

	@Override
	public List<Map> selectAppHistoryList(Map<String, Object> paramMap) throws Exception {
		return dao.selectAppHistoryList(paramMap);
	}

	@Override
	public Map selectAppHistoryListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectAppHistoryListCount(paramMap);
	}

	@Override
	public List<Map> selectAppHistoryListGroup(Map<String, Object> paramMap) throws Exception {
		return dao.selectAppHistoryListGroup(paramMap);
	}
}