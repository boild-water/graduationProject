package edu.ahpu.pojo;

import edu.ahpu.util.AddressDescriptionUtil;

/**
 * 物品实体类
 */
public class Goods {

    private Integer id;//物品id
    private Integer categoryId;//物品分类id
    private Integer userId;//发布该物品的用户id
    private String name;//物品名称
    private Float price;//物品价格(出售价格)
    private Float realPrice;//物品原来价格(原价)
    private String startTime;//发布时间
    private String endTime;//下架时间
    private String polishTime;//擦亮时间
    private Integer status;//物品状态 1表示上架，0表示下架
    private String description;//物品详细信息
    private Integer pageviews;//物品浏览量
    private Byte isBargain;//是否可还价 0表示可还价 1表示不可还价
    private String addressDesc;//物品发布地址描述

    private AddressDescriptionUtil addressDescUtil;//用于处理物品发布地址描述信息的工具类

    //getters and setters
    public AddressDescriptionUtil getAddressDescUtil() {
        return addressDescUtil;
    }

    public void setAddressDescUtil(AddressDescriptionUtil addressDescUtil) {
        this.addressDescUtil = addressDescUtil;
    }

    public Integer getPageviews() {
        return pageviews;
    }

    public void setPageviews(Integer pageviews) {
        this.pageviews = pageviews;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public Float getRealPrice() {
        return realPrice;
    }

    public void setRealPrice(Float realPrice) {
        this.realPrice = realPrice;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime == null ? null : startTime.trim();
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime == null ? null : endTime.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    public String getPolishTime() {
        return polishTime;
    }

    public void setPolishTime(String polishTime) {
        this.polishTime = polishTime;
    }

    public Byte getIsBargain() {
        return isBargain;
    }

    public void setIsBargain(Byte isBargain) {
        this.isBargain = isBargain;
    }

    public String getAddressDesc() {
        return addressDesc;
    }

    public void setAddressDesc(String addressDesc) {
        this.addressDesc = addressDesc;
    }

    @Override
    public String toString() {
        return "Goods{" +
                "id=" + id +
                ", categoryId=" + categoryId +
                ", userId=" + userId +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", realPrice=" + realPrice +
                ", startTime='" + startTime + '\'' +
                ", endTime='" + endTime + '\'' +
                ", polishTime='" + polishTime + '\'' +
                ", status=" + status +
                ", description='" + description + '\'' +
                ", pageviews=" + pageviews +
                ", isBargain=" + isBargain +
                ", addressDesc='" + addressDesc + '\'' +
                '}';
    }
}