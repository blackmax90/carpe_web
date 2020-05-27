package com.carpe.gps;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.HttpClientBuilder;
import org.springframework.stereotype.Service;

import com.carpe.common.CarpeConfig;
import com.carpe.common.CommonUtil;
import com.carpe.common.Consts;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class GpsServiceImpl implements GpsService {

	@Inject
	private GpsDAO dao;

	@Override
	public List<Map> selectGpsList(Map<String, Object> paramMap) throws Exception {
		return dao.selectGpsList(paramMap);
	}

	@Override
	public List<Map> selectGpsLinkList(Map<String, Object> paramMap) throws Exception {
		return dao.selectGpsLinkList(paramMap);
	}

	@Override
	public List<Map> selectGpsDateCount(Map<String, Object> paramMap) throws Exception {
		return dao.selectGpsDateCount(paramMap);
	}

	@Override
	public List<Map> selectGpsFileList(Map<String, Object> paramMap) throws Exception {
		return dao.selectGpsFileList(paramMap);
	}

	@Override
	public List<Map> selectCommunicationRoomList(Map<String, Object> paramMap) throws Exception {
		return dao.selectCommunicationRoomList(paramMap);
	}

	@Override
	public List<Map> selectCommunicationDataList(Map<String, Object> paramMap) throws Exception {
		return dao.selectCommunicationDataList(paramMap);
	}
	
	/**
	 * 상세 경로 획득
	 * @param caseid
	 * @param sdate
	 * @param edate
	 * @param mode 
	 * @return
	 */
	@Override
	public Map<String, Object> getDetailPath(Map<String, String> data) {
		HashMap<String, Object> retMap = new HashMap<>();
		List<Map> retList = new ArrayList<>();
		List<Map> gpsList = null;
		List<Map> spcdeList = new ArrayList<>();		//공휴일 처리용 List

		try {
			String caseid = data.get("caseid");		//caseid
			String sdate = data.get("sdate");		  //시작일
			String edate = data.get("edate");		  //종료일
			String stime = data.get("stime");		  //시작시간
			String etime = data.get("etime");		  //종료시간
			String mode = data.get("mode");				//0: 길찾기, 1: 직선경로
			String holiday = data.get("chk1");		//공휴일만
			String neholiday = data.get("chk2");	//공휴일만 제외
			String weekend = data.get("chk3");		//주말만
			String neweekend = data.get("chk4");	//주말만 제외
			String firstData = data.get("chk5");	//첫 데이터만
			String lastData = data.get("chk6");		//마지막 데이터만
			int timeType = 1;
			
			if (CommonUtil.notEmpty(stime) && CommonUtil.notEmpty(etime)) {
				SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
				Calendar sCal = new GregorianCalendar();
				Calendar eCal = new GregorianCalendar();
				sCal.setTime(format.parse(stime));
				eCal.setTime(format.parse(etime));
				
				if (sCal.getTimeInMillis() <= eCal.getTimeInMillis()) {
					timeType = 1;
				} else {
					timeType = 2;
				}
			}
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("case_id", caseid);
			paramMap.put("sdate", sdate);
			paramMap.put("edate", edate);
			paramMap.put("timeType", timeType);
			paramMap.put("stime", stime);
			paramMap.put("etime", etime);
			paramMap.put("weekend", weekend);
			paramMap.put("neweekend", neweekend);

			gpsList = selectGpsLinkList(paramMap);
			
			//공휴일만, 공휴일만 제외
			if ((holiday != null && holiday.equals("1"))
					|| (neholiday != null && neholiday.equals("1"))) {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM");
				Calendar sCal = new GregorianCalendar();
				Calendar eCal = new GregorianCalendar();
				sCal.setTime(format.parse(sdate.substring(0, 7)));
				eCal.setTime(format.parse(edate.substring(0, 7)));
				
				while (sCal.getTimeInMillis() <= eCal.getTimeInMillis()) {
					String yearStr = sCal.get(Calendar.YEAR) + "";
					int month = sCal.get(Calendar.MONTH) + 1;
					String monthStr = month + "";
					
					if (month < 10) {
						monthStr = "0" + monthStr;
					}

					List<Map> tmpList = CommonUtil.getSpcdeInfoService(yearStr, monthStr);
					spcdeList.addAll(tmpList);

					sCal.add(Calendar.MONTH, 1);
				}
				
				List<Map> tmpList = new ArrayList<>();

				/*
				for (Map map : spcdeList) {
					System.out.println(">> : " + map.get("locdate") + ", " + map.get("dateName") + ", " + map.get("isHoliday"));
				}
				*/

				for (Map map : gpsList) {
					boolean flag = false;
					String regd = (String)map.get("regd");
					regd = regd.replaceAll("-", "").substring(0, 8);

					for (Map spcdeMap : spcdeList) {
						if (spcdeMap.get("isHoliday").equals("Y") == false) {
							continue;
						}

						if (spcdeMap.get("locdate").equals(regd)) {
							flag = true;
							break;
						}
					}

					if (holiday != null && holiday.equals("1") == true) {
						//공휴일만
						if (flag == true) {
							tmpList.add(map);
						}
					} else if (neholiday != null && neholiday.equals("1") == true) {
						//공휴일만 제외
						if (flag == false) {
							tmpList.add(map);
						}
					}
				}
				
				gpsList = tmpList;
			}
			
			//첫 데이터만
			if (firstData != null && firstData.equals("1") && gpsList.size() > 0) {
				List<Map> tmpList = new ArrayList<>();
				String prevRegd = "";

				for (Map map : gpsList) {
					String regd = (String) map.get("regd");
					
					if (CommonUtil.empty(regd)) {
						continue;
					}
					
					regd = regd.substring(0, 10);
					
					if (prevRegd.equals(regd) == false) {
						prevRegd = regd;
						tmpList.add(map);
					}
				}

				gpsList = tmpList;
			}

			//마지막 데이터만
			if (lastData != null && lastData.equals("1") && gpsList.size() > 0) {
				List<Map> tmpList = new ArrayList<>();
				String prevRegd = "";

				for (int i = gpsList.size() - 1; i >= 0; i--) {
					Map map = gpsList.get(i);
					String regd = (String) map.get("regd");
					
					if (CommonUtil.empty(regd)) {
						continue;
					}

					regd = regd.substring(0, 10);
					
					if (prevRegd.equals(regd) == false) {
						prevRegd = regd;
						tmpList.add(0, map);
					}
				}

				gpsList = tmpList;
			}
			
			int totalCnt = gpsList.size();
			int limitCnt = 17;	// 시작, 종료, 경유지 합계 최대
			String curl = "";		//길찾기 API URL
			String start = "";
			String goal = "";
			String waypoints = "";
			boolean endFlag = false;
			
			if (totalCnt == 0) {
				retMap.put("ret", -1);
				retMap.put("msg", "해당 기간의 이동 경로가 없습니다.");
				retMap.put("list", retList);
				return retMap;
			}
			
			if (mode != null && mode.equals("1")) {
				retList = gpsList;
				retMap.put("ret", 0);
				retMap.put("msg", "");
				retMap.put("list", retList);
				return retMap;
			}

			if (totalCnt > Consts.GPS_LIMIT_COUNT) {
				retList = gpsList;
				retMap.put("ret", -1);
				retMap.put("msg", "경로가 너무 많습니다.[" + totalCnt + "]");
				retMap.put("list", retList);
				return retMap;
			}

			for (int i = 0, idx = 0; i < gpsList.size(); i++, idx++) {
				Map gpsMap = gpsList.get(i);

				if (idx == 0) {
					//시작
					start = gpsMap.get("longitude") + "," + gpsMap.get("latitude");
				} else if (idx == totalCnt - 1 || idx == limitCnt - 1) {
					//종료
					goal = gpsMap.get("longitude") + "," + gpsMap.get("latitude");
					endFlag = true;
				} else {
					//경유지
					if ("".equals(waypoints) == false) {
						waypoints += "|";
					}

					waypoints += gpsMap.get("longitude") + "," + gpsMap.get("latitude");
				}

				if (endFlag == true) {
					if (idx < 1) {
						//데이터가 없는 경우
						break;
					} else if (idx < 7) {
						//시작, 종료, 경유지 최대 5개
						curl = "https://naveropenapi.apigw.ntruss.com/map-direction/v1/driving";		//길찾기 API URL 경유지 5개 이하
					} else {
						//시작, 종료, 경유지 최대 15개
						curl = "https://naveropenapi.apigw.ntruss.com/map-direction-15/v1/driving";		//길찾기 API URL 경유지 15개 이하
					}

					curl += "?start=" + URLEncoder.encode(start, "UTF-8");
					curl += "&goal=" + URLEncoder.encode(goal, "UTF-8");

					if ("".equals(waypoints) == false) {
						curl += "&waypoints=" + URLEncoder.encode(waypoints, "UTF-8");
					}

					System.out.println("curl : " + curl);

					HttpClient client = HttpClientBuilder.create().build();
					HttpGet getRequest = new HttpGet(curl);		//Get
					getRequest.addHeader("X-NCP-APIGW-API-KEY-ID", CarpeConfig.getNcpClientId()); //NCP Client ID
					getRequest.addHeader("X-NCP-APIGW-API-KEY", CarpeConfig.getNcpClientSecret()); //NCP Client Secret

					HttpResponse response = client.execute(getRequest);

					//Response 출력
					if (response.getStatusLine().getStatusCode() == 200) {
						ResponseHandler<String> handler = new BasicResponseHandler();
						String body = handler.handleResponse(response);

						//System.out.println(body);

						ObjectMapper mapper = new ObjectMapper();
						Map<String, Object> rsMap = mapper.readValue(body, Map.class);
						int code = Integer.parseInt(rsMap.get("code") + "");
						String msg = rsMap.get("message") + "";

						if (code == 0) {
							Map<String, Object> routeMap = (Map<String, Object>)rsMap.get("route");
							List<Map<String, Object>> traMap = (List<Map<String, Object>>) routeMap.get("traoptimal");
							List<List<Double>> path = (List<List<Double>>) traMap.get(0).get("path");

							for (List<Double> list : path) {
								HashMap<String, String> tmpMap = new HashMap<>();
								tmpMap.put("longitude", list.get(0) + "");
								tmpMap.put("latitude", list.get(1) + "");
								retList.add(tmpMap);
							}
						} else {
							System.out.println("error msg : [" + code + "] " + msg);
							retList = gpsList;
							break;
						}

					} else {
						System.out.println("response is error : " + response.getStatusLine().getStatusCode());
						retList = gpsList;
						break;
					}
					
					//초기화
					totalCnt -= idx;
					i--;			//종료 위치를 다시 시작위치로 잡기위해 -1
					idx = -1;
					endFlag = false;
					curl = "";
					start = "";
					goal = "";
					waypoints = "";
				}
			}
		} catch (Exception e){
			e.printStackTrace();
		}
		
		if (retList == null || retList.size() == 0) {
			retList = gpsList;
		}
		
		retMap.put("ret", 0);
		retMap.put("msg", "");
		retMap.put("list", retList);
		return retMap;
	}
}