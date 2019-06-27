package com.carpe.login;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {

	@Inject
	private LoginDAO dao;

	@Override
	public UserVO selectUser(Map<String, Object> paramMap) throws Exception {
		return dao.selectUser(paramMap);
	}
}