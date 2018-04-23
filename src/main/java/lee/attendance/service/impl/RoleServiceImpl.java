package lee.attendance.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.dao.MenuMapper;
import lee.attendance.dao.RoleMapper;
import lee.attendance.dao.RoleMenuMapper;
import lee.attendance.domain.Menu;
import lee.attendance.domain.Role;
import lee.attendance.domain.transfer.RoleMenuInfo;
import lee.attendance.domain.transfer.RoleMenuUpdate;
import lee.attendance.service.RoleService;
@Service
public class RoleServiceImpl implements RoleService{
	@Autowired
	private MenuMapper menuMapper;
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private RoleMenuMapper roleMenuMapper;
	@Override
	public List<Menu> queryMenu() {
		List<Menu> list = menuMapper.selectAllMenu();
		return list;
	}
	@Override
	public ResultMsg addRole(String roleName, String roleDetail, int[] menu) {
		Role role = new Role();
		role.setRoleDetail(roleDetail);
		role.setRoleName(roleName);
		roleMapper.insertSelective(role);
		roleMenuMapper.insertRoleMenu(role.getId(), menu);
		return new ResultMsg(Boolean.TRUE, "添加成功");
	}
	@Override
	public List<Role> selectAllRole() {
		return roleMapper.queryRole();
	}
	@Override
	public RoleMenuInfo findRoleAllMenu(int roleId) {
		return roleMapper.findAllRoleMenu(roleId);
	}
	@Override
	public List<Menu> findMenuByRoleId(int roleId) {
		return menuMapper.selectMenuByRole(roleId);
	}
	@Override
	public ResultMsg updateRole(RoleMenuUpdate roleMenuUpdate) {
		Role role = new Role();
		role.setId(roleMenuUpdate.getRoleId());
		role.setRoleName(roleMenuUpdate.getRoleName());
		role.setRoleDetail(roleMenuUpdate.getRoleDetail());
		int r1 = roleMapper.updateByPrimaryKey(role);
		/*
		 * 删除角色菜单
		 */
		int r2 = roleMenuMapper.deleteMenuById(roleMenuUpdate.getRoleId());
		/*
		 * 插入角色菜单
		 */
		int r3 = roleMenuMapper.insertRoleMenu(roleMenuUpdate.getRoleId(), roleMenuUpdate.getMenu());
		return new ResultMsg(Boolean.TRUE, "修改成功");
	}

}
