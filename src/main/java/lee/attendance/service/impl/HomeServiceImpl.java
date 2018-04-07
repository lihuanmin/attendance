package lee.attendance.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.dao.DepartmentMapper;
import lee.attendance.dao.MenuMapper;
import lee.attendance.dao.UserInfoMapper;
import lee.attendance.dao.UserVerificationMapper;
import lee.attendance.domain.Department;
import lee.attendance.domain.Menu;
import lee.attendance.domain.UserInfo;
import lee.attendance.domain.UserVerification;
import lee.attendance.domain.transfer.User;
import lee.attendance.service.HomeService;
import lee.attendance.utils.MD5;
import lee.attendance.utils.Salt;
@Service
public class HomeServiceImpl implements HomeService{
	@Autowired
	private UserInfoMapper userInfoMapper;
	@Autowired
	private MenuMapper menuMapper;
	@Autowired
	private DepartmentMapper departmentMapper;
	@Override
	public UserInfo selectUserById(int userId) {
		return userInfoMapper.selectById(userId);
	}
	@Override
	public List<Menu> selectMenuByUserId(int userId) {
		List<Menu> menuList = menuMapper.selectMenuByUserId(userId);
		return menuList;
	}
	
}
