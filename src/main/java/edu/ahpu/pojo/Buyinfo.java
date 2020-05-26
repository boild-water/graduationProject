package edu.ahpu.pojo;

/**
 * 求购信息实体类
 */
public class Buyinfo {

    private Integer id; //求购信息id
	private Integer userId;//求购信息发布者
    private String createAt;//求购信息发布时间
	private String context;//求购信息内容

    private User user;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getCreateAt() {
		return createAt;
	}

	public void setCreateAt(String createAt) {
		this.createAt = createAt;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Buyinfo{" +
				"id=" + id +
				", userId=" + userId +
				", createAt='" + createAt + '\'' +
				", context='" + context + '\'' +
				", user=" + user +
				'}';
	}
}