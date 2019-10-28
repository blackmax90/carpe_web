package com.carpe.communication;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CommunicationDAOImpl implements CommunicationDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.communication";

	@Override
	public List<Map> selectCommunicationList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectCommunicationList", paramMap);
	}
	
	@Override
	public List<Map> selectCallStat(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectCallStat", paramMap);
	}
	
	@Override
	public List<Map> selectSmsStat(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectSmsStat", paramMap);
	}
}