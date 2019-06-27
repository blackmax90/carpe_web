package com.carpe.filesystem;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class FileSystemServiceImpl implements FileSystemService {

	@Inject
	private FileSystemDAO dao;

	@Override
	public List<Map> selectDirList(Map<String, Object> paramMap) throws Exception {
		return dao.selectDirList(paramMap);
	}

	@Override
	public List<Map> selectFileList(Map<String, Object> paramMap) throws Exception {
		return dao.selectFileList(paramMap);
	}
}