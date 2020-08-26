package com.carpe.mft;

import java.util.List;
import java.util.Map;

public interface MftService {
	public List<Map> selectMftHistoryList(Map<String, Object> paramMap) throws Exception;
	public Map selectMftHistoryCopyRate(Map<String, Object> paramMap) throws Exception;
  public List getEvdncList(String caseid) throws Exception;
  public List<Map> getFileDirList(String caseid, String evdid, String evdName, String dirType, String parId, String parentId) throws Exception;
  public List<Map> getParDirList(String evdid, String evdName) throws Exception;
}