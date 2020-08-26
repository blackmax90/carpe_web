package com.carpe.mft;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.carpe.common.Consts;
import com.carpe.evdnc.EvdncDAO;
import com.carpe.filesystem.FileSystemDAO;

@Service
public class MftServiceImpl implements MftService {

	@Inject
	private MftDAO dao;

	@Inject
	private EvdncDAO evdncDao;

	@Inject
	private FileSystemDAO fileDao;

	@Override
	public List<Map> selectMftHistoryList(Map<String, Object> paramMap) throws Exception {
		return dao.selectMftHistoryList(paramMap);
	}

	@Override
	public Map selectMftHistoryCopyRate(Map<String, Object> paramMap) throws Exception {
		return dao.selectMftHistoryCopyRate(paramMap);
	}

	@Override
	public List<Map> getParDirList(String evdid, String evdName) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("evd_id", evdid);
		List<Map> dirList = fileDao.selectPartList(paramMap);
		List<Map> retList = new ArrayList<>();

		for (Map dirMap : dirList) {
			String fileSystem = (String) dirMap.get("filesystem");
			long parentId = Consts.TREE_ROOT_ID;
			
			if ("TSK_FS_TYPE_EXT4".equals(fileSystem)) {
				parentId = Consts.TSK_FS_TYPE_EXT4;
			} else if ("TSK_FS_TYPE_FAT32".equals(fileSystem)) {
				parentId = Consts.TSK_FS_TYPE_FAT32;
			} else if ("TSK_FS_TYPE_NTFS_DETECT".equals(fileSystem)) {
				parentId = Consts.TSK_FS_TYPE_NTFS_DETECT;
			} else if ("TSK_FS_TYPE_NTFS".equals(fileSystem)) {
				parentId = Consts.TSK_FS_TYPE_NTFS;
			}

			Map data = new HashMap();
			data.put("label", "<div style='float:left;margin-right:5px;'><img src='/carpe/resources/images/ico_folder_default.svg' /></div>" + dirMap.get("par_name"));

			Map value = new HashMap();
			value.put("evd_id", evdid);
			value.put("evd_name", evdName);
			value.put("par_id", dirMap.get("par_id"));
			value.put("id", parentId);
			value.put("filename", dirMap.get("par_name"));
			value.put("attr", "par");
			value.put("isLoaded", false);
			data.put("value", value);

			List loading = new ArrayList();
			Map dummy = new HashMap();
			dummy.put("label", "Loading...");
			loading.add(dummy);

			data.put("items", loading);

			retList.add(data);
		}

		return retList;
	}

	@Override
	public List<Map> getFileDirList(String caseid, String evdid, String evdName, String dirType, String parid, String parentid) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("evd_id", evdid);
		List<Map> retList = new ArrayList<>();
		
		paramMap.put("case_id", caseid);
		paramMap.put("evd_id", evdid);
		paramMap.put("par_id", parid);
		paramMap.put("id", parentid);
		paramMap.put("dir_type", dirType);
		
		List<Map> dirList = fileDao.selectDirList(paramMap);

		for (Map dirMap : dirList) {
			Map data = new HashMap();
			String filename = (String) dirMap.get("name");
			long fileid = (Long) dirMap.get("id");

			data.put("label", "<div style='float:left;margin-right:5px;'><img src='/carpe/resources/images/ico_folder_default.svg' /></div>" + filename);
			
			Map value = new HashMap();
			value.put("evd_id", evdid);
			value.put("evd_name", evdName);
			value.put("par_id", parid);
			value.put("id", fileid);
			value.put("filename", filename);
			value.put("attr", "dir");
			value.put("isLoaded", false);
			data.put("value", value);

			List loading = new ArrayList();
			Map dummy = new HashMap();
			dummy.put("label", "Loading...");
			loading.add(dummy);

			data.put("items", loading);

			retList.add(data);
		}

		return retList;
	}

	@Override
	public List getEvdncList(String caseid) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", caseid);
		List<Map> retList = new ArrayList<>();

		List<Map> evdncList = evdncDao.selectEvdncList(paramMap);

		for (int i = 0; i < evdncList.size(); i++) {
			String evdid = (String)evdncList.get(i).get("evd_id");
			String evdName = (String)evdncList.get(i).get("evd_name");

			Map data = new HashMap();
			data.put("label", "<div style='float:left;margin-right:5px;'><img src='/carpe/resources/images/ico_folder_default.svg' /></div>" + evdName);

			Map value = new HashMap();
			value.put("evd_id", evdid);
			value.put("evd_name", evdName);
			value.put("par_id", "");
			value.put("id", "");
			value.put("filename", evdName);
			value.put("attr", "evd");
			value.put("isLoaded", false);
			data.put("value", value);

			List loading = new ArrayList();
			Map dummy = new HashMap();
			dummy.put("label", "Loading...");
			loading.add(dummy);

			data.put("items", loading);

			retList.add(data);
		}

		return retList;
	}
}