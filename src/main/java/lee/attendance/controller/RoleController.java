package lee.attendance.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import lee.attendance.commons.LoginRequired;
import lee.attendance.domain.Menu;
import lee.attendance.domain.UserInfo;
import lee.attendance.service.HomeService;
import lee.attendance.service.RoleService;

@Controller
@RequestMapping("role")
@LoginRequired
public class RoleController {
	@Autowired
	private HomeService homeService;
	@Autowired
	private RoleService roleService;
	@RequestMapping("role")
	public String role(HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "role/roleManager";
	}
	@RequestMapping("addRole")
	public String addRole(HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "role/addRole";
	}
	/**
	 * 查询所有的菜单
	 * @return
	 */
	@RequestMapping("queryMenu")
	@ResponseBody
	public String queryMenu() {
		return JSON.toJSONString(roleService.queryMenu());
	}
}
