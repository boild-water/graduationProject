package edu.ahpu.pojo;

import com.alibaba.fastjson.annotation.JSONField;
import com.alibaba.fastjson.serializer.ToStringSerializer;

/**
 * @author jinfei
 * @create 2020-05-02 16:35
 */
public class OrderStatus {

    @JSONField(serializeUsing = ToStringSerializer.class)//该注解在对此字段进行序列化时，会将Long型自动转化为String型，解决前端精度丢失问题
    private Long orderId;       //订单id

    private Byte status;        //订单状态
    private String createTime;  //订单创建时间
    private String paymentTime; //订单支付时间
    private String consignTime; //订单发货时间
    private String endTime;     //订单完成时间
    private String closeTime;   //订单关闭时间
    private String applyRefundTime;//申请退款时间
    private String refundTime;  //退款到账时间
    private String commentTime; //订单评价时间


    public String getApplyRefundTime() {
        return applyRefundTime;
    }

    public void setApplyRefundTime(String applyRefundTime) {
        this.applyRefundTime = applyRefundTime;
    }

    public String getRefundTime() {
        return refundTime;
    }

    public void setRefundTime(String refundTime) {
        this.refundTime = refundTime;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(String paymentTime) {
        this.paymentTime = paymentTime;
    }

    public String getConsignTime() {
        return consignTime;
    }

    public void setConsignTime(String consignTime) {
        this.consignTime = consignTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(String closeTime) {
        this.closeTime = closeTime;
    }

    public String getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(String commentTime) {
        this.commentTime = commentTime;
    }

    @Override
    public String toString() {
        return "OrderStatus{" +
                "orderId=" + orderId +
                ", status=" + status +
                ", createTime='" + createTime + '\'' +
                ", paymentTime='" + paymentTime + '\'' +
                ", consignTime='" + consignTime + '\'' +
                ", endTime='" + endTime + '\'' +
                ", closeTime='" + closeTime + '\'' +
                ", commentTime='" + commentTime + '\'' +
                '}';
    }
}
