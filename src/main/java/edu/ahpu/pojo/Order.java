package edu.ahpu.pojo;

import com.alibaba.fastjson.annotation.JSONField;
import com.alibaba.fastjson.serializer.ToStringSerializer;

/**
 * 订单实体类
 */
public class Order {

    @JSONField(serializeUsing = ToStringSerializer.class)//该注解在对此字段进行序列化时，会将Long型自动转化为String型，解决前端精度丢失问题
	private Long orderId;//订单id

	private Integer userId;//用户id
    private Integer sellerId;//卖家id
    private Integer goodsId;//物品id
    private Integer addressId;//地址id
    private Byte orderType;//订单支付方式 0货到付款，1在线支付
    private Float orderPrice;//订单价格
    private String orderNote;//订单备注信息
    private String createTime;//订单创建时间

    private OrderStatus orderStatus;//订单状态

    //用于关联查询
    private Goods goods;
    private Address address;
    private Image image;
    private User seller;

    public Integer getSellerId() {
        return sellerId;
    }

    public void setSellerId(Integer sellerId) {
        this.sellerId = sellerId;
    }

    public User getSeller() {
        return seller;
    }

    public void setSeller(User seller) {
        this.seller = seller;
    }

    public Image getImage() {
        return image;
    }

    public void setImage(Image image) {
        this.image = image;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getGoodsId() {
        return goodsId;
    }

    public void setGoodsId(Integer goodsId) {
        this.goodsId = goodsId;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }

    public Byte getOrderType() {
        return orderType;
    }

    public void setOrderType(Byte orderType) {
        this.orderType = orderType;
    }

    public Float getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(Float orderPrice) {
        this.orderPrice = orderPrice;
    }

    public String getOrderNote() {
        return orderNote;
    }

    public void setOrderNote(String orderNote) {
        this.orderNote = orderNote;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public OrderStatus getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", userId=" + userId +
                ", goodsId=" + goodsId +
                ", addressId=" + addressId +
                ", orderType=" + orderType +
                ", orderPrice=" + orderPrice +
                ", orderNote='" + orderNote + '\'' +
                ", createTime='" + createTime + '\'' +
                ", goods=" + goods +
                ", address=" + address +
                '}';
    }
}
