package edu.ahpu.service.impl;

import edu.ahpu.pojo.UserSimilarity;
import edu.ahpu.dao.UserSimilarityMapper;
import edu.ahpu.service.UserSimilarityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 类描述：对用户之间的相似度进行增删改查的服务实现类
 * 类名称：com.lyu.shopping.recommendate.service.impl.UserSimilarityServiceImpl
 * @author 曲健磊
 * 2018年3月28日.下午9:02:22
 * @version V1.0
 */
@Service("userSimilarityService")
public class UserSimilarityServiceImpl implements UserSimilarityService {

	@Autowired
	private UserSimilarityMapper userSimilarityMapper;

	@Override
	public boolean saveUserSimilarity(UserSimilarity userSimilarity) {
		boolean flag = false;
		
		int rows = this.userSimilarityMapper.saveUserSimilarity(userSimilarity);
		if (rows > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean updateUserSimilarity(UserSimilarity userSimilarity) {
		boolean flag = false;
		
		int rows = this.userSimilarityMapper.updateUserSimilarity(userSimilarity);
		if (rows > 0) {
			flag = true;
		}
		return flag;
	}

	@Override
	public boolean isExistsUserSimilarity(UserSimilarity userSimilarity) {
		int count = this.userSimilarityMapper.countUserSimilarity(userSimilarity);
		if (count > 0) {
			return true;
		}
		return false;
	}
	
	@Override
	public List<UserSimilarity> listUserSimilarityByUId(Long userId) {
		if (userId == null) {
			return null;
		}
		List<UserSimilarity> userSimilarityList = this.userSimilarityMapper.listUserSimilarityByUId(userId);
		
		return userSimilarityList;
	}

}
