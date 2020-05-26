package edu.ahpu.service;

import java.util.List;

import edu.ahpu.pojo.Order;
import edu.ahpu.pojo.OrderStatus;
import edu.ahpu.util.PageHeader;

public interface OrderService {

	//admin功能 ********************************************************

	/**
	 * 查询所有的订单数目
	 * @return
	 */
	Integer getAllOrdersCount();

	/**
	 * 分页查询所有订单信息(支持条件查找)
	 */
	PageHeader<Order> getPageOrders(PageHeader pageHeader, Order order);

	/**
	 * 分页查询所有订单状态(支持条件查找)
	 */
	PageHeader<OrderStatus> getPageOrderStatus(PageHeader ph, OrderStatus orderStatus);

	/**
	 * 全字段更新订单信息
	 */
	void updateOrders(Order order);

	/**
	 * 条件更新订单信息
	 */
	void updateOrdersSelective(Order order);

	/**
	 * 根据orderId获取订单信息
	 */
	Order getOrderByOrderId(Long orderId);

	/**
	 * 根据orderId查询订单状态
	 */
	OrderStatus getOrderStatusByOrderId(Long orderId);

	/**
	 * 全字段更新订单信息
	 */
	void updateOrderStatusAdmin(OrderStatus orderStatus);

	/**
	 * 条件更新订单状态信息
	 */
	void updateOrderStatusSelective(OrderStatus orderStatus);

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
	 * 更新订单的状态，以及时间
	 */
	void updateOrderStatus(OrderStatus orderStatus);


	/**
	 * 根据userId 查询用户所有的购买物品的订单
	 */
	List<Order> getOrdersByUserId(Integer userId);

	/**
	 * 根据userId查询该用户所有已经卖出的订单
	 */
	List<Order> getOrdersOfSellBySellerId(Integer sellerId);

	/**
	 * 取消申请退款
	 */
	void cancelRefund(OrderStatus orderStatus);

























	void receiptByOrderNum(Integer orderNum);

	int getOrdersNumByOrders(Long orderNum, String orderInformation, Integer orderState);



	Order getOrdersById(int ordersId);

	void updateByPrimaryKey(Long id, Order order);

	void deleteOrdersByPrimaryKeys(int parseInt);

	List<Order> getPageOrdersByOrders(Long orderNum, String orderInformation, Integer orderState, int pageNum,
											 int pageSize);

	int getOrdersNum();




}
