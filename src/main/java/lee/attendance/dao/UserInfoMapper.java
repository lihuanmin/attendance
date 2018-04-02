package lee.attendance.dao;

import org.apache.ibatis.annotations.Param;

import lee.attendance.domain.UserInfo;
import lee.attendance.domain.transfer.UserAccountInfo;

public interface UserInfoMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserInfo record);

    int insertSelective(UserInfo record);

    UserInfo selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserInfo record);

    int updateByPrimaryKey(UserInfo record);
    /**
     * 根据用户id查询用户头像，姓名
     * @param userId
     * @return
     */
    UserInfo selectById(@Param("userId")int userId);
    /**
     * 根据用户id查询用户账号，基本信息
     * @param userId
     * @return
     */
    UserAccountInfo selectUserAccountById(@Param("userId")int userId);
    /**
     * 根据真实姓名查询用户是否存在
     * @param name
     * @return
     */
    UserInfo selectByRealName(@Param("name")String name);
}