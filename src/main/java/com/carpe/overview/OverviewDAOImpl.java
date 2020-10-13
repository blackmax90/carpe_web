package com.carpe.overview;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class OverviewDAOImpl implements OverviewDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.overview";

	@Override
	public Map selectCaseInfo(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectCaseInfo", paramMap);
	}

	@Override
	public List<Map> selectCaseUserList(Map<String, Object> paramMap) throws Exception {		
		return sqlSession.selectList(Namespace + ".selectCaseUserList", paramMap);
	}
	
	@Override
	public List<Map> selectEvidenceList(Map<String, Object> paramMap) throws Exception {		
		return sqlSession.selectList(Namespace + ".selectEvidenceList", paramMap);
	}

	@Override
	public List<Map> selectEvidenceFileCount(Map<String, Object> paramMap) throws Exception {		
		return sqlSession.selectList(Namespace + ".selectEvidenceFileCount", paramMap);
	}
}