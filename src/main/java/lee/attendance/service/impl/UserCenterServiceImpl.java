package lee.attendance.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.dao.UserInfoMapper;
import lee.attendance.dao.UserVerificationMapper;
import lee.attendance.domain.UserInfo;
import lee.attendance.domain.UserVerification;
import lee.attendance.domain.transfer.UserAccountInfo;
import lee.attendance.domain.transfer.UserPassword;
import lee.attendance.service.UserCenterService;
import lee.attendance.utils.MD5;

@Service
public class UserCenterServiceImpl implements UserCenterService{
	@Autowired
	private UserInfoMapper userInfoMapper;
	@Autowired
	private UserVerificationMapper userVerificationMapper;
	@Override
	public UserAccountInfo selectUserAccountById(int userId) {
		return userInfoMapper.selectUserAccountById(userId);
	}
	@Override
	public int updateUserById(UserInfo userInfo) {
		return userInfoMapper.updateByPrimaryKeySelective(userInfo);
	}
	@Override
	public ResultMsg updatePassword(UserPassword userPassword) {
		/*
		 * 根据用户id获取用户账户
		 */
		UserVerification user = userVerificationMapper.selectUserById(userPassword.getUserId());
		/*
		 * 判断用户输入的旧密码是否正确
		 */
		if(!user.getPassword().equals(MD5.GetMD5Code(userPassword.getOld()+user.getSalt())))
			return new ResultMsg(Boolean.FALSE, "原密码不正确");
		/*
		 * 判断新旧密码是否一致
		 */
		if(userPassword.getOld().equals(userPassword.getNewPassword())) 
			return new ResultMsg(Boolean.FALSE, "新旧密码一致");
		if(!userPassword.getConfirm().equals(userPassword.getNewPassword()))
			return new ResultMsg(Boolean.FALSE, "新密码和确认密码不一致");
		/*
		 * 封装数据到UserVerification里面
		 */
		UserVerification userVerification = new UserVerification();
		userVerification.setSalt(userPassword.getSalt());
		userVerification.setId(userPassword.getUserId());
		userVerification.setPassword(MD5.GetMD5Code(userPassword.getNewPassword()+userPassword.getSalt()));
		/*
		 * 修改密码
		 */
		int result = userVerificationMapper.updateByPrimaryKeySelective(userVerification);
		if(result <= 0)
			return new ResultMsg(Boolean.FALSE, "更新密码失败");
		return new ResultMsg(Boolean.TRUE, "更新成功");
	}

}
