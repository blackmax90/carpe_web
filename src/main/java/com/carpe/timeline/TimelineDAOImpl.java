package com.carpe.timeline;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class TimelineDAOImpl implements TimelineDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.timeline";

	@Override
	public List<Map> selectTimelineList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectTimelineList", paramMap);
	}
}