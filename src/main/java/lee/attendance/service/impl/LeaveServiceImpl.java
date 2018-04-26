package lee.attendance.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.dao.LeaveMapper;
import lee.attendance.dao.UserDeptMapper;
import lee.attendance.domain.Leave;
import lee.attendance.domain.transfer.MemberLeave;
import lee.attendance.service.LeaveService;

@Service
public class LeaveServiceImpl implements LeaveService{
	@Autowired
	private UserDeptMapper userDeptMapper;
	@Autowired
	private LeaveMapper leaveMapper;
	@Override
	public ResultMsg leave(int userId, String start, String end, String reason)  {
		//用户部门
		int deptId = userDeptMapper.findDeptIdByUserId(userId);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			Leave leave = new Leave();
			leave.setDeptId(deptId);
			leave.setStartTime(sdf.parse(start));
			leave.setEndTime(sdf.parse(end));
			leave.setReason(reason);
			leave.setUserId(userId);
			leave.setLeaveTime(new Date());
			leave.setExamResult("未审核");
			leaveMapper.insertSelective(leave);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return new ResultMsg(Boolean.TRUE, "请假成功");
	}
	@Override
	public List<Leave> listLeave(int userId) {
		return leaveMapper.findAllLeave(getfirstDay(), getLastDay(), userId);
	}
	private Date getfirstDay() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String now = sdf.format(date);
		now = now.substring(0, now.lastIndexOf("-"));
		try {
			Date d = sdf.parse(now+"-01");
			return d;
		} catch (ParseException e) {
			return null;
		}
		
	}
	private Date getLastDay() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String now = sdf.format(date);
		now = now.substring(0, now.lastIndexOf("-"));
		try {
			Date d = sdf.parse(now+"-31");
			return d;
		} catch (ParseException e) {
			return null;
		}
	}
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
	public ResultMsg check(int id, String re) {
		int r = leaveMapper.checkLeave(id, re);
		if(r<=0)
			return new ResultMsg(Boolean.FALSE, "审核失败");
		return new ResultMsg(Boolean.TRUE, "审核成功");
	}
}
