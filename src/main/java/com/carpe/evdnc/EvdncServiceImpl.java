package com.carpe.evdnc;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class EvdncServiceImpl implements EvdncService {

	@Inject
	private EvdncDAO dao;

	@Override
	public List<Map> selectEvdncList(Map<String, Object> paramMap) throws Exception {
		return dao.selectEvdncList(paramMap);
	}

	@Override
	public int insertEvdnc(Map<String, Object> paramMap) throws Exception {
		return dao.insertEvdnc(paramMap);
	}

	@Override
	public Map selectEvdnc(Map<String, Object> paramMap) throws Exception {
		return dao.selectEvdnc(paramMap);
	}
}