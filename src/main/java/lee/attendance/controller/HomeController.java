package lee.attendance.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lee.attendance.commons.LoginRequired;
import lee.attendance.domain.Menu;
import lee.attendance.domain.UserInfo;
import lee.attendance.service.HomeService;

@Controller
@RequestMapping("home")
@LoginRequired
public class HomeController {
	@Autowired
	private HomeService homeService;
	
	/**
	 * 主页
	 * @return
	 */
	@RequestMapping("home")
	public String home(Model model, HttpServletRequest req) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "home/home";
	}
}
