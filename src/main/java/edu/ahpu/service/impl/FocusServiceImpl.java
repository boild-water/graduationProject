package edu.ahpu.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import edu.ahpu.dao.FocusMapper;
import edu.ahpu.pojo.Focus;
import edu.ahpu.service.FocusService;

@Service("focusService")
public class FocusServiceImpl implements FocusService {
	
	 @Resource
	 private FocusMapper focusMapper;

	 /**
	  * 根据用户id获取我的关注
	  */
	 public List<Focus> getFocusByUserId(Integer user_id) {
		List<Focus> focusList = focusMapper.getFocusByUserId(user_id);
				
        return focusList;
	}
	 
	 /*
	  * 根据用户id和关注id删除
	  */

	public void deleteFocusByUserIdAndGoodsId(Integer goods_id, Integer user_id) {
		
		focusMapper.deleteFocusByUserIdAndGoodsId(goods_id, user_id);
		
	}
	/*
	  * 添加我的关注
	  */
	public void addFocus(Focus focus) {
		
		focusMapper.addFocus(focus);
		
	}

	/**
	 * 根据goodsId和userId查询关注记录
	 */
	@Override
	public Focus getFocus(Focus focus) {
		return focusMapper.getFocus(focus);
	}

}
