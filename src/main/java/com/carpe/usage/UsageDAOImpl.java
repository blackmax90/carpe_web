package com.carpe.usage;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class UsageDAOImpl implements UsageDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.usage";
	
	@Override
	public List<Map> selectUsageYearList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectUsageYearList", paramMap);
	}

	@Override
	public List<Map> selectUsageMonthList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectUsageMonthList", paramMap);
	}
	
	@Override
	public List<Map> selectUsageDayList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectUsageDayList", paramMap);
	}

}