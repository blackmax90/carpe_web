package com.carpe.common;

import org.springframework.http.HttpHeaders;

public class Consts {
	public static final String FOLDER_OPEN_IMAGE = "/carpe/resources/images/folderOpen.gif";
	public static final String FOLDER_CLOSED_IMAGE = "/carpe/resources/images/folderClosed.gif";

	public static final int PAGE_SZIE = 100;

	public static final String SESSION_CASE_ID = "case_id";
	public static final String SESSION_CASE_NAME = "case_name";

	public static final String SESSION_EVDNC_ID = "evdnc_id";
	public static final String SESSION_EVDNC_NAME = "evdnc_name";

	public static final long TREE_ROOT_ID = 5;
	public static final long DIR_TYPE = 3;
	
	public static final int ADMIN_GRADE = 1;

	public static HttpHeaders responseHeaders = new HttpHeaders();
	
	static {
		responseHeaders.add("Content-Type", "application/json; charset=UTF-8");
	}

}