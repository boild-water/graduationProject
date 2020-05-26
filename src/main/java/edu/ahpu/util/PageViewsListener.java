package edu.ahpu.util;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.servlet.ServletContext;
import java.util.Enumeration;
import java.util.Timer;
import java.util.TimerTask;

/**
 * 在SpringMVC容器启动后，执行定时器方法，时间间隔为10s，每10s向数据库更新一下网站访问量
 *
 * @author jinfei
 * @create 2020-05-20 10:37
 */
@Component
public class PageViewsListener implements ApplicationListener<ContextRefreshedEvent> {


    /**
     * 监听Spring容器启动完成事件
     *  由于本项目整合了SpringMVC，项目启动相当于会有两个容器启动(Spring作为父容器，SpringMVC作为子容器)
     *  所以，下面的方法会执行两次，具体监听哪个容器可以自行判断
     * @param event
     */
    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {

        //判断根据容器名判断哪个容器启动了
        if (event.getApplicationContext().getDisplayName().equals("Root WebApplicationContext")){
            //说明此处父容器Spring启动了
            System.out.println("************Spring父容器启动了*************");
        } else {
            //说明了SpringMVC对应的子容器启动了
            System.out.println("************SpringMVC子容器启动了************");

            //在SpringMVC容器启动后，才执行下面方法(因为要获取Servlet的ServletContext对象)
            WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
            ServletContext servletContext = webApplicationContext.getServletContext();

//            //设置定时任务，每隔10s执行一次
//            new Timer().schedule(new TimerTask() {
//                @Override
//                public void run() {
//
//                    //从servletContext取出网站浏览量信息，设置定时器(异步)，每隔10s，往数据库更新网站浏览量
//                    Long websitePageViews = (Long) servletContext.getAttribute("websitePageViews");
//                    //执行任务
//                    System.out.println("当前网站访问量:"+websitePageViews);
//                }
//            },0,10000);

        }

    }
}
