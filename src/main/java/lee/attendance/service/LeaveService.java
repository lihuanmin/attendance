package lee.attendance.service;

import java.util.List;

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
}
