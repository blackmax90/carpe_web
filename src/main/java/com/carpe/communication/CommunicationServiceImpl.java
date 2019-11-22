package com.carpe.communication;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class CommunicationServiceImpl implements CommunicationService {

	@Inject
	private CommunicationDAO dao;

	@Override
	public List<Map> selectCommunicationList(Map<String, Object> paramMap) throws Exception {
		return dao.selectCommunicationList(paramMap);
	}
	
	@Override
	public List<Map> selectCallStat(Map<String, Object> paramMap) throws Exception {
		return dao.selectCallStat(paramMap);
	}
	
	@Override
	public List<Map> selectSmsStat(Map<String, Object> paramMap) throws Exception {
		return dao.selectSmsStat(paramMap);
	}

	@Override
	public Map selectCallStatCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectCallStatCount(paramMap);
	}
}