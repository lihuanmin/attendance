package lee.attendance.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import lee.attendance.commons.LoginRequired;
import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.domain.Menu;
import lee.attendance.domain.UserInfo;
import lee.attendance.domain.UserLeave;
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
	@RequestMapping("myleave")
	public String myleave(HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "leave/leaveList";
	}
	/**
	 * 请假
	 * @param req
	 * @param start
	 * @param end
	 * @param reason
	 * @return
	 */
	@RequestMapping("leave")
	@ResponseBody
	public ResultMsg attendance(HttpServletRequest req, @RequestParam("start")String start, @RequestParam("end")String end, @RequestParam("reason")String reason) {
		return leaveService.leave((int)req.getSession().getAttribute("userId"), start, end, reason);
	}
	@RequestMapping("leavePage")
	public String leavePage(HttpServletRequest req, Model model){
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "leave/myLeave";
	}
	@RequestMapping("leaveList")
	@ResponseBody
	public String leaveList(HttpServletRequest req, 
			@RequestParam("startTime")String startTime, 
			@RequestParam("endTime")String endTime,
			@RequestParam("pageNumber")int pageNumber, 
			@RequestParam("pageSize")int pageSize) {
		int userId = (int)req.getSession().getAttribute("userId");
		return JSON.toJSONString(leaveService.listLeave(userId, pageNumber, pageSize, startTime, endTime));
	}
	
}
