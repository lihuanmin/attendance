package lee.attendance.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import lee.attendance.domain.Attendance;

public interface AttendanceMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Attendance record);

    int insertSelective(Attendance record);

    Attendance selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Attendance record);

    int updateByPrimaryKey(Attendance record);
    /**
     * 插入每天所有员工的考勤
     * @param list
     * @return
     */
    int insertAllUserAtten(@Param("list")List list);
    /**
     * 根据用户id查询考勤
     * @param userId
     * @param reference
     * @return
     */
    Attendance selectByUserId(@Param("userId")int userId, @Param("reference")String reference);
    /**
     * 根据用户id查看考勤
     * @param startTime
     * @param endTime
     * @param userId
     * @return
     */
    List<Attendance> findAllAtten(
    		@Param("startTime")Date startTime, 
    		@Param("endTime")Date endTime, 
    		@Param("userId")int userId,
    		@Param("pageNumber")int pageNumber,
    		@Param("pageNumber")int pageSize);
    /**
     * 查询日期范围内的数量
     * @param startTime
     * @param endTime
     * @return
     */
    int findAttenCount(@Param("startTime")Date startTime, @Param("endTime")Date endTime, @Param("userId")int userId);
    /**
     * 删除考勤
     * @param userId
     * @return
     */
    int delAttendance(@Param("userId")int userId);
    /**
     * 查询上午旷工记录
     * @param date
     * @return
     */
    List<Attendance> findDayAtten(@Param("date")Date date);
    /**
     * 查询下午旷工记录
     * @param date
     * @return
     */
    List<Attendance> findDayAttendByDayPm(@Param("date")Date date);
    
    /**
     * 更新上午旷工的状态
     * @param id
     * @return
     */
    int updateAmStatus(@Param("id")int id);
    
    int updatePmStatus(@Param("id")int id);
}