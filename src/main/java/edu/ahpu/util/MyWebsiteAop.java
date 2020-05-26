package edu.ahpu.util;

import edu.ahpu.service.GoodsService;
import edu.ahpu.service.UserService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Arrays;

/**
 * 本网站的aop组件
 *
 * @author jinfei
 * @create 2020-03-17 14:33
 */
@Component
@Aspect
public class MyWebsiteAop {

    @Autowired
    private GoodsService goodsService;

    /**
     * 每次调用goodsService.getGoodsByPrimaryKey(id)之前都会更新该物品对应的浏览量
     */
    @Before("execution(* edu.ahpu.service.impl.GoodsServiceImpl.getGoodsByPrimaryKey(..))")
    public void updatePageviews(JoinPoint joinPoint) {
        //获取参数信息
        Object[] args = joinPoint.getArgs();
        Integer id = Integer.parseInt(args[0].toString());
        goodsService.updateGoodsPageviews(id);
        System.out.println("浏览id为" + id + "的商品=======");
    }

}
