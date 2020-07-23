package com.carpe.filesystem;

import java.util.List;
import java.util.Map;

public interface FileSystemService {
	public List<Map> selectDirList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectPartList(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectFileList(Map<String, Object> paramMap) throws Exception;
	public Map selectFileListCount(Map<String, Object> paramMap) throws Exception;
	public List<Map> selectDateTreeMap(Map<String, Object> paramMap) throws Exception;
	public Map selectFileInfo(Map<String, Object> paramMap) throws Exception;
	public List<Map> getDirList(String evdid, String evdName) throws Exception;
	public List<Map> getFileDirList(String evdid, String evdName, String dataAttr, String id, String parentId) throws Exception;
	public List getEvdncList(String caseid, String selEvdid) throws Exception;
}