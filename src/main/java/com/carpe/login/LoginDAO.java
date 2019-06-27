package com.carpe.login;

import java.util.Map;

public interface LoginDAO {
	public UserVO selectUser(Map<String, Object> paramMap) throws Exception;
}