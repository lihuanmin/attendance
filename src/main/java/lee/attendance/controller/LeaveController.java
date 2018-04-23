package lee.attendance.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lee.attendance.commons.LoginRequired;
import lee.attendance.commons.ResultMsg;
import lee.attendance.domain.Menu;
import lee.attendance.domain.UserInfo;
import lee.attendance.service.HomeService;
import lee.attendance.service.LeaveService;

@Controller
@RequestMapping("leave")
@LoginRequired
public class LeaveController {
	@Autowired
	private HomeService homeService;
	@Autowired
	private LeaveService leaveService;
	@RequestMapping("leavePage")
	public String leavePage(HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "leave/leaveList";
	}
	@RequestMapping("leave")
	@ResponseBody
	public ResultMsg attendance(HttpServletRequest req, @RequestParam("start")String start, @RequestParam("end")String end, @RequestParam("reason")String reason) {
		return leaveService.leave((int)req.getSession().getAttribute("userId"), start, end, reason);
	}
}
