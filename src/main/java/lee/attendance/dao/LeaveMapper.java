package lee.attendance.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import lee.attendance.domain.Leave;
import lee.attendance.domain.transfer.MemberLeave;

public interface LeaveMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Leave record);

    int insertSelective(Leave record);

    Leave selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Leave record);

    int updateByPrimaryKey(Leave record);
    /**
     * 查看请假
     * @param startTime
     * @param endTime
     * @param userId
     * @return
     */
    List<Leave> findAllLeave(@Param("startTime")Date startTime, @Param("endTime")Date endTime, @Param("userId")int userId);
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
    int checkLeave(@Param("id")int id, @Param("re")String re);
}