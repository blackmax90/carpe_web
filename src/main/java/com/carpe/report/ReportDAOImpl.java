package com.carpe.report;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class ReportDAOImpl implements ReportDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.report";
	
	@Override
	public Map selectCaseInfo(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectCaseInfo", paramMap);
	}

	@Override
	public List<Map> selectEvdncList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectEvdncList", paramMap);
	}

	@Override
	public List<Map> selectPartitionList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectPartitionList", paramMap);
	}

	@Override
	public List<Map> selectOsList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectOsList", paramMap);
	}

	@Override
	public List<Map> selectUserAccountList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectUserAccountList", paramMap);
	}

	@Override
	public Map selectArtifactCount(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectArtifactCount", paramMap);
	}
}