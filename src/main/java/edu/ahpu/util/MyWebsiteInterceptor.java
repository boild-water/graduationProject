package edu.ahpu.util;

import edu.ahpu.pojo.Admin;
import edu.ahpu.pojo.User;
import edu.ahpu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * 本网站的拦截器组件
 *
 * @author jinfei
 * @create 2020-05-08 13:40
 */
public class MyWebsiteInterceptor implements HandlerInterceptor{

    @Autowired
    private UserService userService;


    //在所有方法执行前回调该方法
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {

        HttpSession session = httpServletRequest.getSession();
        User user = (User) session.getAttribute("cur_user");

        if (user != null){
            /**
             * 实现用户最后登录时间记录，实现方案：
             *  记录用户每一次请求本网站资源的记录时间，更新到user表中的lastLogin字段，
             *  虽然该种不是很精确，但是作为最后登录时间也可以。
             */
            //更新最后登录时间
            userService.updateLastLogin(user);

        } else {

            /**
             * 由于系统前后台耦合在了一起，所以此处判断管理员是否登录还是比较麻烦的一件事
             */
            StringBuffer requestURL = httpServletRequest.getRequestURL();
            if (requestURL.toString().contains("/admin/")){
                //判断当前管理员是否登录
                Admin admin = (Admin) session.getAttribute("admin");
                if (admin == null) {
                    httpServletResponse.sendRedirect("/admin/login");
                    return false;
                } else {
                    return true;
                }
            }

            httpServletResponse.sendRedirect("/user/login");
            return false;
        }

        /**
         * 获取ServletContext对象，查询网站访问量，将访问量放入ServletContext对象中
         */
//        ServletContext application = httpServletRequest.getServletContext();
//        application.setAttribute("websitePageViews",10L);

        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
