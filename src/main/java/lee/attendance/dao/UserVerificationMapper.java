package lee.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import lee.attendance.domain.UserVerification;
import lee.attendance.domain.transfer.AllUser;

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
    /**
     * 员工数量
     * @return
     */
    Integer queryUserAccount();
    /**
     * 查询所有员工的id
     * @return
     */
    List<Integer> selectAllUserId();
   /**
    * 查询所有员工包括部门信息和角色信息
    * @param realName
    * @param dept
    * @param pageSize
    * @param pageNumber
    * @return
    */
    List<AllUser> queryAllUserDeptRole(@Param("realName")String realName, @Param("dept")String dept, @Param("pageSize")int pageSize, @Param("pageNumber")int pageNumber);
}