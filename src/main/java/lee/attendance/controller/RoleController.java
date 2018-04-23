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
import lee.attendance.domain.Menu;
import lee.attendance.domain.Role;
import lee.attendance.domain.UserInfo;
import lee.attendance.domain.transfer.RoleMenuInfo;
import lee.attendance.domain.transfer.RoleMenuUpdate;
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
		List<Role> roleList = roleService.selectAllRole();
		model.addAttribute("roleList", roleList);
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
	/**
	 * 添加新角色
	 * @param roleName
	 * @param roleDetail
	 * @param menu
	 * @return
	 */
	@RequestMapping("addNewRole")
	@ResponseBody
	public ResultMsg addNewRole(
			@RequestParam("roleName")String roleName, 
			@RequestParam("roleDetail")String roleDetail, 
			@RequestParam("menu")int[] menu) {
		if(null==roleName||"".equals(roleName)||null==roleDetail||"".equals(roleDetail)||menu==null) {
			return new ResultMsg(Boolean.FALSE, "不能有信息为空");
		}
		return roleService.addRole(roleName, roleDetail, menu);
	}
	/**
	 * 更新角色页面
	 * @return
	 */
	@RequestMapping("updateRole")
	public String updateRolePage(@RequestParam("roleId")int roleId,HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		RoleMenuInfo roleMenuInfo = roleService.findRoleAllMenu(roleId);
		model.addAttribute("roleMenuInfo", roleMenuInfo);
		List<Menu> list = roleService.queryMenu();
		model.addAttribute("allRole", list);
		return "role/updateRole";
	}
	/**
	 * 查询角色菜单
	 * @param roleId
	 * @return
	 */
	@RequestMapping("roleMenu")
	@ResponseBody
	public String roleMenu(@RequestParam("roleId")int roleId){
		List<Menu> list = roleService.findMenuByRoleId(roleId);
		return JSON.toJSONString(list);
	}
	@RequestMapping("roleUpdate")
	@ResponseBody
	public ResultMsg updateRole(
			@RequestParam("roleId")int roleId, 
			@RequestParam("roleName")String roleName, 
			@RequestParam("roleDetail")String roleDetail,
			@RequestParam("menu")int[] menu) {
		RoleMenuUpdate roleMenu = new RoleMenuUpdate(roleId, roleName, roleDetail, menu);
		return roleService.updateRole(roleMenu);
	}
	/**
	 * @param roleId
	 * @return
	 */
	@RequestMapping("roleDetail")
	public String roleDetail(@RequestParam("roleId")int roleId,HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		RoleMenuInfo roleMenuInfo = roleService.findRoleAllMenu(roleId);
		model.addAttribute("roleMenuInfo", roleMenuInfo);
		return "role/roleDetail";
	}
}
