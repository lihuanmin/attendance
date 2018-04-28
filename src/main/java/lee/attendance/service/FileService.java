package lee.attendance.service;

import java.util.List;

import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.domain.DeptFile;
import lee.attendance.domain.transfer.AllUser;
import lee.attendance.domain.transfer.DeptInfo;
import lee.attendance.domain.transfer.UserFile;

public interface FileService {
	/**
	 * 根据用户id，查询部门id
	 * @param userId
	 * @return
	 */
	public abstract int findDeptIdByUserId(int userId);
	/**
	 * 添加文件
	 * @param deptFile
	 * @return
	 */
	public abstract ResultMsg addFile(DeptFile deptFile);
	/**
	 * 所有文件
	 * @return
	 */
	public abstract List<UserFile> listFile(int deptId);
	/**
	 * 查询部门信息包括人数
	 * @param userId
	 * @return
	 */
	public abstract DeptInfo deptInfo(int userId);
	/**
	 * 查询所有的员工
	 * @param userId
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	public abstract PageResponse<AllUser> deptAllMem(int userId, String userName, int pageNumber, int pageSize);
}
