package lee.attendance.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.dao.MenuMapper;
import lee.attendance.dao.UserInfoMapper;
import lee.attendance.domain.Menu;
import lee.attendance.domain.UserInfo;
import lee.attendance.service.HomeService;
@Service
public class HomeServiceImpl implements HomeService{
	@Autowired
	private UserInfoMapper userInfoMapper;
	@Autowired
	private MenuMapper menuMapper;
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
