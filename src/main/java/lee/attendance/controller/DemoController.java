package lee.attendance.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lee.attendance.service.DemoService;

@Controller
@RequestMapping("/demo")
public class DemoController {
	@Autowired
	private DemoService userService;
	@RequestMapping("/method")
	@ResponseBody
	public String method() {
		System.out.println(userService.findAllUser());
		return "hello";
	}
}
