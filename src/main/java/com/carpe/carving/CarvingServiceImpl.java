package com.carpe.carving;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class CarvingServiceImpl implements CarvingService {

	@Inject
	private CarvingDAO dao;

	@Override
	public List<Map> selectCarvingList(Map<String, Object> paramMap) throws Exception {
		return dao.selectCarvingList(paramMap);
	}

	@Override
	public Map selectCarvingListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectCarvingListCount(paramMap);
	}
	
}