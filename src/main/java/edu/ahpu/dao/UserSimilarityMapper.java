package edu.ahpu.dao;

import edu.ahpu.pojo.UserSimilarity;

import java.util.List;

/**
 * 类描述：更新数据库中用户与用户之间的相似度
 * 类名称：com.lyu.shopping.recommendate.mapper.UserSimilarityMapper
 * @author 曲健磊
 * 2018年3月28日.下午8:53:06
 * @version V1.0
 */
public interface UserSimilarityMapper {

	/**
	 * 新增用户相似度数据
	 * @param userSimilarity 用户相似度数据
	 * @return 受影响到的行数，0表示影响0行，1表示影响1行
	 */
	int saveUserSimilarity(UserSimilarity userSimilarity);
	
	/**
	 * 更新用户相似度数据
	 * @param userSimilarity 用户相似度数据
	 * @return 受影响到的行数，0表示影响0行，1表示影响1行
	 */
	int updateUserSimilarity(UserSimilarity userSimilarity);
	
	/**
	 * 判断某两个用户之间的相似度是否已经存在
	 * @param userSimilarity 存储两个用户的id
	 * @return 返回1表示已经存在，返回0表示不存在
	 */
	int countUserSimilarity(UserSimilarity userSimilarity);
	
	/**
	 * 查询某个用户与其他用户之间的相似度列表
	 * @param userId 带查询的用户id
	 * @return 该用户与其他用户的相似度列表
	 */
	List<UserSimilarity> listUserSimilarityByUId(Long userId);
	
}
