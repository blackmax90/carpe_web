package com.carpe.login;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {

	// private static final Logger logger =
	// LoggerFactory.getLogger(LoginController.class);

	@Inject
	private LoginService service;

	@RequestMapping(value = "/login.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView login(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		// 로그인되어 있으면
		if (session.getAttribute("userInfo") != null) {
			mav.setViewName("forward:/case.do");
			return mav;
		}

		if (session.getAttribute("userInfo") == null && map.get("userId") == null) {
			mav.setViewName("carpe/login/login");
			return mav;
		}

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("user_id", map.get("userId"));
		paramMap.put("user_passwd", map.get("userPassword"));

		UserVO userInfo = service.selectUser(paramMap);
		if (userInfo == null) {
			mav.setViewName("carpe/login/login");
			model.addAttribute("errmsg", "ID 및 패스워드가 일치하지 않습니다.");
			return mav;
		}

		session.setAttribute("userInfo", userInfo);

		mav.setViewName("forward:/case.do");

		return mav;
	}
	
	@RequestMapping(value = "/logout.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView logout(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		session.removeAttribute("userInfo");
		mav.setViewName("forward:/login.do");
		
		return mav;
	}
}