package lee.attendance.service.impl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.dao.UserVerificationMapper;
import lee.attendance.domain.UserVerification;
import lee.attendance.service.LoginService;
import lee.attendance.utils.MD5;
@Service
public class LoginServiceImpl implements LoginService{
	@Autowired
	private UserVerificationMapper userVerificationMapper;
	@Override
	public ResultMsg login(String account, String userPasswd, HttpServletRequest request) {
		// TODO Auto-generated method stub
		UserVerification userVerification = userVerificationMapper.selectUserByAccount(account);
		/*
		 * 用户不存在
		 */
		if(userVerification == null)
			return new ResultMsg(Boolean.FALSE, "用户名或密码错误");
		/*
		 * 用户已被锁定
		 */
		if(userVerification != null && userVerification.isLock())
			return new ResultMsg(Boolean.FALSE, "你已被锁定，请联系管理员");
		//将用户输入的密码和slat一起进行加密
		String loginPasswd = MD5.GetMD5Code(userPasswd + userVerification.getSalt());
		//判断数据库密码和用户输入的密码
		if(!loginPasswd.equals(userVerification.getPassword()))
			return new ResultMsg(Boolean.FALSE, "用户名或密码错误");
		/*
		 * 用户输入的信息正确
		 */
		HttpSession session = request.getSession();
		session.setAttribute("userId", userVerification.getId());
		session.setAttribute("userAccount", userVerification.getAccount());
		return new ResultMsg(Boolean.TRUE, "登录成功");
	}
	
}
