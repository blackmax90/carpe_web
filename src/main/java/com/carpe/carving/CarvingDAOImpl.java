package com.carpe.carving;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class CarvingDAOImpl implements CarvingDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.carving";

	@Override
	public List<Map> selectCarvingList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectCarvingList", paramMap);
	}

	@Override
	public Map selectCarvingListCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectCarvingListCount", paramMap);
	}
	
}