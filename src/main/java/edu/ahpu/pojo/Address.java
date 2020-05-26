package edu.ahpu.pojo;

import edu.ahpu.util.AddressDescriptionUtil;

/**
 * @author jinfei
 * @create 2020-04-08 17:00
 */
public class Address {

    private Integer id;//地址id
    private String description;//地址信息
    private String username;//联系人姓名
    private String phone;//联系人手机
    private Integer userId;//地址所属用户id
    private Byte defaultAddr;//是否为默认地址，0表示默认，1表示非默认地址

    private AddressDescriptionUtil addressUtil;//地址详情工具类

    public AddressDescriptionUtil getAddressUtil() {
        return addressUtil;
    }
    public void setAddressUtil(AddressDescriptionUtil addressUtil) {
        this.addressUtil = addressUtil;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Byte getDefaultAddr() {
        return defaultAddr;
    }

    public void setDefaultAddr(Byte defaultAddr) {
        this.defaultAddr = defaultAddr;
    }

    @Override
    public String toString() {
        return "Address{" +
                "id=" + id +
                ", description='" + description + '\'' +
                ", username='" + username + '\'' +
                ", phone='" + phone + '\'' +
                ", userId=" + userId +
                ", defaultAddr=" + defaultAddr +
                '}';
    }
}
