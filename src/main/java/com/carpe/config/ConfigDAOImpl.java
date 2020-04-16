package com.carpe.config;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ConfigDAOImpl implements ConfigDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.config";

	@Override
	public List<Map> selectUserList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectUserList", paramMap);
	}

	@Override
	public List<Map> selectCaseUserAuthList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectCaseUserAuthList", paramMap);
	}

	@Override
	public List<Map> selectCaseList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectCaseList", paramMap);
	}

	@Override
	public Map selectCaseListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectCaseListCount", paramMap);
	}

	@Override
	public int insertCaseUserAuth(Map<String, Object> paramMap) throws Exception {
		return sqlSession.insert(Namespace + ".insertCaseUserAuth", paramMap);
	}

	@Override
	public int deleteCaseUserAuth(Map<String, Object> paramMap) throws Exception {
		return sqlSession.insert(Namespace + ".deleteCaseUserAuth", paramMap);
	}
}