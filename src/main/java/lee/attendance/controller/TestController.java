package lee.attendance.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lee.attendance.domain.Menu;

@Controller
@RequestMapping("/test")
public class TestController {
	@RequestMapping("method")
	@ResponseBody
	public List<Menu> method() {
		Menu menu1 = new Menu();
		menu1.setId(1);
		menu1.setMenuName("menu1");
		menu1.setMenuCode("code1");
		Menu menu2 = new Menu();
		menu2.setId(2);
		menu2.setMenuName("menu2");
		menu2.setMenuCode("code2");
		List<Menu> list = new ArrayList<Menu>();
		list.add(menu1);
		list.add(menu2);
		return list;
	}
}
