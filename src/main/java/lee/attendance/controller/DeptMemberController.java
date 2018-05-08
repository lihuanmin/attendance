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
import lee.attendance.domain.transfer.MemberLeave;
import lee.attendance.service.DeptMemberService;
import lee.attendance.service.HomeService;

@Controller
@RequestMapping("deptMember")
@LoginRequired
public class DeptMemberController {
	@Autowired
	private HomeService homeService;
	@Autowired
	private DeptMemberService deptMemberService;
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
		PageResponse<MemberLeave> list = deptMemberService.memberLeave(userId, pageNumber, pageSize);
		return JSON.toJSONString(list);
	}
	/**
	 * 审核员工请假
	 * @param id
	 * @param re
	 * @return
	 */
	@RequestMapping("check")
	@ResponseBody
	public ResultMsg check(@RequestParam("id")int id, @RequestParam("re")int re) {
		return deptMemberService.check(id, re);
	}
	/**
	 * 请假历史记录页面
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping("leaveHisPage")
	public String leaveHisPage(HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "deptmem/hisLeave";
	}
	/**
	 * 请假历史记录
	 * @param req
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("leaveHis")
	@ResponseBody
	public String leaveHis(
			HttpServletRequest req,
			@RequestParam("pageNumber")int pageNumber, 
			@RequestParam("pageSize")int pageSize) {
		int userId = (int)req.getSession().getAttribute("userId");
		PageResponse<MemberLeave> list = deptMemberService.hisLeave(userId, pageNumber, pageSize);
		return JSON.toJSONString(list);
	}
	/**
	 * 员工考勤页面
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping("memAttenPage")
	public String memAttenPage(HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "deptmem/memberAtten";
	}
}
