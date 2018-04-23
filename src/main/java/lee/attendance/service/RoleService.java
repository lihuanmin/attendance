package lee.attendance.service;

import java.util.List;

import lee.attendance.commons.ResultMsg;
import lee.attendance.domain.Menu;
import lee.attendance.domain.Role;
import lee.attendance.domain.transfer.RoleMenuInfo;
import lee.attendance.domain.transfer.RoleMenuUpdate;

public interface RoleService {
	/**
	 * 查询所有菜单
	 * @return
	 */
	public abstract List<Menu> queryMenu();
	/**
	 * 添加角色
	 * @param roleName
	 * @param roleDetail
	 * @param menu
	 * @return
	 */
	public abstract ResultMsg addRole(String roleName, String roleDetail, int[] menu);
	/**
	 * 查询所有的角色
	 * @return
	 */
	public abstract List<Role> selectAllRole();
	/**
	 * 根据id查询角色，包括菜单信息
	 * @param roleId
	 * @return
	 */
	public abstract RoleMenuInfo findRoleAllMenu(int roleId);
	/**
	 * 根据角色id查询菜单
	 * @param roleId
	 * @return
	 */
	public abstract List<Menu> findMenuByRoleId(int roleId);
	/**
	 * 修改角色
	 * @param roleMenuUpdate
	 * @return
	 */
	public abstract ResultMsg updateRole(RoleMenuUpdate roleMenuUpdate);
}
