package com.carpe.common;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class CarpeConfig {
	private static String KEY;

	private static String CASE_CODE;

	private static String EVDNC_CODE;
	private static String EVDNC_BASE_PATH;
	private static String EVDNC_BASE_TMP_PATH;

	private static String MQ_SERVER;
	private static String MQ_QUEUE;
	private static String MQ_ID;
	private static String MQ_PW;
	private static String MQ_VHOST;
	
	private static String NCP_CLIENT_ID;
	private static String NCP_CLIENT_SECRET;
	
	private static String SPCDE_INFO_SERVICE_KEY;
	
	@Value("#{carpe_config['case.code']}")
	public void setCaseCode(String code) {
		CASE_CODE = code;
	}

	@Value("#{carpe_config['evdnc.code']}")
	public void setEvdncCode(String code) {
		EVDNC_CODE = code;
	}

	@Value("#{carpe_config['evdnc.base.path']}")
	public void setEvdncBasePath(String path) {
		if (path.endsWith("/") || path.endsWith("\\")) {
			EVDNC_BASE_PATH = path.substring(0, path.length() - 1);
		} else {
			EVDNC_BASE_PATH = path;
		}
	}

	@Value("#{carpe_config['evdnc.base.tmp.path']}")
	public void setEvdncBaseTmpPath(String path) {
		if (path.endsWith("/") || path.endsWith("\\")) {
			EVDNC_BASE_TMP_PATH = path.substring(0, path.length() - 1);
		} else {
			EVDNC_BASE_TMP_PATH = path;
		}
	}

	@Value("#{carpe_config['mq.server']}")
	public void setMqServer(String server) {
		MQ_SERVER = server;
	}

	@Value("#{carpe_config['mq.queue']}")
	public void setMqQueue(String queue) {
		MQ_QUEUE = queue;

		System.out.println("MQ_QUEUE=" + MQ_QUEUE);
	}
	
	@Value("#{carpe_config['mq.vhost']}")
	public void setMqVhost(String vhost)	{
		MQ_VHOST = vhost;
	}
	
	@Value("#{carpe_config['mq.id']}")
	public void setMqId(String id) {
		MQ_ID = id;
	}
	
	@Value("#{carpe_config['mq.pw']}")
	public void setMqPw(String pw)	{
		MQ_PW = pw;
	}

	@Value("#{carpe_config['ncp.clientid']}")
	public void setNcpClientId(String id)	{
		NCP_CLIENT_ID = id;
	}

	@Value("#{carpe_config['ncp.clientsecret']}")
	public void setNaverClientSecret(String sec)	{
		NCP_CLIENT_SECRET = sec;
	}

	@Value("#{carpe_config['data.go.kr.spcdeinfoservicekey']}")
	public void setSpcdeInfoServiceKey(String spcdeInfoServiceKey) {
		SPCDE_INFO_SERVICE_KEY = spcdeInfoServiceKey;
	}

	public static String getCaseCode() {
		return CASE_CODE;
	}

	public static String getEvdncCode() {
		return EVDNC_CODE;
	}

	public static String getEvdncBasePath() {
		return EVDNC_BASE_PATH;
	}

	public static String getEvdncBaseTmpPath() {
		return EVDNC_BASE_TMP_PATH;
	}

	public static String getKey() {
		return KEY;
	}

	public static String getMqServer() {
		return MQ_SERVER;
	}

	public static String getMqQueue() {
		return MQ_QUEUE;
	}
	
	public static String getMqId()	{
		return MQ_ID;
	}
	
	public static String getMqPw()	{
		return MQ_PW;
	}
	
	public static String getMqVhost()	{
		return MQ_VHOST;
	}
	
	public static String getNcpClientId() {
		return NCP_CLIENT_ID;
	}

	public static String getNcpClientSecret() {
		return NCP_CLIENT_SECRET;
	}

	public static String getSpcdeInfoServiceKey() {
		return SPCDE_INFO_SERVICE_KEY;
	}

	// if key not exists null value
	@Value("#{carpe_config['key']}")
	private String key;

	public String configKey() {
		return key;
	}

	@Value("#{carpe_config['key']}")
	private void setKey(String key) {
		KEY = key;
	}
}
