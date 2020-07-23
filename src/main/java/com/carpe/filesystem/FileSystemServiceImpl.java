package com.carpe.filesystem;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.carpe.common.Consts;
import com.carpe.evdnc.EvdncDAO;

@Service
public class FileSystemServiceImpl implements FileSystemService {

	@Inject
	private FileSystemDAO dao;

	@Inject
	private EvdncDAO evdncDao;

	@Override
	public List<Map> selectDirList(Map<String, Object> paramMap) throws Exception {
		return dao.selectDirList(paramMap);
	}
	
	@Override
	public List<Map> selectPartList(Map<String, Object> paramMap) throws Exception {
		return dao.selectPartList(paramMap);
	}

	@Override
	public List<Map> selectFileList(Map<String, Object> paramMap) throws Exception {
		return dao.selectFileList(paramMap);
	}

	@Override
	public Map selectFileListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectFileListCount(paramMap);
	}

	@Override
	public List<Map> selectDateTreeMap(Map<String, Object> paramMap) throws Exception {
		return dao.selectDateTreeMap(paramMap);
	}

	@Override
	public Map selectFileInfo(Map<String, Object> paramMap) throws Exception {
		return dao.selectFileInfo(paramMap);
	}

	@Override
	public List<Map> getDirList(String evdid, String evdName) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("evd_id", evdid);
		List<Map> dirList = this.selectPartList(paramMap);
		List<Map> retList = new ArrayList<>();

		for (int i = 0; i < dirList.size(); i++) {
			String fileSystem = (String) dirList.get(i).get("filesystem");
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
			data.put("label", dirList.get(i).get("par_name"));
			data.put("icon", Consts.FOLDER_CLOSED_IMAGE);
			data.put("iconsize", "18");

			Map value = new HashMap();
			value.put("evd_id", evdid);
			value.put("evd_name", evdName);
			value.put("id", dirList.get(i).get("par_id"));
			value.put("par_id", dirList.get(i).get("par_id"));
			value.put("attr", "par");
			value.put("parentId", parentId);
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
	public List<Map> getFileDirList(String evdid, String evdName, String dataAttr, String id, String parentId) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("evd_id", evdid);
		List<Map> retList = new ArrayList<>();

		//parent媛� partion �냽�꽦�씪 寃쎌슦
//		if ("par".equals(dataAttr)) {
//			paramMap.put("par_id", id);
//		}
		paramMap.put("par_id", id);
		paramMap.put("id", parentId);
		List<Map> dirList = this.selectDirList(paramMap);

		for (int i = 0; i < dirList.size(); i++) {
			Map data = new HashMap();
			data.put("label", dirList.get(i).get("name"));
			data.put("icon", Consts.FOLDER_CLOSED_IMAGE);
			data.put("iconsize", "18");
			
			Map value = new HashMap();
			value.put("evd_id", evdid);
			value.put("evd_name", evdName);
			value.put("par_id",dirList.get(i).get("par_id"));
			value.put("id", dirList.get(i).get("id"));
			value.put("parentId", dirList.get(i).get("id"));
			value.put("isLoaded", false);
			value.put("attr", "dir");
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
	public List getEvdncList(String caseid, String selEvdid) throws Exception {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("case_id", caseid);
		List<Map> retList = new ArrayList<>();

		List<Map> evdncList = evdncDao.selectEvdncList(paramMap);

		for (int i = 0; i < evdncList.size(); i++) {
			String evdid = (String)evdncList.get(i).get("evd_id");
			String evdName = (String)evdncList.get(i).get("evd_name");

			Map data = new HashMap();
			data.put("label", evdName);
			data.put("icon", Consts.FOLDER_CLOSED_IMAGE);
			data.put("iconsize", "18");

			Map value = new HashMap();
			value.put("evd_id", evdid);
			value.put("evd_name", evdName);
			value.put("id", "");
			value.put("parentId", "");
			value.put("attr", "evd");
			value.put("isLoaded", false);
			data.put("value", value);

			if (selEvdid.equals(evdid) == true) {
				data.put("selected", true);
				data.put("expanded", true);
				List childList = this.getDirList(evdid, evdName);

				value.put("isLoaded", true);
				data.put("items", childList);
			} else {
				List loading = new ArrayList();
				Map dummy = new HashMap();
				dummy.put("label", "Loading...");
				loading.add(dummy);

				data.put("items", loading);
			}

			retList.add(data);
		}
		return retList;
	}
}