package edu.ahpu.dao;

import edu.ahpu.pojo.UserBehavior;

import java.util.List;

/**
 * 类描述：操作数据库中用户的行为数据
 * 类名称：com.lyu.shopping.recommendate.mapper.UserBehaviorMapper
 * @author 曲健磊
 * 2018年3月26日.下午6:24:49
 * @version V1.0
 */
public interface UserBehaviorMapper {
	
	/**
	 * 查询出所有的用户行为
	 * @return 返回用户的行为数据
	 */
	List<UserBehavior> listAllUserBehaviors();

	/**
	 * 根据userId和categoryId查询用户行为表中对应的点击量
	 * @param userBehavior
	 * @return
	 */
	Long getHitsByUserBehavior(UserBehavior userBehavior);
	
	/**
	 * 统计某个用户的行为记录的条数
	 * @param userActieveDTO 要查询的用户的行为记录的条件
	 * @return 1就说明存在这个用户的行为，0说明不存在
	 */
	int countUserActive(UserBehavior userActieveDTO);
	
	/**
	 * 向用户行为表中添加一条用户的行为记录
	 * @param userActive 用户的行为数据
	 * @return 受影响的行数，1表示插入成功，0表示插入失败
	 */
	int addUserBehavior(UserBehavior userActive);
	
	/**
	 * 更新用户对某个二级类目的点击量
	 * @param userActive 用户的浏览行为数据
	 * @return 1表示更新成功，0表示更新失败
	 */
	int updateUserBehavior(UserBehavior userActive);

}
