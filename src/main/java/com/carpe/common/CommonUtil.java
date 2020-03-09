package com.carpe.common;

import java.io.IOException;
import java.io.StringReader;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathFactory;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class CommonUtil {
	public static Boolean empty(Object obj) {
		if (obj instanceof String)
			return obj == null || "".equals(obj.toString().trim());
		else if (obj instanceof List)
			return obj == null || ((List<?>) obj).isEmpty();
		else if (obj instanceof Map)
			return obj == null || ((Map<?, ?>) obj).isEmpty();
		else if (obj instanceof Object[])
			return obj == null || Array.getLength(obj) == 0;
		else
			return obj == null;
	}

	public static Boolean notEmpty(Object obj) {
		return !empty(obj);
	}

	/**
	 * 공공 데이터 포털 API를 이용하여 특일 정보(휴일, 공휴일)를 가져온다
	 * @param year
	 * @param month
	 * @throws IOException 
	 * @throws ClientProtocolException 
	 * @return
	 */
	public static List<Map> getSpcdeInfoService(String year, String month) {
		List<Map> rsList = new ArrayList<>();
		
		if (empty(year) == true || empty(month) == true) {
			return rsList;
		}
		
		try {
			String url = "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo?solYear=" 
					+ year + "&solMonth=" + month + "&ServiceKey=" + CarpeConfig.getSpcdeInfoServiceKey();

			System.out.println("url : " + url);

			HttpClient client = HttpClientBuilder.create().build();
			HttpGet getRequest = new HttpGet(url);		//Get

			HttpResponse response = client.execute(getRequest);

			//Response 출력
			if (response.getStatusLine().getStatusCode() == 200) {
				HttpEntity resEntity = response.getEntity();
				String body = "";

				if (resEntity != null) {
					body = EntityUtils.toString(resEntity, "utf-8");
				}

				System.out.println(body);

				InputSource is = new InputSource(new StringReader(body));
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
				DocumentBuilder builder = factory.newDocumentBuilder();
				Document doc = builder.parse(is);
				XPathFactory xpathFactory = XPathFactory.newInstance();
				XPath xpath = xpathFactory.newXPath();
				XPathExpression expr = xpath.compile("//items/item");
				NodeList nodeList = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);

				for (int i = 0; i < nodeList.getLength(); i++) {
					NodeList child = nodeList.item(i).getChildNodes();
					HashMap<String, String> data = new HashMap<>();
					rsList.add(data);

					for (int j = 0; j < child.getLength(); j++) {
						Node node = child.item(j);
						data.put(node.getNodeName(), node.getTextContent());
					}
				}
			} else {
				System.out.println("response is error : " + response.getStatusLine().getStatusCode());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return rsList;
	}
}
