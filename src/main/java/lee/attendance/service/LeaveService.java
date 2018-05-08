package lee.attendance.service;

import java.util.Date;

import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.domain.UserLeave;

public interface LeaveService {
	/**
	 * 请假
	 * @param userId
	 * @param start
	 * @param end
	 * @param reason
	 * @return
	 */
	public abstract ResultMsg leave(int userId, String start, String end, String reason);
	/**
	 * 查看请假
	 * @param userId
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public abstract PageResponse<UserLeave> listLeave(int userId, int pageNumber, int pageSize, String startTime, String endTime);
	/**
	 * 根据id和时间范围查询用户请假上午
	 * @param startTime
	 * @param endTime
	 * @param userId
	 * @return
	 */
	public abstract UserLeave findLeave(String startTime, String endTime, int userId);
	/**
	 * 根据id和时间范围查询用户请假下午
	 * @param startTime
	 * @param endTime
	 * @param userId
	 * @return
	 */
	public abstract UserLeave findLeavePm(String startTime, String endTime, int userId);
}
