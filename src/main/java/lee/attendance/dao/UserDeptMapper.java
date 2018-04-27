package lee.attendance.dao;

import org.apache.ibatis.annotations.Param;

import lee.attendance.domain.UserDept;

public interface UserDeptMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserDept record);

    int insertSelective(UserDept record);

    UserDept selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserDept record);

    int updateByPrimaryKey(UserDept record);
    /**
     * 根据用户id查询部门id
     * @param userId
     * @return
     */
    int findDeptIdByUserId(@Param("userId")int userId);
    /**
     * 删除用户部门
     * @param userId
     * @return
     */
    int delUserDept(@Param("userId")int userId);
}