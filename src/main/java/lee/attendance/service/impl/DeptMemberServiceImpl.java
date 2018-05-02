package lee.attendance.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.dao.UserDeptMapper;
import lee.attendance.dao.UserLeaveMapper;
import lee.attendance.dao.UserRoleMapper;
import lee.attendance.domain.UserRole;
import lee.attendance.domain.transfer.MemberLeave;
import lee.attendance.service.DeptMemberService;
@Service
public class DeptMemberServiceImpl implements DeptMemberService{
	@Autowired
	private UserDeptMapper userDeptMapper;
	@Autowired
	private UserLeaveMapper leaveMapper;
	@Autowired
	private UserRoleMapper userRoleMapper;
	@Override
	public PageResponse<MemberLeave> memberLeave(int userId, int pageNumber, int pageSize) {
		//部门id
		int deptId = userDeptMapper.findDeptIdByUserId(userId);
		//查询用户角色，根据角色判断用户请假类型
		UserRole userRole = userRoleMapper.selectByUId(userId);
		int type = 0;
		int size = 0;
		if(userRole.getRoleId()==2){
			type = 0;
		} else if(userRole.getRoleId()==3){
			type = 1;
		} 
		List<MemberLeave> memLeaveList = new ArrayList<MemberLeave>();
		//部门员工请假
		if(type==0){
			memLeaveList = leaveMapper.findLeaveByDept(type, deptId, pageSize, pageNumber);
			size = leaveMapper.findCountLeave(deptId, type);
		//经理请假
		}else if(type==1){
			memLeaveList = leaveMapper.findLeaveByZB(type, pageSize, pageNumber);
			size = leaveMapper.findCountLeaveZB(type);
		}
		PageResponse<MemberLeave> pr = new PageResponse<MemberLeave>();
		pr.setTotalRecord(size);
		pr.setDataList(memLeaveList);
		return pr;
	}
	@Override
	public ResultMsg check(int id, int examResult) {
		int r = leaveMapper.checkLeave(id, examResult);
		if(r<=0)
			return new ResultMsg(Boolean.FALSE, "审核失败");
		return new ResultMsg(Boolean.TRUE, "审核成功");
	}
	@Override
	public PageResponse<MemberLeave> hisLeave(int userId, int pageNumber, int pageSize) {
		//部门id
		int deptId = userDeptMapper.findDeptIdByUserId(userId);
		//查询用户角色，根据角色判断用户请假类型
		UserRole userRole = userRoleMapper.selectByUId(userId);
		int type = 0;
		int size = 0;
		if(userRole.getRoleId()==2){
			type = 0;
		} else if(userRole.getRoleId()==3){
			type = 1;
		} 
		List<MemberLeave> memLeaveList = new ArrayList<MemberLeave>();
		//部门员工请假
		if(type==0){
			memLeaveList = leaveMapper.findLeaveByDeptHis(type, deptId, pageSize, pageNumber);
			size = leaveMapper.findCountLeaveHis(deptId, type);
		//经理请假
		}else if(type==1){
			memLeaveList = leaveMapper.findLeaveHisByZB(type, pageSize, pageNumber);
			size = leaveMapper.findCountLeaveHisZB(type);
		}
		PageResponse<MemberLeave> pr = new PageResponse<MemberLeave>();
		pr.setTotalRecord(size);
		pr.setDataList(memLeaveList);
		return pr;
	}
}
