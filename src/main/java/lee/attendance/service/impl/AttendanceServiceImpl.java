package lee.attendance.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.dao.AttendanceMapper;
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
		System.out.println(noon());
		System.out.println(now.compareTo(noon()));
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
		String am = year  + "-" + month + "-" + day + " " + " 9:00:00";
		return am;
	}
	@Override
	public PageResponse<Attendance> queryAtten(String startTime, String endTime, int userId, int pageNumber, int pageSize) {
		Date startDate = new Date();
		Date endDate = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		/*
		 * 当日期范围为空时，则其实日期为月初
		 */
		if((startTime == null||"".equals(startTime))&&(endTime == null || "".equals(endTime))) {
			startDate = getfirstDay();
			endDate = getLastDay();
		}else if(startTime == null||"".equals(startTime)) {
			startDate = getfirstDay();
			try {
				endDate = sdf.parse(endTime);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		} else {
			if(endTime == null || "".equals(endTime)) {
				try {
					startDate = sdf.parse(startTime);
				} catch (ParseException e) {
					e.printStackTrace();
				}
				endDate = getLastDay();
			}
		}
		/*
		 *查询日期范围内的数量 
		 */
		int attenCount = attendanceMapper.findAttenCount(startDate, endDate, userId);
		/*
		 * 查询日期范围内的数据
		 */
		List<Attendance> list = attendanceMapper.findAllAtten(startDate, endDate, userId, pageNumber, pageSize);
		
		PageResponse<Attendance> pr = new PageResponse<Attendance>();
		pr.setDataList(list);
		pr.setTotalRecord(attenCount);
		return pr;
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
	public String noon() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String noon = sdf.format(date) + " 12:00:00";
		return noon;
	}
	public String pm() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String pm = sdf.format(date) + " 18:00:00";
		return pm;
	}
}
