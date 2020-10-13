package com.carpe.evdnc;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class EvdncDAOImpl implements EvdncDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.evdnc";

	@Override
	public List<Map> selectEvdncList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectEvdncList", paramMap);
	}

	@Override
	public Map selectEvdncListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectEvdncListCount", paramMap);
	}
	
	@Override
	public int insertEvdnc(Map<String, Object> paramMap) throws Exception {
		return sqlSession.insert(Namespace + ".insertEvdnc", paramMap);
	}

	@Override
	public Map selectEvdnc(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectEvdnc", paramMap);
	}
	
	@Override
	public int updateEvdncDeleteFlag(Map<String, Object> paramMap) throws Exception {
		return sqlSession.update(Namespace + ".updateEvdncDeleteFlag", paramMap);
	}

	@Override
	public int deleteEvdncList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.insert(Namespace + ".deleteEvdncList", paramMap);
	}
}