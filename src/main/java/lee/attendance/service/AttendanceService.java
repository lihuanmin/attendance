package lee.attendance.service;

import java.util.List;

import lee.attendance.commons.ResultMsg;
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
	 * @param year
	 * @param month
	 * @param day
	 * @return
	 */
	public abstract List<Attendance> queryAtten(String year, String month, String day);
}
