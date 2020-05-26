package edu.ahpu.service;

import java.util.List;

import edu.ahpu.pojo.Focus;

public interface FocusService {
	
	/**
     * 根据用户的id，查询出该用户的所有闲置
     */
    public List<Focus> getFocusByUserId(Integer user_id);
    
    /**
     * 根据用户id和关注id删除我的关注
     */
    public void deleteFocusByUserIdAndGoodsId(Integer goods_id, Integer user_id);

    /**
     * 添加我的关注
     */
    void addFocus(Focus focus);

    /**
     * 根据goodsId和userId查询关注记录
     */
    Focus getFocus(Focus focus);
}
