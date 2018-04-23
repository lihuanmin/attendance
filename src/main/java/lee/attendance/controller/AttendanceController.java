package lee.attendance.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lee.attendance.commons.ResultMsg;
import lee.attendance.domain.Attendance;
import lee.attendance.domain.Menu;
import lee.attendance.domain.UserInfo;
import lee.attendance.service.AttendanceService;
import lee.attendance.service.HomeService;

@Controller
@RequestMapping("atten")
public class AttendanceController {
	@Autowired
	private HomeService homeService;
	@Autowired
	private AttendanceService attendanceService;
	@RequestMapping("atten")
	@ResponseBody
	public ResultMsg atten(HttpServletRequest req) {
		int userId = (int)req.getSession().getAttribute("userId");
		ResultMsg msg = attendanceService.atten(userId);
		return msg;
	}
	@RequestMapping("attenPage")
	public String attenPage(HttpServletRequest req, Model model){
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		List<Attendance> list = attendanceService.queryAtten("", "", "");
		return "atten/atten";
	}
}
