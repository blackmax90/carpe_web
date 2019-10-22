package com.carpe.calls;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CallsDAOImpl implements CallsDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.calls";

	@Override
	public List<Map> selectCallsList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectCallsList", paramMap);
	}
}