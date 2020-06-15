package com.carpe.overview;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class OverviewServiceImpl implements OverviewService {

	@Inject
	private OverviewDAO dao;

	@Override
	public Map selectCaseInfo(Map<String, Object> paramMap) throws Exception {
		return dao.selectCaseInfo(paramMap);
	}

	@Override
	public List<Map> selectCaseUserList(Map<String, Object> paramMap) throws Exception {
		return dao.selectCaseUserList(paramMap);
	}
	
	@Override
	public List<Map> selectEvidenceList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEvidenceList(paramMap);
	}
}