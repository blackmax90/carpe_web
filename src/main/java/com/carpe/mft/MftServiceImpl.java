package com.carpe.mft;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class MftServiceImpl implements MftService {

	@Inject
	private MftDAO dao;

	@Override
	public List<Map> selectMftHistoryList(Map<String, Object> paramMap) throws Exception {
		return dao.selectMftHistoryList(paramMap);
	}

	@Override
	public Map selectMftHistoryCopyRate(Map<String, Object> paramMap) throws Exception {
		return dao.selectMftHistoryCopyRate(paramMap);
	}
}