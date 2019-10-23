package com.carpe.gps;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class GpsServiceImpl implements GpsService {

	@Inject
	private GpsDAO dao;

	@Override
	public List<Map> selectGpsList(Map<String, Object> paramMap) throws Exception {
		return dao.selectGpsList(paramMap);
	}

}