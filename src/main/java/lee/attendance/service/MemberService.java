package lee.attendance.service;

import java.util.List;

import lee.attendance.commons.ResultMsg;
import lee.attendance.domain.Role;
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
	
	
	
}
