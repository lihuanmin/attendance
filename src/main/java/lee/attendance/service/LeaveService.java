package lee.attendance.service;

import java.util.List;

import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.domain.Leave;
import lee.attendance.domain.transfer.MemberLeave;

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
	 * @return
	 */
	public abstract List<Leave> listLeave(int userId);
	/**
	 * 员工请假
	 * @param userId
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public abstract PageResponse<MemberLeave> memberLeave(int userId, int pageNumber, int pageSize);
	/**
	 * 审核请假
	 * @param userId
	 * @return
	 */
	public abstract ResultMsg check(int id, String re);
}
