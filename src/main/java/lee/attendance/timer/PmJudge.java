package lee.attendance.timer;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import lee.attendance.domain.Attendance;
import lee.attendance.domain.UserLeave;
import lee.attendance.service.AttendanceService;
import lee.attendance.service.LeaveService;

public class PmJudge {
	@Autowired
	private AttendanceService attendanceService;
	@Autowired
	private LeaveService leaveService;
	public void execute() {
		List<Attendance> list = new ArrayList<Attendance>();
		list = attendanceService.findDayAttendByDayPm(getYtd());
		if(list.size()>0) {
			for(int i = 0; i < list.size(); i++) {
				System.out.println(getDayStartTime());
				System.out.println(getDayEndTime());
				UserLeave userLeave = leaveService.findLeavePm(getDayStartTime(), getDayEndTime(), list.get(i).getUserId());
				if(userLeave != null) {
					attendanceService.updatePmStatus(list.get(i).getId());
				}else {
				}
			}
		}
	}
	/*
	 * 获取开始时间
	 */
	private String getDayStartTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int day = calendar.get(Calendar.DAY_OF_MONTH);
		String start = year + "-0" + month + "-0" + day + " 14:00:00";
		return start;
	}
	/*
	 * 获取结束时间
	 */
	private String getDayEndTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int day = calendar.get(Calendar.DAY_OF_MONTH);
		String end = year + "-0" + month + "-0" + day + " 18:00:00";
		return end;
	}
	/*
	 * 获取日期
	 */
	private Date getYtd() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar calendar = Calendar.getInstance();
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int day = calendar.get(Calendar.DAY_OF_MONTH);
		try {
			Date date = sdf.parse(year+"-0"+month+"-0"+day);
			return date;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
}
