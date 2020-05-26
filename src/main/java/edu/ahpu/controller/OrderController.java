package edu.ahpu.controller;

import edu.ahpu.pojo.Goods;
import edu.ahpu.pojo.Order;
import edu.ahpu.pojo.OrderStatus;
import edu.ahpu.pojo.User;
import edu.ahpu.service.GoodsService;
import edu.ahpu.service.OrderService;
import edu.ahpu.util.DateUtil;
import edu.ahpu.util.IdWorker;
import edu.ahpu.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/order")
public class OrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private GoodsService goodsService;

    /**
     * 提交订单 最好选择重定向到某页面，如果选择转发到某页面，用户刷新提交后的页面将会导致 表单重复提交！
     */
    @RequestMapping(value = "/addOrder",method = RequestMethod.POST)
    public String addOrder(HttpServletRequest request, Order order) {

        //前端传入的order的有addressId orderType goodsId orderNote
        //设置订单id，生成一个可读性较高、唯一、长度一致的订单号，使用雪花算法(snowflake)
        IdWorker worker = new IdWorker(1, 1, 1);
        order.setOrderId(worker.nextId());
        //设置userId
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        order.setUserId(cur_user.getId());
        //设置orderPrice，需要重新查询数据库获得
        Goods goods = goodsService.getGoodsById(order.getGoodsId());
        order.setOrderPrice(goods.getPrice());
        //设置sellerId
        order.setSellerId(goods.getUserId());
        //设置订单创建时间
        order.setCreateTime(DateUtil.getNowTime());

        //封装一个用于记录订单状态的OrderStatus对象
        OrderStatus orderStatus = new OrderStatus();
        orderStatus.setOrderId(order.getOrderId());
        orderStatus.setCreateTime(order.getCreateTime());//要保持两张表中的时间一样

        //判断orderType
        if (order.getOrderType() == 0){

            //货到付款 由于货到付款不需要在线支付，所以订单的状态被设置为  2 -- 待发货状态
            orderStatus.setStatus(new Byte("2"));

        } else {
            //在线支付 设置订单的状态为 1 -- 待付款
            orderStatus.setStatus(new Byte("1"));
        }

        //添加订单状态信息
        orderService.addOrderStatus(orderStatus);

        //生成订单
        orderService.addOrder(order);

        //同时还要将该物品的status更新为0，即下架该物品
        goods.setStatus(0);
        goodsService.updateGoodsByGoodsId(goods);

        return "redirect:/order/toPayPage/"+order.getOrderId();
    }

    /**
     * 为了让提交订单后重定向到订单付款页面后，能回显订单数据，所以专门做了下面的方法
     */
    @RequestMapping("/toPayPage/{orderId}")
    public ModelAndView toPayPage(@PathVariable("orderId") Long orderId){

        //根据orderId查询订单以及订单状态
        Order order = orderService.getOrderByOrderId(orderId);

        ModelAndView mv = new ModelAndView();
        mv.addObject("order",order);

        mv.setViewName("/user/pay");
        return mv;
    }

    /**
     * 支付完成
     * 由于目前无法使用支付网关接口，支付状态无法判断，这里通过手动的方式，点击“已完成支付” 即订单支付完成
     * 更新订单状态
     */
    @ResponseBody
    @RequestMapping(value = "/payment",method = RequestMethod.GET)
    public Result paySuccess(Long orderId){

        //实际上此处还要判断，该订单是否已经被支付... 如果已经被支付，那么Result.build(false,"该订单已经被支付",null);

        //更新订单状态(status和对应的时间)
        OrderStatus orderStatus = new OrderStatus();
        orderStatus.setOrderId(orderId);
        orderStatus.setStatus(new Byte("2"));
        orderService.updateOrderStatus(orderStatus);

        return Result.build(true,"支付成功！",null);
    }

    @RequestMapping("/toPaySuccessPage/{orderId}")
    public ModelAndView toPaySuccessPage(@PathVariable("orderId") Long orderId){

        //根据orderId查询订单以及订单状态
        Order order = orderService.getOrderByOrderId(orderId);
        OrderStatus orderStatus = orderService.getOrderStatusByOrderId(orderId);
        order.setOrderStatus(orderStatus);

        ModelAndView mv = new ModelAndView();
        mv.addObject("order",order);

        mv.setViewName("/user/paySuccess");
        return mv;
    }

    /**
     * 发货 根据订单号
     */
    @ResponseBody
    @RequestMapping(value = "/deliver",method = RequestMethod.GET)
    public Result deliver(Long orderId) {

        //更新订单状态(status和对应的时间)
        OrderStatus orderStatus = new OrderStatus();
        orderStatus.setOrderId(orderId);
        orderStatus.setStatus(new Byte("3"));
        orderService.updateOrderStatus(orderStatus);

        return Result.build(true,"发货成功！",null);
    }

    /**
     * 收货 根据订单号
     */
    @ResponseBody
    @RequestMapping(value = "/receiving",method = RequestMethod.GET)
    public Result receiving(Long orderId) {

        //更新订单状态(status和对应的时间)
        OrderStatus orderStatus = new OrderStatus();
        orderStatus.setOrderId(orderId);
        orderStatus.setStatus(new Byte("4"));
        orderService.updateOrderStatus(orderStatus);

        return Result.build(true,"收货完成！",null);
    }

    /**
     * 取消订单 根据订单号 取消订单有以下几种情况，需要考虑
     *  1.未付款取消订单
     *      如果未付款取消订单，直接将订单状态设置为关闭即可。
     *  2.已付款取消订单
     *      如果已付款取消订单，还要判断是买家申请退款还是
     */
    @ResponseBody
    @RequestMapping(value = "/cancel",method = RequestMethod.GET)
    public Result cancel(Long orderId) {

        //更新订单状态(status和对应的时间)
        OrderStatus orderStatus = new OrderStatus();
        orderStatus.setOrderId(orderId);
        orderStatus.setStatus(new Byte("5"));
        orderService.updateOrderStatus(orderStatus);

        return Result.build(true,"取消成功！",null);
    }

    /**
     * 申请退款 根据订单号
     */
    @ResponseBody
    @RequestMapping(value = "/applyRefund",method = RequestMethod.GET)
    public Result applyRefund(Long orderId) {

        //更新订单状态(status和对应的时间)
        OrderStatus orderStatus = new OrderStatus();
        orderStatus.setOrderId(orderId);
        orderStatus.setStatus(new Byte("6"));
        orderService.updateOrderStatus(orderStatus);

        return Result.build(true,"申请退款！",null);
    }

    /**
     * 同意退款申请 根据订单号
     */
    @ResponseBody
    @RequestMapping(value = "/refund",method = RequestMethod.GET)
    public Result refund(Long orderId) {

        //更新订单状态(status和对应的时间)
        OrderStatus orderStatus = new OrderStatus();
        orderStatus.setOrderId(orderId);
        orderStatus.setStatus(new Byte("7"));
        orderService.updateOrderStatus(orderStatus);

        //退款完成后，还要关闭订单
        orderStatus.setStatus(new Byte("5"));
        orderService.updateOrderStatus(orderStatus);

        return Result.build(true,"允许退款成功！",null);
    }

    /**
     * 取消退款申请 回到申请退款前的状态
     */
    @ResponseBody
    @RequestMapping(value = "/cancelRefund",method = RequestMethod.GET)
    public Result cancelRefund(Long orderId) {

        //根据orderId查询订单状态
        OrderStatus orderStatus = orderService.getOrderStatusByOrderId(orderId);
        //判断该订单申请退款前的状态
        if (orderStatus.getConsignTime() != null && orderStatus.getConsignTime().length() > 0) {
            orderStatus.setStatus(new Byte("3"));
        } else {
            orderStatus.setStatus(new Byte("2"));
        }
        //取消退款申请，将状态设置为申请退款前状态，并且将申请退款时间设为null
        orderService.cancelRefund(orderStatus);

        return Result.build(true,"取消申请成功！",null);
    }

    /**
     * 卖家拒绝买家退款申请
     */
    @ResponseBody
    @RequestMapping(value = "/refuseRefund",method = RequestMethod.GET)
    public Result refuseRefund(Long orderId) {

        //更新订单状态(status和对应的时间)
        OrderStatus orderStatus = new OrderStatus();
        orderStatus.setOrderId(orderId);
        orderStatus.setStatus(new Byte("8"));
        orderService.updateOrderStatus(orderStatus);

        return Result.build(true,"已拒绝退款申请！",null);
    }

    /**
     * 不想卖了 根据订单号 有以下几种情况：
     *  首先判断该订单是在线支付还是货到付款
     *      1.如果是在线支付，还要判断买家是否已经付款
     *          a.如果买家已经付款，那么要先进行退款操作，然后再关闭订单。
     *          b.如果买家没有付款，仅仅提交了订单，那么直接关闭订单
     *      2.如果是货到付款，那么直接关闭订单
     */
    @ResponseBody
    @RequestMapping(value = "/notSell",method = RequestMethod.GET)
    public Result notSell(Long orderId) {

        Order order = orderService.getOrderByOrderId(orderId);
        OrderStatus orderStatus = orderService.getOrderStatusByOrderId(orderId);

        //首先判断该订单的支付方式
        if (order.getOrderType() == 1) {
            //说明是在线支付，还要判断买家是否已经付款
            if (orderStatus.getStatus() == 2 || orderStatus.getStatus() == 3) {
                //买家已付款，卖家已发货两种状态下，卖家均可以进行“不想卖了”操作
                orderStatus.setStatus(new Byte("7"));//首先进行退款操作
                orderService.updateOrderStatus(orderStatus);
            }
        }

        orderStatus.setStatus(new Byte("5"));
        orderService.updateOrderStatus(orderStatus);

        return Result.build(true,"允许退款成功！",null);
    }



















}
