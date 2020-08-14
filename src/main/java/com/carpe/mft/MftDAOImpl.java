package com.carpe.mft;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MftDAOImpl implements MftDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.mft";

	@Override
	public List<Map> selectMftHistoryList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectMftHistoryList", paramMap);
	}

	@Override
	public Map selectMftHistoryCopyRate(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectMftHistoryCopyRate", paramMap);
	}
}