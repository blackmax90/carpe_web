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
	public Map selectCallStatCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectCallStatCount", paramMap);
	}
	
	@Override
	public List<Map> selectCallStat(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectCallStat", paramMap);
	}
	
	@Override
	public List<Map> selectSmsStat(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectSmsStat", paramMap);
	}

	@Override
	public List<Map> selectCommunicationRoomList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectCommunicationRoomList", paramMap);
	}

	@Override
	public List<Map> selectCommunicationDataList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectCommunicationDataList", paramMap);
	}
}