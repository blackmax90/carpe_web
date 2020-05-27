package com.carpe.gps;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class GpsDAOImpl implements GpsDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.gps";

	@Override
	public List<Map> selectGpsList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectGpsList", paramMap);
	}
	
	@Override
	public List<Map> selectGpsLinkList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectGpsLinkList", paramMap);
	}

	@Override
	public List<Map> selectGpsDateCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectGpsDateCount", paramMap);
	}

	@Override
	public List<Map> selectGpsFileList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectGpsFileList", paramMap);
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