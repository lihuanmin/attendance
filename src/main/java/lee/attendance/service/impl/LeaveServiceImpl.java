package lee.attendance.service.impl;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.dao.LeaveMapper;
import lee.attendance.dao.UserDeptMapper;
import lee.attendance.domain.Leave;
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
			leaveMapper.insertSelective(leave);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return new ResultMsg(Boolean.TRUE, "请假成功");
	}
}
