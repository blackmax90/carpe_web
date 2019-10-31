package com.carpe.usage;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class UsageServiceImpl implements UsageService {

	@Inject
	private UsageDAO dao;

	@Override
	public List<Map> selectUsageYearList(Map<String, Object> paramMap) throws Exception {
		return dao.selectUsageYearList(paramMap);
	}
	
	@Override
	public List<Map> selectUsageMonthList(Map<String, Object> paramMap) throws Exception {
		return dao.selectUsageMonthList(paramMap);
	}
}