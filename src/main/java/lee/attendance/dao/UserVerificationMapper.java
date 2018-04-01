package lee.attendance.dao;

import org.apache.ibatis.annotations.Param;

import lee.attendance.domain.UserVerification;

public interface UserVerificationMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserVerification record);

    int insertSelective(UserVerification record);

    UserVerification selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserVerification record);

    int updateByPrimaryKey(UserVerification record);
    /**
     * 根据用户账号查询用户
     * @param account
     * @return
     */
    UserVerification selectUserByAccount(@Param("account")String account);
    /**
     * 根据用户id获取用户密码,salt
     * @param userId
     * @return
     */
    UserVerification selectUserById(@Param("userId")int userId);
}