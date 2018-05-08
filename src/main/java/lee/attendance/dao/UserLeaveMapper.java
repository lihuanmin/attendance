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
    List<MemberLeave> findLeaveByDept(@Param("type")int type, @Param("deptId")int deptId, @Param("pageSize")int pageSize, @Param("pageNumber")int pageNumber);
    /**
     * 部门员工请假历史记录
     * @param type
     * @param deptId
     * @param pageSize
     * @param pageNumber
     * @return
     */
    List<MemberLeave> findLeaveByDeptHis(@Param("type")int type, @Param("deptId")int deptId, @Param("pageSize")int pageSize, @Param("pageNumber")int pageNumber);
    /**
     * 总部请假查询，针对经理类别
     * @param type
     * @param pageSize
     * @param pageNumber
     * @return
     */
    List<MemberLeave> findLeaveByZB(@Param("type")int type, @Param("pageSize")int pageSize, @Param("pageNumber")int pageNumber);
    /**
     * ZB部门经理请假历史记录
     * @param type
     * @param pageSize
     * @param pageNumber
     * @return
     */
    List<MemberLeave> findLeaveHisByZB(@Param("type")int type, @Param("pageSize")int pageSize, @Param("pageNumber")int pageNumber);
    /**
     * 根据部门id，查询部门请假数
     * @param deptId
     * @return
     */
    int findCountLeave(@Param("deptId")int deptId,@Param("type")int type);
    /**
     * 查询请假数量，总部
     * @param type
     * @return
     */
    int findCountLeaveZB(@Param("type")int type);
    /**
     * 查询员工请假历史数
     * @param type
     * @return
     */
    int findCountLeaveHis(@Param("deptId")int deptId,@Param("type")int type);
    /**
     * 查看经理请假历史记录
     * @param type
     * @return
     */
    int findCountLeaveHisZB(@Param("type")int type);
    /**
     * 审核员工请假
     * @param userId
     * @param deptId
     * @return
     */
    int checkLeave(@Param("id")int id, @Param("examResult")int examResult);
    /**
     * 删除请假
     * @param userId
     * @return
     */
    int delLeave(@Param("userId")int userId);
    /**
     * 根据id和开始时间和结束时间插叙请假
     * @param startTime
     * @param endTime
     * @param userId
     * @return
     */
    UserLeave findLeaveByTimeAndId(@Param("startTime")String startTime, @Param("endTime")String endTime, @Param("userId")int userId);
    /**
     * 根据id和开始时间和结束时间插叙请假下午
     * @param startTime
     * @param endTime
     * @param userId
     * @return
     */
    UserLeave findLeaveByTimeAndIdPm(@Param("startTime")String startTime, @Param("endTime")String endTime, @Param("userId")int userId);
}