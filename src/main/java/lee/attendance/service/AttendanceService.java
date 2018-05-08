package lee.attendance.service;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.domain.Attendance;

public interface AttendanceService {
	/**
	 * 插入所有员工的考勤数据
	 * @param list
	 */
	public abstract void insertAll(List list);
	/**
	 * 考勤
	 * @param userId
	 * @return
	 */
	public abstract ResultMsg atten(int userId);
	/**
	 * 查询当月的考勤
	 * @param userId
	 * @return
	 */
	public abstract PageResponse<Attendance> queryAtten(String startTime, String endTime, int userId, int pageNumber, int pageSize);
	/**
	 * 查询上午旷工的员工
	 * @param date
	 * @return
	 */
	public abstract List<Attendance> findDayAttendByDay(@Param("date")Date date);
	/**
	 * 查询下午旷工的人
	 * @param date
	 * @return
	 */
	public abstract List<Attendance> findDayAttendByDayPm(@Param("date")Date date);
	/**
	 * 根据id更新上午旷工的人
	 * @param id
	 */
	public abstract void updateAmtatus(int id);
	/**
	 * 根据id更新下午旷工的人
	 * @param id
	 */
	public abstract void updatePmStatus(int id);
}
