package lee.attendance.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.dao.AttendanceMapper;
import lee.attendance.dao.DepartmentMapper;
import lee.attendance.dao.UserDeptMapper;
import lee.attendance.domain.Attendance;
import lee.attendance.service.AttendanceService;
@Service
public class AttendanceServiceImpl implements AttendanceService{
	@Resource
	private AttendanceMapper attendanceMapper;
	@Override
	public void insertAll(List list) {
		attendanceMapper.insertAllUserAtten(list);
	}

	@Override
	public ResultMsg atten(int userId) {
		/*
		 * 查询出当天考勤数据
		 */
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Attendance a = attendanceMapper.selectByUserId(userId, sdf.format(date));
		/*
		 *当前时间
		 */
		Date d = new Date();
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = s.format(d);
		ResultMsg msg = new ResultMsg();
		//上午
		if(now.compareTo(noon()) <= 0) {
			if(a.getWorkTime()==null) {
				a.setWorkTime(new Date());
				//上午签到
				if(now.compareTo(am()) <= 0) {
					a.setAmStatus(2);
				}else {
				//上午迟到
					a.setAmStatus(1);
				}
			}else {
				return new ResultMsg(Boolean.FALSE, "上午已签到");
			}
		}else{//下午
			if(a.getEndTime() == null) {
				a.setEndTime(new Date());
				//下午早退
				if(now.compareTo(pm())<0) {
					a.setPmStatus(1);
				}else {
					a.setPmStatus(2);
				}
			}else {
				return new ResultMsg(Boolean.FALSE, "下午已签到");
			}
		}
		attendanceMapper.updateByPrimaryKey(a);
		return new ResultMsg(Boolean.TRUE, "签到成功");
	}
	
	public String am() {
		Calendar calendar = Calendar.getInstance();  
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int day = calendar.get(Calendar.DATE);
		System.out.println(year+"-"+month+"-"+day);
		String am = year  + "-" + month + "-" + day + " " + "9:00:00";
		return am;
	}
	public String noon() {
		Calendar calendar = Calendar.getInstance();  
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int day = calendar.get(Calendar.DATE);
		String noon = year + "-" + month + "-" + day + " " + "12:00:00";
		return noon;
	}
	public String pm() {
		Calendar calendar = Calendar.getInstance();  
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int day = calendar.get(Calendar.DATE);
		String pm = year + "-" + month + "-" + day + " " + "18:00:00";
		return pm;
	}
    private int getYear() {
    	Calendar calendar = Calendar.getInstance();  
		int year = calendar.get(Calendar.YEAR);
		return year;
    }
	@Override
	public List<Attendance> queryAtten(String year, String month, String day) {
		if(year == null || "".equals(year)) {
			int y = getYear();
		}
		return null;
	}
}
