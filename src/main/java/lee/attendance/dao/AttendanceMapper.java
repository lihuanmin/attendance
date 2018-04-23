package lee.attendance.dao;

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
}