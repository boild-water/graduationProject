package edu.ahpu.service;


import edu.ahpu.pojo.UserBehavior;

import java.util.List;

/**
 * 类描述：操作数据库中用户的行为数据的服务类
 * 类名称：com.lyu.shopping.recommendate.service.UserBehaviorService
 * @author 曲健磊
 * 2018年3月26日.下午6:33:09
 * @version V1.0
 */

public interface UserBehaviorService {

	/**
	 * 查询出所有的用户行为
	 * @return 返回用户的行为数据
	 */
	List<UserBehavior> listAllUserBehaviors();
	
	/**
	 * 保存用户的浏览记录，如果用户的浏览记录存在则更新，不存在则添加
	 * @param userBehavior 用户的行为数据
	 * @return true表示更新成功，false表示更新失败
	 */
	boolean saveUserBehavior(UserBehavior userBehavior);


}
