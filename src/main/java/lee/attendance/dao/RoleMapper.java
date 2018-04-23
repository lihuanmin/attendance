package lee.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import lee.attendance.domain.Role;
import lee.attendance.domain.transfer.RoleMenuInfo;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer role);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer role);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);
    /**
     * 查询所有的角色
     * @return
     */
    List<Role> queryRole();
    /**
     * 查询所有的角色包括菜单信息
     * @param roleId
     * @return
     */
    RoleMenuInfo findAllRoleMenu(@Param("roleId")int roleId);
}