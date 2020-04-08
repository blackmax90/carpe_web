package com.carpe.filesystem;

import java.util.List;
import java.util.Map;

public interface FileSystemDAO {
	public List<Map> selectDirList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectPartList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectFileList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectDateTreeMap(Map<String, Object> paramMap) throws Exception;
	public Map selectFileInfo(Map<String, Object> paramMap) throws Exception;
}