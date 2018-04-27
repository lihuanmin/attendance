package lee.attendance.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.dao.UserLeaveMapper;
import lee.attendance.dao.UserDeptMapper;
import lee.attendance.domain.transfer.MemberLeave;
import lee.attendance.service.DeptMemberService;
@Service
public class DeptMemberServiceImpl implements DeptMemberService{
	@Autowired
	private UserDeptMapper userDeptMapper;
	@Autowired
	private UserLeaveMapper leaveMapper;
	@Override
	public PageResponse<MemberLeave> memberLeave(int userId, int pageNumber, int pageSize) {
		int deptId = userDeptMapper.findDeptIdByUserId(userId);
		List<MemberLeave> memLeaveList = leaveMapper.findLeaveByDept(deptId, pageSize, pageNumber);
		int size = leaveMapper.findCountLeave(deptId);
		PageResponse<MemberLeave> pr = new PageResponse<MemberLeave>();
		pr.setTotalRecord(size);
		pr.setDataList(memLeaveList);
		return pr;
	}
	@Override
	public ResultMsg check(int id, int re) {
		int r = leaveMapper.checkLeave(id, re);
		if(r<=0)
			return new ResultMsg(Boolean.FALSE, "审核失败");
		return new ResultMsg(Boolean.TRUE, "审核成功");
	}
}
