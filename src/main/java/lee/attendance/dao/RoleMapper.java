package lee.attendance.dao;

import lee.attendance.domain.Role;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer role);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer role);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);
}