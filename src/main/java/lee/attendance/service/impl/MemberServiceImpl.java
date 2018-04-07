package lee.attendance.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.dao.DepartmentMapper;
import lee.attendance.dao.RoleMapper;
import lee.attendance.dao.UserDeptMapper;
import lee.attendance.dao.UserInfoMapper;
import lee.attendance.dao.UserRoleMapper;
import lee.attendance.dao.UserVerificationMapper;
import lee.attendance.domain.Department;
import lee.attendance.domain.Role;
import lee.attendance.domain.UserDept;
import lee.attendance.domain.UserInfo;
import lee.attendance.domain.UserRole;
import lee.attendance.domain.UserVerification;
import lee.attendance.domain.transfer.User;
import lee.attendance.service.MemberService;
import lee.attendance.utils.MD5;
import lee.attendance.utils.Salt;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private UserVerificationMapper userVerificationMapper;
	@Autowired
	private UserInfoMapper userInfoMapper;
	@Autowired
	private UserDeptMapper userDeptMapper;
	@Autowired
	private DepartmentMapper departmentMapper;
	@Autowired
	private RoleMapper roleMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	@Override
	public ResultMsg addMember(User user) {
		/*
		 *添加用户账户 
		 */
		int userCount = userVerificationMapper.queryUserAccount() + 1;
		UserVerification userVerification = new UserVerification();
		String salt = Salt.salt();
		userVerification.setSalt(salt);
		userVerification.setPassword(MD5.GetMD5Code("123456"+salt));
		userVerification.setAccount(user.getPrefixAccount()+"-"+user.getSuffixAccount()+userCount);
		int vRe = userVerificationMapper.insertSelective(userVerification);
		if(vRe == 0)
			return new ResultMsg(Boolean.FALSE, "添加失败");
		/*
		 * 添加用户信息
		 */
		UserInfo userInfo = new UserInfo();
		userInfo.setId(userVerification.getId());
		userInfo.setPortrait("/attendance/static/img/background_a.jpg");
		if(user.getSex()=="1")
			userInfo.setSex(true);
		else
			userInfo.setSex(false);
		userInfo.setRegisterTime(new Date());
		userInfo.setEmail("");
		userInfo.setPhone("");
		userInfo.setIntroduce("");
		userInfo.setRealName(user.getUserName());
		if(userInfoMapper.insertSelective(userInfo)==0)
			return new ResultMsg(Boolean.FALSE, "添加失败");
		/*
		 * 添加用户部门
		 */
		Department dept = departmentMapper.selectDeptById(new Integer(user.getDeptId()));
		if(dept != null) {
			UserDept userDept = new UserDept();
			userDept.setDeptId(dept.getDeptId());
			userDept.setUserId(userVerification.getId());
			userDeptMapper.insertSelective(userDept);
		} else
			return new ResultMsg(Boolean.FALSE, "部门不存在");
		/*
		 * 添加角色
		 */
		Role role = roleMapper.selectByPrimaryKey(new Integer(user.getRole()));
		if(role != null) {
			UserRole userRole = new UserRole();
			userRole.setUserId(userVerification.getId());
			userRole.setRoleId(role.getId());
			userRoleMapper.insertSelective(userRole);
		}else
			return new ResultMsg(Boolean.FALSE, "角色不存在");
		
		return new ResultMsg(Boolean.TRUE, "添加成功");
	}
	@Override
	public List<Role> queryRole() {
		return roleMapper.queryRole();
	}
}
