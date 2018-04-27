package lee.attendance.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import lee.attendance.domain.UserLeave;
import lee.attendance.domain.transfer.MemberLeave;

public interface UserLeaveMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(UserLeave record);

    int insertSelective(UserLeave record);

    UserLeave selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(UserLeave record);

    int updateByPrimaryKey(UserLeave record);
    /**
     * 根据时间，用户id，查询用户请假数量
     * @param userId
     * @param startTime
     * @param endTime
     * @return
     */
    int findLeaveCount(@Param("userId")int userId, @Param("startTime")Date startTime, @Param("endTime")Date endTime);
    
    /**
     * 查看请假
     * @param startTime
     * @param endTime
     * @param userId
     * @return
     */
    List<UserLeave> findAllLeave(@Param("startTime")Date startTime, @Param("endTime")Date endTime, @Param("userId")int userId);
    /**
     * 根据部门id，查询部门的请假
     * @param deptId
     * @param pageSize
     * @param pageNumber
     * @return
     */
    List<MemberLeave> findLeaveByDept(@Param("deptId")int deptId, @Param("pageSize")int pageSize, @Param("pageNumber")int pageNumber);
    
    /**
     * 根据部门id，查询部门请假数
     * @param deptId
     * @return
     */
    int findCountLeave(@Param("deptId")int deptId);
    /**
     * 审核员工请假
     * @param userId
     * @param deptId
     * @return
     */
    int checkLeave(@Param("id")int id, @Param("re")int re);
    /**
     * 删除请假
     * @param userId
     * @return
     */
    int delLeave(@Param("userId")int userId);
}