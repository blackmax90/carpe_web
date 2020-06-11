package com.carpe.recyclebin;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class RecyclebinServiceImpl implements RecyclebinService {

	@Inject
	private RecyclebinDAO dao;

	@Override
	public List<Map> selectYearList(Map<String, Object> paramMap) throws Exception {
		return dao.selectYearList(paramMap);
	}

	@Override
	public List<Map> selectRecyclebinYearList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRecyclebinYearList(paramMap);
	}

	@Override
	public List<Map> selectRecyclebinMonthList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRecyclebinMonthList(paramMap);
	}

	@Override
	public List<Map> selectRecyclebinDayList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRecyclebinDayList(paramMap);
	}

	@Override
	public List<Map> selectRecyclebinHourList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRecyclebinHourList(paramMap);
	}

	@Override
	public List<Map> selectRecyclebinList(Map<String, Object> paramMap) throws Exception {
		return dao.selectRecyclebinList(paramMap);
	}
}