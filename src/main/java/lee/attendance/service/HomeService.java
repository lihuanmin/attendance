package lee.attendance.service;

import java.util.List;

import lee.attendance.commons.ResultMsg;
import lee.attendance.domain.Department;
import lee.attendance.domain.Menu;
import lee.attendance.domain.UserInfo;
import lee.attendance.domain.transfer.User;

public interface HomeService {
	/**
	 * 根据用户id查询用户名称，头像
	 * @param userId
	 * @return
	 */
	public abstract  UserInfo selectUserById(int userId);
	/**
	 * 根据用户id，查询用户菜单
	 * @param userId
	 * @return
	 */
	public abstract List<Menu> selectMenuByUserId(int userId);
	
	
}
