package edu.ahpu.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.ahpu.dao.UserMapper;
import edu.ahpu.pojo.User;
import edu.ahpu.service.UserService;
import edu.ahpu.util.DateUtil;
import edu.ahpu.util.PageHeader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.InputStream;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;


    //admin 功能分界线 **************************************************

    /**
     * 查询所有用户数
     */
    @Override
    public Integer getAllUsersCount() {
        return userMapper.getAllUsersCount();
    }

    /**
     * 分页查询user
     */
    @Override
    public PageHeader<User> getPageUser(PageHeader pageHeader,User user) {
        PageHelper.startPage(pageHeader.getPage(),pageHeader.getRows());
        List<User> userList = userMapper.getUserList(user);
        //使用pageHelper组件pageInfo进一次包装
        PageInfo<User> pageInfo = new PageInfo<>(userList);

        //封装pageHeader对象返回
        pageHeader.setResults(userList);//封装分页数据
        pageHeader.setTotalPages(pageInfo.getPages());//封装总页数
        pageHeader.setCount((int) pageInfo.getTotal());//封装总数

        return pageHeader;
    }

    /**
     * 根据id获取user信息
     */
    @Override
    public User getUserById(Integer id) {

        return userMapper.getUserById(id);
    }

    /**
     * 全字段更新用户信息
     */
    @Override
    public void updateUser(User user) {
        userMapper.updateByPrimaryKey(user);
    }

    /**
     * 条件更新user
     */
    @Override
    public void updateUserSelective(User user) {
        userMapper.updateByPrimaryKeySelective(user);
    }

    /**
     * 根据id删除用户
     */
    @Override
    public void deleteUser(User user) {
        userMapper.deleteByPrimaryKey(user.getId());
    }


    //admin 功能分界线 **************************************************














    /**
     * 更新user的最后登录时间
     */
    @Override
    public void updateLastLogin(User user) {
        user.setLastLogin(DateUtil.getNowTime());
        userMapper.updateLastLogin(user);
    }

    /**
     * 添加user(用户注册)
     */
    @Override
    public void addUser(User user) {
        userMapper.insert(user);
    }

    @Override
    public User getUserByPhone(String phone) {
        User user = userMapper.getUserByPhone(phone);
        return user;
    }

    @Override
    public void updateUserName(User user) {
        userMapper.updateByPrimaryKey(user);
    }

    @Override
    public int updateGoodsNum(Integer id, Integer goodsNum) {
        return userMapper.updateGoodsNum(id, goodsNum);
    }

    @Override
    public User selectByPrimaryKey(Integer id) {
        User user = userMapper.selectByPrimaryKey(id);
        return user;
    }

    /**
     * 获取出当前页的用户列表
     */
    @Override
    public List<User> getPageUser(int pageNum, int pageSize) {
//        PageHelper.startPage(pageNum, pageSize);//分页核心代码
//        List<User> list = userMapper.getUserList(user);
        return null;
    }

    /**
     * 获取出用户的数量
     */
    @Override
    public int getUserNum() {
//        List<User> users = userMapper.getUserList(user);
        return 0;
    }

    /**
     * 根据phone、昵称、QQ来获取用户的数量
     */
    @Override
    public int getUserNumByUser(String phone, String username, String qq){
        List<User> list = userMapper.getUserListByUser(phone, username, qq);
        return list.size();
    }


    /**
     * 根据id更新user密码
     */
    @Override
    public void modifyPassword(User user) {
        userMapper.modifyPassword(user);
    }


    @Override
    public List<User> getPageUserByUser(String phone, String username, String qq, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);//分页核心代码
        List<User> list = userMapper.getUserListByUser(phone, username, qq);
        return list;

    }

    public static HttpSession getSession() {
        HttpSession session = null;
        try {
            session = getRequest().getSession();
        } catch (Exception e) {
        }
        return session;
    }

    public static HttpServletRequest getRequest() {
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        return attrs.getRequest();
    }

    public int getUserNum(String username) {
        // TODO Auto-generated method stub
        return 0;
    }

    public InputStream getInputStream1SS() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }

    public List<User> getPageUser(int pageNum, int pageSize, String username) {
        // TODO Auto-generated method stub
        return null;
    }



    /**
     * 根据用户id删除用户
     */
    @Override
    public void deleteUserById(String ids) {
        this.userMapper.deleteByPrimaryKey(Integer.parseInt(ids));

    }

    @Override
    public List<User> getUserOrderByDate(int size) {
        PageHelper.startPage(1, size);
        List<User> list = userMapper.getUserListOrderByCreateAt();
        return list;
    }



}