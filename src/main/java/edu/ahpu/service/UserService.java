package edu.ahpu.service;

import java.util.List;

import com.github.pagehelper.PageHelper;
import edu.ahpu.pojo.Address;
import edu.ahpu.pojo.User;
import edu.ahpu.util.PageHeader;

public interface UserService {



    //admin 功能分界线 **************************************************

    /**
     * 查询所有注册的用户数
     * @return
     */
    Integer getAllUsersCount();

    /**
     * 分页查询user(包含条件查找功能)
     */
    PageHeader<User> getPageUser(PageHeader ph, User user);

    /**
     * 条件更新user
     */
    void updateUserSelective(User user);

    /**
     * 根据id查询user
     */
    User getUserById(Integer id);

    /**
     * 全字段更新用户信息
     */
    void updateUser(User user);

    /**
     * 根据id删除用户
     */
    void deleteUser(User user);


    //admin 功能分界线 **************************************************











    /**
     * 更新user最后的登录时间
     */
    void updateLastLogin(User user);

    /**
     * 增加user(用户注册)
     */
    void addUser(User user);

    User getUserByPhone(String phone);

    void updateUserName(User user);

    int updateGoodsNum(Integer id, Integer goodsNum);

    User selectByPrimaryKey(Integer id);

    List<User> getPageUser(int pageNum, int pageSize);

    int getUserNum();

    int getUserNum(String username);

    List<User> getPageUser(int pageNum, int pageSize, String username);



    void deleteUserById(String idArr);

    List<User> getPageUserByUser(String phone, String username, String qq, int pageNum, int pageSize);

    List<User> getUserOrderByDate(int size);

    int getUserNumByUser(String phone, String username, String qq);



    /**
     * 根据id更新user密码
     */
    void modifyPassword(User user);



}