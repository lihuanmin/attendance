package lee.attendance.service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.domain.transfer.MemberLeave;

public interface DeptMemberService {
	/**
	 * 员工请假
	 * @param userId
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public abstract PageResponse<MemberLeave> memberLeave(int userId, int pageNumber, int pageSize);
	/**
	 * 员工请假历史记录
	 * @param userId
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public abstract PageResponse<MemberLeave> hisLeave(int userId, int pageNumber, int pageSize);
	/**
	 * 审核请假
	 * @param userId
	 * @return
	 */
	public abstract ResultMsg check(int id, int examResult);
}
