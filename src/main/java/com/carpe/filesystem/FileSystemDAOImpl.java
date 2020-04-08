package com.carpe.filesystem;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class FileSystemDAOImpl implements FileSystemDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.carpe.mapper.filesystem";

	@Override
	public List<Map> selectDirList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectDirList", paramMap);
	}
	
	@Override
	public List<Map> selectPartList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectPartList", paramMap);
	}

	@Override
	public List<Map> selectFileList(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectFileList", paramMap);
	}

	@Override
	public List<Map> selectDateTreeMap(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectList(Namespace + ".selectDateTreeMap", paramMap);
	}

	@Override
	public Map selectFileInfo(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne(Namespace + ".selectFileInfo", paramMap);
	}
}