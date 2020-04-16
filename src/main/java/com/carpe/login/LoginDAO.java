package com.carpe.login;

import java.util.Map;

public interface LoginDAO {
	public UserVO selectUser(Map<String, Object> paramMap) throws Exception;

	public Map selectUserCnt(Map<String, Object> paramMap) throws Exception;

	public void insertUser(Map<String, Object> paramMap) throws Exception;
}