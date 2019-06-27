package com.carpe.login;

import java.util.Map;

public interface LoginService {
	public UserVO selectUser(Map<String, Object> paramMap) throws Exception;
}