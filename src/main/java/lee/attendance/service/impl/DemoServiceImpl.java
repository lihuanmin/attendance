package lee.attendance.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.dao.UserMapper;
import lee.attendance.domain.User;
import lee.attendance.service.DemoService;
@Service
public class DemoServiceImpl implements DemoService{
	@Autowired
	private UserMapper userMapper;
	@Override
	public List<User> findAllUser() {
		// TODO Auto-generated method stub
		return userMapper.selectAll();
	}

}
