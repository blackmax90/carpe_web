package com.carpe.application;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ApplicationDAOImpl implements ApplicationDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.application";

	@Override
	public List<Map> selectAppHistoryList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectAppHistoryList", paramMap);
	}

	@Override
	public Map selectAppHistoryListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectAppHistoryListCount", paramMap);
	}

	@Override
	public List<Map> selectAppHistoryListGroup(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectAppHistoryListGroup", paramMap);
	}
}