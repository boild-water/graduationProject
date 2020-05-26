package edu.ahpu.pojo;

import java.io.Serializable;

/**
 * 类描述：存储用户与用户之间的相似度
 * 类名称：com.lyu.shopping.recommendate.dto.UsersSimilarityDTO
 * @author 曲健磊
 * 2018年3月25日.下午8:35:02
 * @version V1.0
 */
public class UserSimilarity implements Serializable, Comparable<UserSimilarity> {

	private static final long serialVersionUID = 3940726816248544380L;
	
	// 用户id
	private Integer userId;
	
	// 进行比较的用户id
	private Integer userRefId;
	
	// userId与userRefId之间的相似度
	private Double similarity;

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getUserRefId() {
		return userRefId;
	}

	public void setUserRefId(Integer userRefId) {
		this.userRefId = userRefId;
	}

	public Double getSimilarity() {
		return similarity;
	}

	public void setSimilarity(Double similarity) {
		this.similarity = similarity;
	}

	@Override
	public int compareTo(UserSimilarity o) {
		return o.getSimilarity().compareTo(this.getSimilarity());
	}

}
