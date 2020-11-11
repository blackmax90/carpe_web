package com.carpe.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.carpe.evdnc.EvdncDAO;
import com.carpe.overview.OverviewDAO;

@Service
public class ReportServiceImpl implements ReportService {

	@Inject
	private ReportDAO dao;

	@Inject
	private OverviewDAO overviewDao;

	@Override
	public Map selectCaseInfo(Map<String, Object> paramMap) throws Exception {
		return dao.selectCaseInfo(paramMap);
	}

	@Override
	public List<Map> getEvdncInfo(Map<String, Object> paramMap) throws Exception {
	  List<Map> evdncList = dao.selectEvdncList(paramMap);
		Map<String, Object> pMap = null;
		String caseid = (String) paramMap.get("case_id");
		
	  for (Map map : evdncList) {
	    String evdid = (String) map.get("evd_id");

	    pMap = new HashMap<String, Object>();
	    pMap.put("case_id", caseid);
	    pMap.put("evd_id", evdid);

	    List<Map> parList = dao.selectPartitionList(pMap);
	    List<Map> osList = dao.selectOsList(pMap);
	    
	    for (Map parMap : parList) {
	      String parid = (String) parMap.get("par_id");
	      HashMap<String, Object> pMap2 = new HashMap<String, Object>();
	      pMap2.put("case_id", caseid);
	      pMap2.put("evd_id", evdid);
	      pMap2.put("par_id", parid);

	      List<Map> uaList = dao.selectUserAccountList(pMap2);
	      parMap.put("uaList", uaList);
      }

//	    Map artCnt = dao.selectArtifactCount(pMap);
	    
	    map.put("parList", parList);
	    map.put("osList", osList);
//	    map.put("artCnt", artCnt);
    }
	  
	  return evdncList;
	}

	@Override
	public Map getCaseInfo(Map<String, Object> paramMap) throws Exception {
		return overviewDao.selectCaseInfo(paramMap);
	}
}