package lee.attendance.commons;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor{

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if (handler instanceof HandlerMethod) {
			HandlerMethod myHandlerMethod = (HandlerMethod)handler;
			Object bean = myHandlerMethod.getBean();//类
			Method method = myHandlerMethod.getMethod();//方法
			
			Annotation classAnnotation = bean.getClass().getAnnotation(LoginRequired.class);
			Annotation methodAnnotation = method.getAnnotation(LoginRequired.class);
			//使用了登录注解检查，用户是否登录了
			if (classAnnotation != null || methodAnnotation != null) {
				String verification = (String)request.getSession().getAttribute("userAccount");
				if (verification != null) 
					return true;
				else
					response.sendRedirect("/attendance/login.html");
			//没有使用注解，直接放行
			} else
				return true;
		}
		return false;
	}

}
