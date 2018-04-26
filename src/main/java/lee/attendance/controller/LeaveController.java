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
import lee.attendance.domain.Leave;
import lee.attendance.domain.Menu;
import lee.attendance.domain.UserInfo;
import lee.attendance.domain.transfer.MemberLeave;
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
	@RequestMapping("leaveList")
	public String leaveList(HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		List<Leave> list = leaveService.listLeave(userId);
		model.addAttribute("listLeave", list);
		return "leave/myLeave";
	}
	/**
	 * 员工请假页面
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping("memberLeave")
	public String memberLeave(HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "deptmem/deptMember";
	}
	/**
	 * 查看部门员工请假
	 * @param req
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("memleave")
	@ResponseBody
	public String memleave(
			HttpServletRequest req,
			@RequestParam("pageNumber")int pageNumber, 
			@RequestParam("pageSize")int pageSize){
		int userId = (int)req.getSession().getAttribute("userId");
		PageResponse<MemberLeave> list = leaveService.memberLeave(userId, pageNumber, pageSize);
		return JSON.toJSONString(list);
	}
	@RequestMapping("check")
	@ResponseBody
	public ResultMsg check(@RequestParam("id")int id, @RequestParam("re")String re) {
		return leaveService.check(id, re);
	}
}
