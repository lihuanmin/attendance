package lee.attendance.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import lee.attendance.commons.LoginRequired;
import lee.attendance.commons.ResultMsg;
import lee.attendance.domain.Department;
import lee.attendance.domain.Menu;
import lee.attendance.domain.UserInfo;
import lee.attendance.domain.transfer.User;
import lee.attendance.service.DeptService;
import lee.attendance.service.HomeService;
import lee.attendance.service.MemberService;

@Controller
@RequestMapping("member")
@LoginRequired
public class MemberController {
	@Autowired
	private HomeService homeService;
	@Autowired
	private DeptService deptService;
	@Autowired
	private MemberService memberService;
	@RequestMapping(value="addMember", method=RequestMethod.GET)
	public String addMember(Model model, HttpServletRequest req){
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "member/addMember";
	}
	/**
	 * 查询所有的部门
	 * @return
	 */
	@RequestMapping("queryDept")
	@ResponseBody
	public String queryDept() {
		List<Department> list = deptService.queryDept();
		return JSON.toJSONString(list);
	}
	/**
	 * 查询角色
	 * @return
	 */
	@RequestMapping("queryRole")
	@ResponseBody
	public String queryRole() {
		return JSON.toJSONString(memberService.queryRole());
	}
	/**
	 * 添加成员
	 * @param user
	 * @return
	 */
	@RequestMapping("addMem")
	@ResponseBody
	public ResultMsg addMen(User user) {
		if(user.getDeptId() == null ||"".equals(user.getDeptId())) 
			return new ResultMsg(Boolean.FALSE, "部门信息为空");
		if(user.getUserName() == null || "".equals(user.getUserName()))
			return new ResultMsg(Boolean.FALSE, "员工姓名不能为空");
		if(user.getPrefixAccount() == null || "".equals(user.getPrefixAccount())||user.getSuffixAccount() == null || "".equals(user.getSuffixAccount())) 
			return new ResultMsg(Boolean.FALSE, "账号不能为空");
		if(user.getSex() == null || "".equals(user.getSex())) 
			return new ResultMsg(Boolean.FALSE, "性别不能为空");
		if(user.getRole() == null || "".equals(user.getRole()))
			return new ResultMsg(Boolean.FALSE, "角色不能为空");
		return memberService.addMember(user);
	}
	/**
	 * 查询员工个数
	 * @return
	 */
	@RequestMapping("queryCount")
	@ResponseBody
	public int findMemberNumber(){
		return memberService.queryCount();
	}
	/**
	 * 员工列表
	 * @return
	 */
	@RequestMapping("memberListPage")
	public String memberList(Model model, HttpServletRequest req) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "member/memberList";
	}
	/**
	 * 成员列表
	 * @param realName
	 * @param dept
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("memberList")
	@ResponseBody
	public String memberList(
			@RequestParam("realName")String realName,
			@RequestParam("dept")String dept,
			@RequestParam("pageNumber")int pageNumber, 
			@RequestParam("pageSize")int pageSize) {
		return JSON.toJSONString(memberService.findAllUser(dept, realName, pageNumber, pageSize));
	}
	/**
	 * 删除用户
	 * @param userId
	 * @return
	 */
	@RequestMapping("delUser")
	@ResponseBody
	public ResultMsg delUser(@RequestParam("userId")int userId) {
		return memberService.delUser(userId);
	}
}
