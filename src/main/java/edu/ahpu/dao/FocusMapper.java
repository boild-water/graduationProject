package edu.ahpu.dao;

import java.util.List;

import edu.ahpu.pojo.Focus;

public interface FocusMapper {

    /**
     * 查询登录用户的所有关注商品
     */
    List<Focus> getFocusByUserId(Integer user_id);

    /**
     * 根据用户id和关注id删除关注的商品
     */
    void deleteFocusByUserIdAndGoodsId(Integer goods_id, Integer user_id);

    /**
     * 添加关注
     */
    void addFocus(Focus focus);

    /**
     * 根据goodsId和userId查询关注记录
     */
    Focus getFocus(Focus focus);
}
