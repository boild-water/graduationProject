package edu.ahpu.dao;

import java.util.List;

import edu.ahpu.pojo.Order;
import edu.ahpu.pojo.OrderStatus;
import org.apache.ibatis.annotations.Param;

public interface OrderMapper {

    //admin功能 ********************************************************

    /**
     * 查询所有订单数目
     * @return
     */
    Integer getAllOrdersCount();


    /**
     * 查询所有订单(支持条件查询)
     */
    List<Order> getOrdersList(Order order);


    /**
     * 查询所有的订单状态信息(支持条件查找)
     */
    List<OrderStatus> getOrderStatusList(OrderStatus orderStatus);

    /**
     * 条件字段更新(不足:不适合将原来有值的字段更改为没有值的情况)
     */
    void updateByPrimaryKeySelective(Order order);

    /**
     * 根据orderId获取订单信息
     */
    Order getOrderByOrderId(Long orderId);

    /**
     * 全字段更新(不足:当对象中的字段数据对应不上时，很容易给数据表中注入空值)
     */
    void updateByPrimaryKey(Order order);

    /**
     * 全字段更新order_status
     */
    void updateOrderStatus(OrderStatus orderStatus);


    //admin功能 ********************************************************











    /**
     * 添加订单状态
     */
    void addOrderStatus(OrderStatus orderStatus);

    /**
     * 生成订单
     */
    void addOrder(Order order);



    /**
     * 根据orderId查询订单状态
     */
    OrderStatus getOrderStatusByOrderId(Long orderId);

    /**
     * 条件更新订单状态及对应的时间
     */
    void updateOrderStatusSelective(OrderStatus orderStatus);

    /**
     * 查询用户的订单 买
     */
    List<Order> getOrdersByUserId(Integer userId);

    /**
     * 查询用户的订单 卖
     */
    List<Order> getOrdersOfSellBySellerId(Integer sellerId);

    /**
     * 取消申请退款
     */
    void cancelRefund(OrderStatus orderStatus);













    /**
     * 发货
     * @param orderNum
     */
    void deliverByOrderId(Long orderNum);

    /**
     * 收货
     */
    void receiptByOrderNum(Integer orderNum);



    /**
     * 根据id获取
     */
    Order selectById(int id);



    void deleteByPrimaryKeys(int id);

    List<Order> getPageOrdersByOrders(@Param("orderNum") Long orderNum, @Param("orderInformation") String orderInformation, @Param("orderState") Integer orderState);




}
