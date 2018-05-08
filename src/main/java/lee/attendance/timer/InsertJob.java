package lee.attendance.timer;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import lee.attendance.dao.UserVerificationMapper;
import lee.attendance.service.AttendanceService;

public class InsertJob {
	@Autowired
	private AttendanceService attendanceService;
	@Autowired
	private UserVerificationMapper userVerificationMapper;
	/**
	 * 插入所有员工的考勤
	 */
	public void execute() {
		//查询所有用户的id
		List<Integer> list = userVerificationMapper.selectAllUserId();
		//插入每天的空记录
		attendanceService.insertAll(list);
	}
	private Date getYtd() {
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int day = calendar.get(Calendar.DAY_OF_MONTH) - 1;
		try {
			Date date = sdf.parse(year+"-"+month+"-"+day);
			return date;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
}
