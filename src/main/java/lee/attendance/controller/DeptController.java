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
import lee.attendance.domain.Department;
import lee.attendance.domain.Menu;
import lee.attendance.domain.UserInfo;
import lee.attendance.service.DeptService;
import lee.attendance.service.HomeService;

@Controller
@RequestMapping("department")
@LoginRequired
public class DeptController {
	@Autowired
	private HomeService homeService;
	@Autowired
	private DeptService deptService;
	
	@RequestMapping("dept")
	public String dept(HttpServletRequest req, Model model){
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "dept/addDept";
	}
	/**
	 * 添加部门
	 * @param req
	 * @param deptName
	 * @param deptCode
	 * @param slogan
	 * @return
	 */
	@RequestMapping("addDept")
	@ResponseBody
	public ResultMsg addDept(HttpServletRequest req,
			@RequestParam("deptName")String deptName,
			@RequestParam("deptCode")String deptCode,
			@RequestParam("slogan")String slogan) {
		if("".equals(deptName)||null==deptName||"".equals(deptCode)||deptCode==null||"".equals(slogan)||null==slogan)
			return new ResultMsg(Boolean.FALSE,"信息不能为空");
		Department depart = new Department();
		depart.setDeptCode(deptCode);
		depart.setDeptName(deptName);
		depart.setSlogan(slogan);
		depart.setHead("暂无");
		return deptService.addDept(depart);
	}
	/**
	 * 验证部门名字
	 * @param deptName
	 * @return
	 */
	@RequestMapping("checkName")
	@ResponseBody
	public ResultMsg checkName(@RequestParam("deptName")String deptName) {
		if(deptName==""||deptName==null)
			return new ResultMsg(Boolean.FALSE, "部门名称不能为空");
		String result = deptService.getIdByName(deptName);
		if(!"".equals(result)&&null != result)
			return new ResultMsg(Boolean.FALSE, "部门已存在");
		return new ResultMsg(Boolean.TRUE, "验证通过");
	}
	/**
	 * 部门管理页面
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("deptManager")
	public String deptManager(Model model, HttpServletRequest req) {
		List<Department> list = deptService.selectAllDept();
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		if(list == null)
			model.addAttribute("list","暂无任何部门信息");
		else
			model.addAttribute("list", list);
		return "dept/deptManager";
	}
	/**
	 * 更新部门
	 * @param dept
	 * @return
	 */
	@RequestMapping("updateDept")
	@ResponseBody
	public ResultMsg updateDept(Department dept) {
		if(null==dept.getDeptName()||"".equals(dept.getDeptName())||null==dept.getDeptCode()||"".equals(dept.getDeptName()))
			return new ResultMsg(Boolean.FALSE, "部门信息不能为空");
		if(dept.getHead()==null||"".equals(dept.getHead())||"暂无".equals(dept.getHead()))
			dept.setHead("暂无");
		if(dept.getSlogan()==null||"".equals(dept.getSlogan()))
			dept.setSlogan("zanwu");
		return deptService.updateDept(dept);
	}
	/**
	 * 查询部门
	 * @param deptId
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping("queryDept")
	public String queryDept(@RequestParam("deptId")int deptId,HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		Department department = deptService.queryDeptById(deptId);
		model.addAttribute("dept", department);
		return "dept/editDept";
	}
	/**
	 * 搜索部门成员
	 * @return
	 */
	@RequestMapping("search")
	@ResponseBody
	public String search(@RequestParam("deptId")int deptId) {
		return JSON.toJSONString(deptService.search(deptId));
	}
}




















