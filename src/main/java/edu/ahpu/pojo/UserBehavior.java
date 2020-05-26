package edu.ahpu.pojo;

import java.io.Serializable;

/**
 * 用户浏览行为实体类
 */
public class UserBehavior implements Serializable {

	private static final long serialVersionUID = -103797500202536441L;
	
	// 用户id
	private Integer userId;
	
	// 二级类目的id
	private Integer categoryId;
	
	// 该用户对该二级类目的点击量
	private Long hits;

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public Long getHits() {
		return hits;
	}

	public void setHits(Long hits) {
		this.hits = hits;
	}
}
