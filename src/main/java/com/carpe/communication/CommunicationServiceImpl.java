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
	public List<Map> selectCommunicationYearList(Map<String, Object> paramMap) throws Exception {
		return dao.selectCommunicationYearList(paramMap);
	}

	@Override
	public List<Map> selectCommunicationList(Map<String, Object> paramMap) throws Exception {
		return dao.selectCommunicationList(paramMap);
	}
	
	@Override
	public List<Map> selectCallStat(Map<String, Object> paramMap) throws Exception {
		return dao.selectCallStat(paramMap);
	}
	
	@Override
	public Map selectCallStatCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectCallStatCount(paramMap);
	}

	@Override
	public List<Map> selectCommunicationRoomList(Map<String, Object> paramMap) throws Exception {
		return dao.selectCommunicationRoomList(paramMap);
	}

	@Override
	public List<Map> selectCommunicationDataList(Map<String, Object> paramMap) throws Exception {
		return dao.selectCommunicationDataList(paramMap);
	}
}