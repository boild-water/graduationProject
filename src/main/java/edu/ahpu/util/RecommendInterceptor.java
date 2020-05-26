package edu.ahpu.util;

import edu.ahpu.pojo.User;
import edu.ahpu.pojo.UserBehavior;
import edu.ahpu.service.CategoryService;
import edu.ahpu.service.GoodsService;
import edu.ahpu.service.UserBehaviorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * 物品推荐模块拦截器 拦截规则
 *  1.拦截所有 /category/{id} 请求
 *      直接拿到categoryId
 *  2.拦截所有 /goodsId/{id} 请求
 *      根据goodsId来查询categoryId，从而取得categoryId
 *
 * @author jinfei
 * @create 2020-05-24 16:23
 */
public class RecommendInterceptor implements HandlerInterceptor {

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private UserBehaviorService userBehaviorService;

    /**
     * 1.拦截所有 /category/{id} 请求
     *      直接拿到categoryId
     * 2.拦截所有 /goodsId/{id} 请求
     *      根据goodsId来查询categoryId，从而取得categoryId
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        //首先判断用户是否登录,用户没有登录直接放行,未登录的用户不做物品推荐
        User user = (User) httpServletRequest.getSession().getAttribute("cur_user");
        if (user != null){
            //判断用户请求的地址为/category/{id}还是/goodsId/{id}
            if (httpServletRequest.getRequestURI().contains("/category/")) {
                //获取categoryId
                String url = httpServletRequest.getRequestURI();
                //url:/goods/category/2
                String[] categoryIds = url.split("/");
                Integer categoryId = Integer.parseInt(categoryIds[categoryIds.length-1]);

                //判断用户是否点击了最新发布(/goods/category/0),最新发布内容不在用户推荐范围之内
                if (categoryId != 0) {
                    //封装用户行为信息
                    UserBehavior userBehavior = new UserBehavior();
                    userBehavior.setUserId(user.getId());
                    userBehavior.setCategoryId(categoryId);
                    //至于是执行添加操作还是更新操作，留给service层判断
                    userBehaviorService.saveUserBehavior(userBehavior);
                }

            } else if (httpServletRequest.getRequestURL().toString().contains("/goodsId/")) {
                //先获取goodsId，然后再获取categoryId
                //获取categoryId
                String url = httpServletRequest.getRequestURI();
                //url:/goods/goodsId/123
                String[] goodsIds = url.split("/");
                Integer goodsId = Integer.parseInt(goodsIds[goodsIds.length-1]);

                //获取categoryId
                Integer categoryId = goodsService.getGoodsById(goodsId).getCategoryId();

                //封装用户行为信息
                UserBehavior userBehavior = new UserBehavior();
                userBehavior.setUserId(user.getId());
                userBehavior.setCategoryId(categoryId);

                //至于是执行添加操作还是更新操作，留给service层判断
                userBehaviorService.saveUserBehavior(userBehavior);
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
