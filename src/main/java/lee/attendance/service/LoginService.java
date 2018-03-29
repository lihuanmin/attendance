package lee.attendance.service;

import javax.servlet.http.HttpServletRequest;

import lee.attendance.commons.ResultMsg;

public interface LoginService {
	/**
	 * 用户登录
	 * @param account
	 * @param userPasswd
	 * @return
	 */
	public abstract ResultMsg login(String account, String userPasswd, HttpServletRequest request);
}
