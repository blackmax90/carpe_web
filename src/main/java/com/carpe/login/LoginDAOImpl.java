package com.carpe.login;

import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAOImpl implements LoginDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.login";

	@Override
	public UserVO selectUser(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectUser", paramMap);
	}

	@Override
	public Map selectUserCnt(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectUserCnt", paramMap);
	}

	@Override
	public void insertUser(Map<String, Object> paramMap) throws Exception {
		sqlSession.insert(Namespace + ".insertUser", paramMap);
	}
}