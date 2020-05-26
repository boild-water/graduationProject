package edu.ahpu.pojo;

/**
 * 用户实体类
 */
public class User {

    private Integer id;         //用户id
    private String headImgUrl;  //头像图片地址
    private String username;    //用户名
    private String phone;       //用户手机号码
    private String password;    //密码
    private Byte sex;           //性别 0表示男 1表示女
    private String birthday;    //出生日期
    private String email;       //邮箱
    private String qq;          //用户QQ
    private String lastLogin;   //最近一次登录
    private Integer power;      //信誉分
    private String createAt;    //创建时间
    private Byte status;        //用户状态 0表示冻结中 1表示未冻结

    //getters and setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq == null ? null : qq.trim();
    }

    public String getCreateAt() {
        return createAt;
    }

    public void setCreateAt(String createAt) {
        this.createAt = createAt == null ? null : createAt.trim();
    }

    public Integer getPower() {
        return power;
    }

    public void setPower(Integer power) {
        this.power = power;
    }

    public String getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(String lastLogin) {
        this.lastLogin = lastLogin == null ? null : lastLogin.trim();
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }

    public String getHeadImgUrl() {
        return headImgUrl;
    }

    public void setHeadImgUrl(String headImgUrl) {
        this.headImgUrl = headImgUrl;
    }

    public Byte getSex() {
        return sex;
    }

    public void setSex(Byte sex) {
        this.sex = sex;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", headImgUrl='" + headImgUrl + '\'' +
                ", username='" + username + '\'' +
                ", phone='" + phone + '\'' +
                ", password='" + password + '\'' +
                ", sex=" + sex +
                ", birthday='" + birthday + '\'' +
                ", email='" + email + '\'' +
                ", qq='" + qq + '\'' +
                ", lastLogin='" + lastLogin + '\'' +
                ", power=" + power +
                ", createAt='" + createAt + '\'' +
                ", status=" + status +
                '}';
    }
}