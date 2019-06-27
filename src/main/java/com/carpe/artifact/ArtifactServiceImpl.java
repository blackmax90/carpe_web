package com.carpe.artifact;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class ArtifactServiceImpl implements ArtifactService {

	@Inject
	private ArtifactDAO dao;

	@Override
	public List<Map> selectSystemLogOverviewList(Map<String, Object> paramMap) throws Exception {
		return dao.selectSystemLogOverviewList(paramMap);
	}

	@Override
	public Map selectSystemLogOverviewListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectSystemLogOverviewListCount(paramMap);
	}
}