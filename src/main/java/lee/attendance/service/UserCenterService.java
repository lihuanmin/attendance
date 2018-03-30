package lee.attendance.service;

import lee.attendance.domain.UserInfo;
import lee.attendance.domain.transfer.UserAccountInfo;

public interface UserCenterService {
	/**
	 * 根据id获取用户账户，基本信息.
	 * @param userId
	 * @return
	 */
	public abstract UserAccountInfo selectUserAccountById(int userId);
	/**
	 * 根据用户id，更新用户信息
	 * @param userId
	 * @return
	 */
	public abstract int updateUserById(UserInfo userInfo);
}
