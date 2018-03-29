package lee.attendance.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lee.attendance.commons.ResultMsg;
import lee.attendance.service.LoginService;


@Controller
@RequestMapping("login")
public class LoginController {
	@Autowired
	private LoginService loginService;
	/**
	 * 用户登录
	 * @param req
	 * @param model
	 * @param account
	 * @param userPasswd
	 */
	@RequestMapping("userLogin")
	@ResponseBody
	public ResultMsg userLogin(
			HttpServletRequest req, 
			Model model, 
			@RequestParam("account")String account, 
			@RequestParam("userPasswd")String userPasswd) {
		 if(account==null || "".equals(account)||userPasswd==null||"".equals(userPasswd)) 
	            return new ResultMsg(Boolean.FALSE, "用户名或密码不能为空");
	     ResultMsg msg = loginService.login(account, userPasswd, req);   
		 return msg;
	}
}
