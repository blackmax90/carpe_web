package com.carpe.artifact;

import java.util.List;
import java.util.Map;

public interface ArtifactService {
	public List<Map> selectSystemLogOverviewList(Map<String, Object> paramMap) throws Exception;
	public Map selectSystemLogOverviewListCount(Map<String, Object> paramMap) throws Exception;
}