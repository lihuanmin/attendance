package lee.attendance.commons;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
/**
 * 在需要登录验证的Controller的方法上使用此注解
 * @author lee
 *
 */
@Documented
@Retention(RetentionPolicy.RUNTIME)//
@Target({ElementType.METHOD, ElementType.TYPE})//该注解修饰类中的方法
@Inherited
public @interface LoginRequired {

}
