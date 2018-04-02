package lee.attendance.dao;

import lee.attendance.domain.UserRole;

public interface UserRoleMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserRole record);

    int insertSelective(UserRole record);

    UserRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserRole record);

    int updateByPrimaryKey(UserRole record);
    /**
     * 根据用户id更新用户角色
     * @param userId
     * @return
     */
    int updateByUserId(UserRole userRole);
}