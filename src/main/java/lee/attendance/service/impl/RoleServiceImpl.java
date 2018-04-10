package lee.attendance.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.dao.MenuMapper;
import lee.attendance.domain.Menu;
import lee.attendance.service.RoleService;
@Service
public class RoleServiceImpl implements RoleService{
	@Autowired
	private MenuMapper menuMapper;
	@Override
	public List<Menu> queryMenu() {
		List<Menu> list = menuMapper.selectAllMenu();
		return list;
	}

}
