package edu.ahpu.dao;

import org.apache.ibatis.annotations.Param;

import edu.ahpu.pojo.User;

import java.util.List;

public interface UserMapper{


    //admin 功能分界线 **************************************************

    /**
     * 查询所有的用户数
     * @return
     */
    Integer getAllUsersCount();

    /**
     * 查询所有user(支持条件查找)
     */
    List<User> getUserList(User user);//获取所有用户

    /**
     * 条件更新user
     */
    int updateByPrimaryKeySelective(User user);

    /**
     * 根据id查询user
     */
    User getUserById(Integer id);

    /**
     * 全字段更新user
     */
    int updateByPrimaryKey(User user);

    /**
     * 删除user(真正的删除)
     */
    int deleteByPrimaryKey(Integer id);

    //admin 功能分界线 **************************************************








    /**
     * 更新user的最后登录时间
     */
    void updateLastLogin(User user);



    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);



    User getUserByPhone(String phone);//通过手机号查询用户

    int updateGoodsNum(@Param("id") Integer id, @Param("goodsNum") Integer goodsNum);//更改用户的商品数量


	int findCount();



	List<User> getUserListByUser(@Param("phone") String phone, @Param("username") String username, @Param("qq") String qq);

	List<User> getUserListOrderByCreateAt();

    /**
     * 根据id更新user密码
     */
    void modifyPassword(User user);




}