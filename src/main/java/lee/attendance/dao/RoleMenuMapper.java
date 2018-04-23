package lee.attendance.dao;

import org.apache.ibatis.annotations.Param;

import lee.attendance.domain.RoleMenu;

public interface RoleMenuMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(RoleMenu record);

    int insertSelective(RoleMenu record);

    RoleMenu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RoleMenu record);

    int updateByPrimaryKey(RoleMenu record);
	  /**
	   * 添加角色菜单
	   * @param roleId
	   * @param menu
	   * @return
	   */
    int insertRoleMenu(@Param("roleId")int roleId, @Param("menu")int[] menu);
    /**
     * 删除角色菜单
     * @param roleId
     * @return
     */
    int deleteMenuById(@Param("roleId")int roleId);
}