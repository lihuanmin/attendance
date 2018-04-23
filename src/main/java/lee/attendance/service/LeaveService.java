package lee.attendance.service;

import lee.attendance.commons.ResultMsg;

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
}
