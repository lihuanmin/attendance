package lee.attendance.service;

import java.util.List;


import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.domain.Role;
import lee.attendance.domain.transfer.AllUser;
import lee.attendance.domain.transfer.User;

public interface MemberService {
	/**
	 * 添加员工
	 * @param user
	 * @return
	 */
	public abstract ResultMsg addMember(User user);
	/**
	 * 查询所有的角色
	 * @return
	 */
	public abstract List<Role> queryRole();
	/**
	 * 查询员工个数
	 * @return
	 */
	public abstract int queryCount();
	/**
	 * 分页员工列表
	 * @param dept
	 * @param realName
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public abstract PageResponse<AllUser> findAllUser(String dept, String realName, int pageNumber, int pageSize); 
	
}
