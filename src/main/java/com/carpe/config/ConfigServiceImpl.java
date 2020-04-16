package com.carpe.config;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.carpe.common.CommonUtil;

@Service
public class ConfigServiceImpl implements ConfigService {

	@Inject
	private ConfigDAO dao;

	@Override
	public List<Map> selectUserList(Map<String, Object> paramMap) throws Exception {
		return dao.selectUserList(paramMap);
	}

	@Override
	public List<Map> selectCaseUserAuthList(Map<String, Object> paramMap) throws Exception {
		return dao.selectCaseUserAuthList(paramMap);
	}

	@Override
	public List<Map> selectCaseList(Map<String, Object> paramMap) throws Exception {
		return dao.selectCaseList(paramMap);
	}

	@Override
	public Map selectCaseListCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectCaseListCount(paramMap);
	}

	@Override
	public int insertCaseUserAuth(String id, String caseidList) throws Exception {
		int ret = 0;

		try {
			if (CommonUtil.empty(caseidList)) {
				return ret;
			}

			String[] arrCaseid = caseidList.split("\\|");
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("id", id);
			
			for (String caseid : arrCaseid) {
				if (CommonUtil.empty(caseid)) {
					continue;
				}
				
				paramMap.put("case_id", caseid);
				dao.insertCaseUserAuth(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			ret = -1;
		}
		
		return ret;
	}

	@Override
	public int deleteCaseUserAuth(String id, String caseidList) throws Exception {
		int ret = 0;

		try {
			if (CommonUtil.empty(caseidList)) {
				return ret;
			}

			String[] arrCaseid = caseidList.split("\\|");
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("id", id);
			
			for (String caseid : arrCaseid) {
				if (CommonUtil.empty(caseid)) {
					continue;
				}
				
				paramMap.put("case_id", caseid);
				dao.deleteCaseUserAuth(paramMap);
			}
		} catch (Exception e) {
			e.printStackTrace();
			ret = -1;
		}
		
		return ret;
	}
}