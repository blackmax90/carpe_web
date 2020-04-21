package com.carpe.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.carpe.common.Consts;
import com.carpe.login.UserVO;

public class AuthenticationInterceptor extends HandlerInterceptorAdapter {

	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String reqUri = request.getRequestURI();
		
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("userInfo");

		if (obj == null) {
			response.sendRedirect("/carpe/login.do");
			return false;
		}

		if (reqUri.startsWith("/carpe/config/")) {
			if (((UserVO) obj).getGrade() != Consts.ADMIN_GRADE) {
				response.sendRedirect("/carpe/login.do");
				return false;
			}
		}

		return true;
	}

	// 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
}
