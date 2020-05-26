package edu.ahpu.pojo;
/**
 * 关注信息 实体类
 */
public class Focus {
	
	private Integer id;

    private Integer goodsId;

    private Integer userId;

    private String focusTime;

    private GoodsExtend goodsExtend;

	public GoodsExtend getGoodsExtend() {
		return goodsExtend;
	}

	public void setGoodsExtend(GoodsExtend goodsExtend) {
		this.goodsExtend = goodsExtend;
	}

	public String getFocusTime() {
		return focusTime;
	}

	public void setFocusTime(String focusTime) {
		this.focusTime = focusTime;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Focus{" +
				"id=" + id +
				", goodsId=" + goodsId +
				", userId=" + userId +
				", focusTime='" + focusTime + '\'' +
				'}';
	}
}
