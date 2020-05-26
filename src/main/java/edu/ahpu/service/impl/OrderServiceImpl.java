package edu.ahpu.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.ahpu.dao.OrderMapper;
import edu.ahpu.pojo.Order;
import edu.ahpu.pojo.OrderStatus;
import edu.ahpu.service.OrderService;
import edu.ahpu.util.DateUtil;
import edu.ahpu.util.PageHeader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderMapper orderMapper;

    //admin功能 ********************************************************


    /**
     * 查询所有订单数目
     */
    @Override
    public Integer getAllOrdersCount() {
        return orderMapper.getAllOrdersCount();
    }

    /**
     * 分页查询所有订单信息(支持条件查找)
     */
    @Override
    public PageHeader<Order> getPageOrders(PageHeader pageHeader, Order order) {
        PageHelper.startPage(pageHeader.getPage(),pageHeader.getRows());
        List<Order> ordersList = orderMapper.getOrdersList(order);
        PageInfo<Order> orderPageInfo = new PageInfo<>(ordersList);

        //封装pageHeader
        pageHeader.setTotalPages(orderPageInfo.getPages());
        pageHeader.setCount((int) orderPageInfo.getTotal());
        pageHeader.setResults(ordersList);

        return pageHeader;
    }

    /**
     * 分页查询所有订单状态(支持条件查找)
     */
    @Override
    public PageHeader<OrderStatus> getPageOrderStatus(PageHeader ph, OrderStatus orderStatus) {
        PageHelper.startPage(ph.getPage(),ph.getRows());
        List<OrderStatus> orderStatusList = orderMapper.getOrderStatusList(orderStatus);
        PageInfo<OrderStatus> pageInfo = new PageInfo<>(orderStatusList);

        //封装pageHeader
        ph.setTotalPages(pageInfo.getPages());
        ph.setCount((int) pageInfo.getTotal());
        ph.setResults(orderStatusList);

        return ph;
    }

    /**
     * 全字段更新订单信息
     */
    @Override
    public void updateOrders(Order order) {
        //使用全字段更新方式
        orderMapper.updateByPrimaryKey(order);
    }

    /**
     * 条件更新订单信息
     */
    @Override
    public void updateOrdersSelective(Order order) {
        orderMapper.updateByPrimaryKeySelective(order);
    }

    /**
     * 根据orderId获取订单信息
     */
    @Override
    public Order getOrderByOrderId(Long orderId) {
        return orderMapper.getOrderByOrderId(orderId);
    }

    /**
     * 根据orderId查询订单状态
     */
    @Override
    public OrderStatus getOrderStatusByOrderId(Long orderId) {
        return orderMapper.getOrderStatusByOrderId(orderId);
    }

    /**
     * 全字段更新订单状态
     */
    @Override
    public void updateOrderStatusAdmin(OrderStatus orderStatus) {
        orderMapper.updateOrderStatus(orderStatus);
    }

    /**
     * 条件更新订单状态
     */
    @Override
    public void updateOrderStatusSelective(OrderStatus orderStatus) {
        orderMapper.updateOrderStatusSelective(orderStatus);
    }


    //admin功能 ********************************************************







    /**
     * 添加订单状态
     */
    @Override
    public void addOrderStatus(OrderStatus orderStatus) {
        orderMapper.addOrderStatus(orderStatus);
    }

    /**
     * 生成订单
     */
    @Override
    public void addOrder(Order order) {
        orderMapper.addOrder(order);
    }




    /**
     * 更新订单状态和对应时间
     */
    @Override
    public void updateOrderStatus(OrderStatus orderStatus) {

        Byte status = orderStatus.getStatus();
        //根据订单状态，来决定到底更新哪个时间
        switch (status){
            case 2:
                //支付完成
                orderStatus.setPaymentTime(DateUtil.getNowTime());
                break;
            case 3:
                //已发货
                orderStatus.setConsignTime(DateUtil.getNowTime());
                break;
            case 4:
                //确认收货
                orderStatus.setEndTime(DateUtil.getNowTime());
                break;
            case 5:
                //取消订单
                orderStatus.setCloseTime(DateUtil.getNowTime());
                break;
            case 6:
                //申请退款时间
                orderStatus.setApplyRefundTime(DateUtil.getNowTime());
                break;
            case 7:
                //同意退款，退款到账时间
                orderStatus.setRefundTime(DateUtil.getNowTime());
                break;
        }

        orderMapper.updateOrderStatusSelective(orderStatus);
    }

    /**
     * 根据userId 查询用户所有的购买物品的订单
     */
    @Override
    public List<Order> getOrdersByUserId(Integer userId) {
        List<Order> orders = orderMapper.getOrdersByUserId(userId);
        return orders;
    }


    /**
     * 根据userId查询该用户所有已经卖出的订单
     */
    @Override
    public List<Order> getOrdersOfSellBySellerId(Integer sellerId) {

        List<Order> orderOfSell = orderMapper.getOrdersOfSellBySellerId(sellerId);
        return orderOfSell;
    }

    /**
     * 取消申请退款
     */
    @Override
    public void cancelRefund(OrderStatus orderStatus) {
        orderMapper.cancelRefund(orderStatus);
    }



















    @Override
    public void receiptByOrderNum(Integer orderNum) {
        orderMapper.receiptByOrderNum(orderNum);

    }

    /**
     * 查询所有订单的总数量
     */
    @Override
    public int getOrdersNum() {
//        List<Order> list = orderMapper.getOrdersList(order);
        return 0;
    }





    /**
     * 根据条件 分页查询订单详细信息
     */
    @Override
    public List<Order> getPageOrdersByOrders(Long orderNum, String orderInformation, Integer orderState, int pageNum,
                                             int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Order> orders = orderMapper.getPageOrdersByOrders(orderNum, orderInformation, orderState);
        return orders;
    }

    /**
     * 根据条件查询订单的总数量
     */
    @Override
    public int getOrdersNumByOrders(Long orderNum, String orderInformation, Integer orderState) {
        List<Order> orders = orderMapper.getPageOrdersByOrders(orderNum, orderInformation, orderState);
        return orders.size();
    }

    @Override
    public Order getOrdersById(int ordersId) {

        Order order = orderMapper.selectById(ordersId);
        return order;
    }

    @Override
    public void updateByPrimaryKey(Long orderId, Order order) {

//        order.setOrderId(orderId);
//        this.orderMapper.updateByPrimaryKey(order);

    }

    @Override
    public void deleteOrdersByPrimaryKeys(int id) {

        orderMapper.deleteByPrimaryKeys(id);
    }

}
