package com.carpe.usage;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.carpe.evdnc.EvdncDAO;

@Service
public class UsageServiceImpl implements UsageService {

	@Inject
	private UsageDAO dao;

	@Inject
	private EvdncDAO evdncDao;

	@Override
	public List<Map> selectUsageYearList(Map<String, Object> paramMap) throws Exception {
		return dao.selectUsageYearList(paramMap);
	}
	
	@Override
	public List<Map> selectUsageMonthList(Map<String, Object> paramMap) throws Exception {
		return dao.selectUsageMonthList(paramMap);
	}
	
	@Override
	public List<Map> selectUsageDayList(Map<String, Object> paramMap) throws Exception {
		return dao.selectUsageDayList(paramMap);
	}

	@Override
	public List<Map> selectUsageDayDetailList(Map<String, Object> paramMap) throws Exception {
		return dao.selectUsageDayDetailList(paramMap);
	}

	@Override
	public List<Map> selectEvdncList(Map<String, Object> paramMap) throws Exception {
		return evdncDao.selectEvdncList(paramMap);
	}
}