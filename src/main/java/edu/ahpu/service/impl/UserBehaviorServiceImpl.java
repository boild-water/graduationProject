package edu.ahpu.service.impl;

import edu.ahpu.pojo.UserBehavior;
import edu.ahpu.dao.UserBehaviorMapper;
import edu.ahpu.service.UserBehaviorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 类描述：用户的浏览行为服务接口的具体实现类
 * 类名称：com.lyu.shopping.recommendate.service.impl.UserBehaviorServiceImpl
 * @author 曲健磊
 * 2018年4月29日.下午5:24:00
 * @version V1.0
 */
@Service("userActiveService")
public class UserBehaviorServiceImpl implements UserBehaviorService {

	@Autowired
	private UserBehaviorMapper userBehaviorMapper;

	@Override
	public List<UserBehavior> listAllUserBehaviors() {
		return userBehaviorMapper.listAllUserBehaviors();
	}
	
	@Override
	@Transactional(isolation = Isolation.DEFAULT, propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
	public boolean saveUserBehavior(UserBehavior userBehavior) {
		boolean flag = false;
		// 1.先判断用户行为表中是否存在记录
		Long hits = userBehaviorMapper.getHitsByUserBehavior(userBehavior);
		int saveRows = 0;
		int updateRows = 0;
		// 2.不存在就添加 存在就更新
		if (hits == null) {
			// 不存在
			userBehavior.setHits(1L); // 不存在记录的话那肯定是第一次访问，那点击量肯定是1
			saveRows = this.userBehaviorMapper.addUserBehavior(userBehavior);
		} else {
			// 已经存在
			hits++;
			userBehavior.setHits(hits);
			updateRows = this.userBehaviorMapper.updateUserBehavior(userBehavior);
		}
		if (saveRows > 0 || updateRows > 0) {
			flag = true;
		}
		return flag;
	}


}
