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
import lee.attendance.domain.UserInfo;
import lee.attendance.domain.transfer.UserAccountInfo;
import lee.attendance.domain.transfer.UserPassword;
import lee.attendance.service.HomeService;
import lee.attendance.service.UserCenterService;
import lee.attendance.utils.Salt;

@Controller
@RequestMapping("userCenter")
@LoginRequired
public class UserCenterController {
	@Autowired
	private HomeService homeService;
	@Autowired
	private UserCenterService userCenterService;
	/**
	 * 用户中心页面
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("userCenter")
	public String userCenter(Model model, HttpServletRequest req) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "userCenter/userCenter";
	}
	/**
	 * 获取用户个人信息
	 * @param req
	 * @return
	 */
	@RequestMapping("userInfo")
	@ResponseBody
	public String userInfo(HttpServletRequest req){
		int userId = (int)req.getSession().getAttribute("userId");
		UserAccountInfo userAccountInfo = userCenterService.selectUserAccountById(userId);
		return JSON.toJSONString(userAccountInfo);
	}
	/**
	 * 更新用户信息
	 * @param userInfo
	 * @param req
	 * @return
	 */
	@RequestMapping("updateUserInfo")
	@ResponseBody
	public ResultMsg updateUserInfo(UserInfo userInfo, HttpServletRequest req) {
		System.out.println(userInfo);
		userInfo.setId((int)req.getSession().getAttribute("userId"));
		int result = userCenterService.updateUserById(userInfo);
		if(result < 0) 
			return new ResultMsg(Boolean.FALSE, "更新失败");
		return new ResultMsg(Boolean.TRUE, "更新成功");
	}
	/**
	 * 修改密码页面
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping("passwd")
	public String updatePasswd(HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		return "userCenter/passWd";
	}
	 /**
     * 修改密码
     * @param old
     * @param newPassword
     * @param confirm
     * @return
     */
    @RequestMapping("updatePassword")
    @ResponseBody
    public ResultMsg updatePassword(
                                  @RequestParam("oldPassword")String oldPassword,
                                  @RequestParam("newPassword")String newPassword,
                                  @RequestParam("confirmPassword")String confirmPassword,
                                  HttpServletRequest request){
        /*
         * 获取用户id
         */
        int userId = (int)request.getSession().getAttribute("userId");
        /*
         * 判断输入为空
         */
        if(oldPassword==null||newPassword==null||confirmPassword==null){
            return new ResultMsg(Boolean.FALSE,"信息不能为空");
        }
        /*
         * 封装数据到包装类中
         */
        UserPassword userPassword = new UserPassword();
        userPassword.setUserId(userId);
        userPassword.setOld(oldPassword);
        userPassword.setNewPassword(newPassword);
        userPassword.setConfirm(confirmPassword);
        userPassword.setSalt(Salt.salt());
        return userCenterService.updatePassword(userPassword);
    }
}
