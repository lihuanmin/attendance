package lee.attendance.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.dao.UserLeaveMapper;
import lee.attendance.dao.UserDeptMapper;
import lee.attendance.domain.UserLeave;
import lee.attendance.domain.transfer.MemberLeave;
import lee.attendance.service.LeaveService;

@Service
public class LeaveServiceImpl implements LeaveService{
	@Autowired
	private UserDeptMapper userDeptMapper;
	@Autowired
	private UserLeaveMapper leaveMapper;
	@Override
	public ResultMsg leave(int userId, String start, String end, String reason)  {
		//用户部门
		int deptId = userDeptMapper.findDeptIdByUserId(userId);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			UserLeave leave = new UserLeave();
			leave.setDeptId(deptId);
			leave.setStartTime(sdf.parse(start));
			leave.setEndTime(sdf.parse(end));
			leave.setReason(reason);
			leave.setUserId(userId);
			leave.setLeaveTime(new Date());
			leaveMapper.insertSelective(leave);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return new ResultMsg(Boolean.TRUE, "请假成功");
	}
	@Override
	public PageResponse<UserLeave> listLeave(int userId, int pageNumber, int pageSize, String startTime, String endTime) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		/*
		 * 当日期范围为空时，则其实日期为月初
		 */
		if((startTime == null||"".equals(startTime))&&(endTime == null || "".equals(endTime))) {
			startTime = getfirstDay();
			endTime = getLastDay();
		}else if(startTime == null||"".equals(startTime)) {
			startTime = getfirstDay();
		} else if(endTime == null || "".equals(endTime)){
			endTime = getLastDay();
		}
		/*
		 * 查询日期范围内的数量
		 */
		int leaveCount = 0;
		try {
			leaveCount = leaveMapper.findLeaveCount(userId, sdf.parse(startTime), sdf.parse(endTime));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<UserLeave> list = null;
		try {
			list = leaveMapper.findAllLeave(sdf.parse(startTime), sdf.parse(endTime), userId);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		PageResponse<UserLeave> pr = new PageResponse<UserLeave>();
		pr.setTotalRecord(leaveCount);
		pr.setDataList(list);
		return pr;
	}
	private String getfirstDay() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String now = sdf.format(date);
		now = now.substring(0, now.lastIndexOf("-"))+"-01";
		return now;
	}
	private String getLastDay() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String now = sdf.format(date);
		now = now.substring(0, now.lastIndexOf("-"))+"-31";
		return now;
	}
}
