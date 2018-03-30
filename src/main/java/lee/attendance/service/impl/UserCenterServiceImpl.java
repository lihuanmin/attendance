package lee.attendance.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.dao.UserInfoMapper;
import lee.attendance.domain.UserInfo;
import lee.attendance.domain.transfer.UserAccountInfo;
import lee.attendance.service.UserCenterService;

@Service
public class UserCenterServiceImpl implements UserCenterService{
	@Autowired
	private UserInfoMapper userInfoMapper;
	@Override
	public UserAccountInfo selectUserAccountById(int userId) {
		return userInfoMapper.selectUserAccountById(userId);
	}
	@Override
	public int updateUserById(UserInfo userInfo) {
		return userInfoMapper.updateByPrimaryKeySelective(userInfo);
	}

}
