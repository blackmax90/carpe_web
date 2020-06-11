package com.carpe.recyclebin;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class RecyclebinDAOImpl implements RecyclebinDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.recyclebin";

	@Override
	public List<Map> selectYearList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectYearList", paramMap);
	}
	
	@Override
	public List<Map> selectRecyclebinYearList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectRecyclebinYearList", paramMap);
	}

	@Override
	public List<Map> selectRecyclebinMonthList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectRecyclebinMonthList", paramMap);
	}

	@Override
	public List<Map> selectRecyclebinDayList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectRecyclebinDayList", paramMap);
	}

	@Override
	public List<Map> selectRecyclebinHourList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectRecyclebinHourList", paramMap);
	}

	@Override
	public List<Map> selectRecyclebinList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectRecyclebinList", paramMap);
	}
}