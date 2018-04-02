package lee.attendance.service;

import java.util.List;

import lee.attendance.commons.ResultMsg;
import lee.attendance.domain.Department;

public interface DeptService {
	/**
	 * 根据名字获取id，判断该名字是否存在
	 * @param deptName
	 * @return
	 */
	public abstract String getIdByName(String deptName);
	/**
	 * 添加部门
	 * @param department
	 * @return
	 */
	public abstract ResultMsg addDept(Department department);
	/**
	 * 查询所有的部门
	 * @return
	 */
	public abstract List<Department> selectAllDept();
	/**
	 * 根据id查询部门
	 * @param deptId
	 * @return
	 */
	public abstract Department queryDeptById(int deptId);
	/**
	 * 修改部门信息根据id
	 * @param department
	 * @return
	 */
	public abstract ResultMsg updateDept(Department department);
}
