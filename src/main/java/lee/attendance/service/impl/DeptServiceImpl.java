package lee.attendance.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.dao.DepartmentMapper;
import lee.attendance.dao.UserDeptMapper;
import lee.attendance.dao.UserInfoMapper;
import lee.attendance.dao.UserRoleMapper;
import lee.attendance.domain.Department;
import lee.attendance.domain.UserDept;
import lee.attendance.domain.UserInfo;
import lee.attendance.domain.UserRole;
import lee.attendance.service.DeptService;
@Service
public class DeptServiceImpl implements DeptService{
	@Autowired
	private DepartmentMapper departmentMapper;
	@Autowired
	private UserInfoMapper userInfoMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	@Autowired
	private UserDeptMapper userDetMapper;
	@Override
	public String getIdByName(String deptName) {
		return departmentMapper.getNameByName(deptName);
	}

	@Override
	public ResultMsg addDept(Department department) {
		/*
		 * 查询名字是否重复
		 */
		String reNameN = departmentMapper.getNameByName(department.getDeptName());
		if(null!=reNameN&&!"".equals(reNameN)) {
			return new ResultMsg(Boolean.FALSE, "部门名字已重复，请重新输入");
		}
		/*
		 * 查询编号是否重复
		 */
		String reNameC = departmentMapper.getNameByCode(department.getDeptCode());
		if(null!=reNameC&&!"".equals(reNameC))
			return new ResultMsg(Boolean.FALSE, "编号已经重复，请在原有基础上添加后缀或前缀");
		/*
		 * 添加部门
		 */
		int result = departmentMapper.insertSelective(department);
		if(result <=0 )
			return new ResultMsg(Boolean.FALSE, "添加失败");
		return new ResultMsg(Boolean.TRUE, "添加成功");
	}

	@Override
	public List<Department> selectAllDept() {
		return departmentMapper.selectAllDept();
	}

	@Override
	public Department queryDeptById(int deptId) {
		return departmentMapper.selectDeptById(deptId);
	}

	@Override
	public ResultMsg updateDept(Department department) {
		/*
		 * 查询名字是否重复
		 */
		String reNameN = departmentMapper.getNameByNameNoId(department.getDeptName(), department.getDeptId());
		if(null!=reNameN&&!"".equals(reNameN)) {
			return new ResultMsg(Boolean.FALSE, "部门名字已重复，请重新输入");
		}
		/*
		 * 查询编号是否重复
		 */
		String reNameC = departmentMapper.getNameByCodeNoId(department.getDeptCode(), department.getDeptId());
		if(null!=reNameC&&!"".equals(reNameC))
			return new ResultMsg(Boolean.FALSE, "编号已经重复，请在原有基础上添加后缀或前缀");
		
		
		
		
		if(department.getHead()!="暂无"){
			UserInfo use = userInfoMapper.findUserBlDe(department.getHead(), department.getDeptId());
			if(use==null)
				return new ResultMsg(Boolean.FALSE, "该员工不属于该部门");
			UserInfo userInfo = userInfoMapper.selectByRealName(department.getHead());
			/*
			 * 查询用户是否存在
			 */
			if(userInfo==null)
				return new ResultMsg(Boolean.FALSE,"该员工不存在");
			/*
			 * 修改用户角色
			 */
			UserRole userRole = new UserRole();
			userRole.setUserId(userInfo.getId());
			userRole.setRoleId(2);
			int r = userRoleMapper.updateByUserId(userRole);
			if(r <= 0)
				return new ResultMsg(Boolean.FALSE, "修改角色失败");
		}
		/*
		 * 修改部门
		 */
		int result = departmentMapper.updateByPrimaryKeySelective(department);
		if(result <= 0)
			return new ResultMsg(Boolean.FALSE, "修改失败");
		
		/*
		 * 将用户假如部门
		 */
		/*UserDept userDept = new UserDept();
		userDept.setDeptId(department.getDeptId());
		userDept.setUserId(userInfo.getId());
		int ud = userDetMapper.insertSelective(userDept);
		if(ud <= 0)
			return new ResultMsg(Boolean.FALSE, "用户假如部门失败");*/
		return new ResultMsg(Boolean.TRUE, "修改成功");
	}

	@Override
	public List<Department> queryDept() {
		return departmentMapper.queryDept();
	}

	@Override
	public List<String> search(int deptId) {
		return departmentMapper.search(deptId);
	}


	
}
