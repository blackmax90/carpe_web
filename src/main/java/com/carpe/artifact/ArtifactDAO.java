package com.carpe.artifact;

import java.util.List;
import java.util.Map;

public interface ArtifactDAO {
	public List<Map> selectSystemLogOverviewList(Map<String, Object> paramMap) throws Exception;
	public Map selectSystemLogOverviewListCount(Map<String, Object> paramMap) throws Exception;

	public List<Map> selectTimelineList(Map<String, Object> paramMap) throws Exception;
}