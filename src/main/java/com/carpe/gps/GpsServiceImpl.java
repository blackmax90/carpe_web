package com.carpe.gps;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
	
	/**
	 * 상세 경로 획득
	 * @param paramMap
	 * @return
	 */
	@Override
	public List<Map> getDetailPath(Map<String, Object> paramMap) {
		List<Map> retList = new ArrayList<>();
		List<Map> gpsList = null;

		try {
			gpsList = selectGpsLinkList(paramMap);
			int totalCnt = gpsList.size();
			int limitCnt = 17;	// 시작, 종료, 경유지 합계 최대
			String curl = "";		//길찾기 API URL 경유지 5개 이하
			String start = "";
			String goal = "";
			String waypoints = "";
			boolean endFlag = false;

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
			System.err.println(e.toString());
		}
		
		if (retList == null || retList.size() == 0) {
			retList = gpsList;
		}
		
		return retList;
	}
}