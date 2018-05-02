package lee.attendance.dao;

import org.apache.ibatis.annotations.Param;

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
    /**
     * 根据用户id根据用户角色
     * @param userId
     * @return
     */
    int updateRoleByUserId(@Param("userId")int userId);
    /**
     * 删除用户角色
     * @param userId
     * @return
     */
    int delUserRole(@Param("userId")int userId);
    /**
     * 根据用户id,查询用户角色
     * @param userId
     * @return
     */
    UserRole selectByUId(@Param("userId")int userId);
    
}