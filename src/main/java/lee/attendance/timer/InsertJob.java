package lee.attendance.timer;

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
		System.out.println("hello");
		List<Integer> list = userVerificationMapper.selectAllUserId();
		attendanceService.insertAll(list);
	}
}
