package com.carpe.ntfs;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class NtfsDAOImpl implements NtfsDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.ntfs";

	@Override
	public List<Map> selectNtfsHistoryYearList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectNtfsHistoryYearList", paramMap);
	}

	@Override
	public List<Map> selectNtfsHistoryList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectNtfsHistoryList", paramMap);
	}

	@Override
	public List<Map> selectNtfsHistoryCountList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectNtfsHistoryCountList", paramMap);
	}
}