package lee.attendance.service;

import java.util.List;

import lee.attendance.commons.ResultMsg;
import lee.attendance.domain.DeptFile;
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
	public abstract List<UserFile> listFile();
}
