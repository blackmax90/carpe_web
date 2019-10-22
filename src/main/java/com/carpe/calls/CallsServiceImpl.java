package com.carpe.calls;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class CallsServiceImpl implements CallsService {

	@Inject
	private CallsDAO dao;

	@Override
	public List<Map> selectCallsList(Map<String, Object> paramMap) throws Exception {
		return dao.selectCallsList(paramMap);
	}

}