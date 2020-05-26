<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>我的订单</title>
    <link rel="icon" href="<%=basePath%>res/img/logo.svg" type="image/x-icon"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/css/main.css">
    <!--加载meta IE兼容文件-->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<%--header--%>
<%@ include file="header.jsp" %>

<%-- 物品显示部分 --%>
<div class="content whisper-content"
     style="">
    <div class="cont">
        <div class="whisper-list">

            <!-- 面包屑导航栏 -->
            <div style="margin : 5px 10px 20px 5px;">
			<span class="layui-breadcrumb">
			  <a href="<%=basePath%>user/home"><i class="layui-icon layui-icon-home"></i>首页</a>
			  <a><cite>我的订单</cite></a>
			</span>
            </div>

            <%-- 上架物品、下架物品选项卡 --%>
            <div class="layui-tab" lay-filter="status">
                <ul class="layui-tab-title">
                    <li class="layui-this" lay-id="1">我买到的</li>
                    <li lay-id="0">我卖出的</li>
                </ul>
                <div class="layui-tab-content" style="padding: 10px 0px 10px 0px">
                    <%--我买到的订单展示--%>
                    <div class="layui-tab-item layui-show" id="onSaleGoodsDiv">

                        <c:if test="${empty ordersOfBuy}">
                            <div class="no_share" style="height: 400px;width: 500px">
                                <span>
                                    你还没有购买物品的订单哦，赶快去买东西吧！
                                    <a href="<%=basePath%>goods/homeGoods">去市场逛逛</a>
                                </span>
                            </div>
                        </c:if>
                        <c:if test="${!empty ordersOfBuy}">
                            <c:forEach items="${ordersOfBuy}" var="order">
                                <%-- 需要遍历的内容 --%>
                                <div class="item-box">

                                    <%-- 展示订单简要信息 --%>
                                    <div class="item">
                                        <div class="whisper-title">

                                            <!-- 显示订单号-->
                                            <span style="color: dimgrey;">
                                                <i class="layui-icon layui-icon-form"></i>订单号:
                                                <span style="color: #007DDB;">${order.orderId}</span>
                                            </span>

                                            <!-- 显示下单时间-->
                                            <span style="color: dimgrey;margin-left: 20px;">
                                                <i class="layui-icon layui-icon-date"></i>下单时间:
                                                <span style="color: #000000;">${order.createTime}</span>
                                            </span>

                                            <!-- 显示订单状态-->
                                            <span style="float: right;">
                                                <c:if test="${order.orderStatus.status == 1}">
                                                    <span style="color: blue;">待付款</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 2}">
                                                    <span style="color:orange;">待发货</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 3}">
                                                    <span style="color:red;">待收货</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 4}">
                                                    <span style="color: green">交易完成</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 5}">
                                                    <span style="color:dimgrey;">交易关闭</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 6}">
                                                    <span style="color:yellow;">申请退款中</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 7}">
                                                    <span style="color:dimgrey;">交易关闭</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 8}">
                                                    <span style="color:black;">拒绝退款</span>
                                                </c:if>
                                            </span>

                                        </div>

                                        <!-- 订单物品名称 -->
                                        <div style="margin: 5px 5px 5px 0;">
                                            <p style="font-size: 18px;font-weight: 600;">${order.goods.name}</p>
                                        </div>

                                        <%-- 订单物品描述信息 --%>
                                        <p class="text-cont" style="text-indent:2em;">
                                            ${order.goods.description}
                                        </p>

                                        <div class="img-box">
                                            <!-- 这里填充物品图片 点击这个图片就会跳转到该物品详情页面-->
                                            <a href="#">
                                                <img src="<%=basePath%>upload/goods/${order.image.imgUrl}" width="260px" height="200px">
                                            </a>
                                        </div>

                                        <div class="op-list">
                                            <p class="off"><span>展开</span><i class="layui-icon layui-icon-down"></i></p>
                                        </div>

                                    </div><%-- 展示订单简要信息 完... --%>

                                    <%--下拉展示订单详细信息--%>
                                    <div class="review-version layui-hide">

                                        <div style="padding-left: 20px;background-color: #FFFFFF;">

                                            <div style="margin: 10px;padding-top: 10px;">
                                                <i class="layui-icon layui-icon-location"></i>
                                                <span style="padding-left: 5px;">
                                                    <!-- 订单地址信息 -->
                                                    <span style="color: #000000;font-size: 16px;">${order.address.username}&nbsp;&nbsp; ${order.address.phone}</span>

                                                    <p style="color: dimgrey;margin-left: 23px;">地址：${order.address.description}</p>
                                                </span>
                                            </div>

                                            <div style="margin: 10px;">
                                                <span style="color: dimgrey;font-size: 16px;">
                                                    订单金额：<span style="color: red;">${order.orderPrice}元</span>
                                                </span>
                                            </div>
                                            <div style="margin: 10px;">
                                                <span style="color: dimgrey;font-size: 16px;">
                                                    支付方式：
                                                    <span style="color: #000000;">
                                                        <c:if test="${order.orderType == 0}">
                                                            货到付款
                                                        </c:if>
                                                        <c:if test="${order.orderType == 1}">
                                                            在线支付
                                                        </c:if>
                                                    </span>
                                                </span>
                                            </div>
                                            <div style="margin: 10px;">
                                                <span style="color: dimgrey;font-size: 16px;">
                                                    订单状态：
                                                    <span style="color: #000000;">
                                                        <c:if test="${order.orderStatus.status == 1}">
                                                            <span style="color: blue;">待付款</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 2}">
                                                            <span style="color:orange;">待发货</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 3}">
                                                            <span style="color:red;">待收货</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 4}">
                                                            <span style="color: green">交易完成</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 5}">
                                                            <span style="color:dimgrey;">交易关闭</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 6}">
                                                            <span style="color:yellow;">申请退款中</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 7}">
                                                            <span style="color:dimgrey;">交易关闭</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 8}">
                                                            <span style="color:black;">拒绝退款</span>
                                                        </c:if>
                                                    </span>
                                                </span>
                                            </div>
                                            <%--支付时间不为空--%>
                                            <c:if test="${!empty order.orderStatus.paymentTime}">
                                                <div style="margin: 10px;">
                                                    <span style="color: dimgrey;font-size: 16px;">
                                                        支付时间：
                                                        <span style="color: #000000;">${order.orderStatus.paymentTime}</span>
                                                    </span>
                                                </div>
                                            </c:if>

                                            <%--发货时间不为空--%>
                                            <c:if test="${!empty order.orderStatus.consignTime}">
                                                <div style="margin: 10px;">
                                                    <span style="color: dimgrey;font-size: 16px;">
                                                        发货时间：
                                                        <span style="color: #000000;">${order.orderStatus.consignTime}</span>
                                                    </span>
                                                </div>
                                            </c:if>

                                            <%--申请退款时间不为空--%>
                                            <c:if test="${!empty order.orderStatus.applyRefundTime}">
                                                <div style="margin: 10px;">
                                                    <span style="color: dimgrey;font-size: 16px;">
                                                        申请退款时间：
                                                        <span style="color: #000000;">${order.orderStatus.applyRefundTime}</span>
                                                    </span>
                                                </div>
                                            </c:if>

                                            <%--申请退款时间不为空--%>
                                            <c:if test="${!empty order.orderStatus.refundTime}">
                                                <div style="margin: 10px;">
                                                    <span style="color: dimgrey;font-size: 16px;">
                                                        退款到账时间：
                                                        <span style="color: #000000;">${order.orderStatus.refundTime}</span>
                                                    </span>
                                                </div>
                                            </c:if>

                                            <%--成交时间不为空--%>
                                            <c:if test="${!empty order.orderStatus.endTime}">
                                                <div style="margin: 10px;">
                                                    <span style="color: dimgrey;font-size: 16px;">
                                                        成交时间：
                                                        <span style="color: #000000;">${order.orderStatus.endTime}</span>
                                                    </span>
                                                </div>
                                            </c:if>

                                            <%--订单关闭时间不为空--%>
                                            <c:if test="${!empty order.orderStatus.closeTime}">
                                                <div style="margin: 10px;">
                                                    <span style="color: dimgrey;font-size: 16px;">
                                                        订单关闭时间：
                                                        <span style="color: #000000;">${order.orderStatus.closeTime}</span>
                                                    </span>
                                                </div>
                                            </c:if>



                                            <div style="margin: 10px;padding-bottom: 10px;">
                                                <span style="color: dimgrey;font-size: 16px;">
                                                    订单备注：
                                                </span>
                                                <div style="padding-top: 10px;">
                                                    <textarea name="desc" class="layui-textarea" style="color: #000000;" disabled=""><c:if test="${!empty order.orderNote}">${order.orderNote}</c:if><c:if test="${empty order.orderNote}">此订单没有备注信息。</c:if></textarea>
                                                </div>
                                            </div>
                                        <!-- <div style="margin: 10px;">
                                        <span style="color: dimgrey;font-size: 16px;">
                                        订单进度：
                                        </span>
                                        <div id="steps" style="padding-top: 10px;padding-bottom: 10px;"></div>
                                        </div> -->
                                        </div>

                                        <!--待付款 已付款 已发货 确认收货 申请退款 允许退款 拒绝退款 评价？-->
                                        <div style="text-align: right;">
                                            <c:if test="${order.orderStatus.status == 1}">
                                                <a href="<%=basePath%>order/toPayPage/${order.orderId}" class="layui-btn layui-btn-primary">支付订单</a>
                                                <button onclick="cancel('${order.orderId}')" type="button" class="layui-btn layui-btn-primary">取消订单</button>
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 2 and order.orderType == 0}">
                                                <button onclick="cancel('${order.orderId}')" type="button" class="layui-btn layui-btn-primary">取消订单</button>
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 2 and order.orderType == 1}">
                                                <button onclick="applyRefund('${order.orderId}')" type="button" class="layui-btn layui-btn-primary">申请退款</button>
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 3 and order.orderType == 0}">
                                                <button onclick="receiving('${order.orderId}')" type="button" class="layui-btn layui-btn-primary">确认收货</button>
                                                <button type="button" class="layui-btn layui-btn-primary">取消订单</button>
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 3 and order.orderType == 1}">
                                                <button type="button" class="layui-btn layui-btn-primary">确认收货</button>
                                                <button onclick="applyRefund('${order.orderId}')" type="button" class="layui-btn layui-btn-primary">申请退款</button>
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 4}">
                                                <button type="button" class="layui-btn layui-btn-primary">评价</button>
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 5}">
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 6}">
                                                <button onclick="cancelRefund('${order.orderId}')" type="button" class="layui-btn layui-btn-primary">取消申请</button>
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 7}">
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 8}">
                                                <button onclick="applyRefund('${order.orderId}')" type="button" class="layui-btn layui-btn-primary">再次申请退款</button>
                                            </c:if>
                                        </div>
                                    </div><%--下拉展示订单详细信息 完...--%>


                                </div>

                            </c:forEach>
                        </c:if>

                    </div>


                    <%--我卖出的订单展示--%>
                    <div class="layui-tab-item" id="offGoodsDiv">

                        <c:if test="${empty ordersOfSell}">
                            <div class="no_share" style="height: 400px;width: 500px">
                                <span>
                                    还没有人购买你的东西哦，去擦亮物品或者调低价格吧！
                                    <a href="<%=basePath%>user/allGoods">我的闲置</a>
                                </span>
                            </div>
                        </c:if>
                        <c:if test="${!empty ordersOfSell}">
                            <c:forEach items="${ordersOfSell}" var="order">
                                <%-- 需要遍历的内容 --%>
                                <div class="item-box">

                                        <%-- 展示订单简要信息 --%>
                                    <div class="item">
                                        <div class="whisper-title">

                                            <!-- 显示订单号-->
                                            <span style="color: dimgrey;">
                                                <i class="layui-icon layui-icon-form"></i>订单号:
                                                <span style="color: #007DDB;">${order.orderId}</span>
                                            </span>

                                            <!-- 显示下单时间-->
                                            <span style="color: dimgrey;margin-left: 20px;">
                                                <i class="layui-icon layui-icon-date"></i>下单时间:
                                                <span style="color: #000000;">${order.createTime}</span>
                                            </span>

                                            <!-- 显示订单状态-->
                                            <span style="float: right;">
                                                <c:if test="${order.orderStatus.status == 1}">
                                                    <span style="color: blue;">待付款</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 2}">
                                                    <span style="color:orange;">待发货</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 3}">
                                                    <span style="color:red;">待收货</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 4}">
                                                    <span style="color: green">交易完成</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 5}">
                                                    <span style="color:dimgrey;">交易关闭</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 6}">
                                                    <span style="color:yellow;">申请退款中</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 7}">
                                                    <span style="color:dimgrey;">交易关闭</span>
                                                </c:if>
                                                <c:if test="${order.orderStatus.status == 8}">
                                                    <span style="color:black;">拒绝退款</span>
                                                </c:if>
                                            </span>

                                        </div>

                                        <!-- 订单物品名称 -->
                                        <div style="margin: 5px 5px 5px 0;">
                                            <p style="font-size: 18px;font-weight: 600;">${order.goods.name}</p>
                                        </div>

                                            <%-- 订单物品描述信息 --%>
                                        <p class="text-cont" style="text-indent:2em;">
                                                ${order.goods.description}
                                        </p>

                                        <div class="img-box">
                                            <!-- 这里填充物品图片 点击这个图片就会跳转到该物品详情页面-->
                                            <a href="#">
                                                <img src="<%=basePath%>upload/goods/${order.image.imgUrl}" width="260px" height="200px">
                                            </a>
                                        </div>

                                        <div class="op-list">
                                            <p class="off"><span>展开</span><i class="layui-icon layui-icon-down"></i></p>
                                        </div>

                                    </div><%-- 展示订单简要信息 完... --%>

                                        <%--下拉展示订单详细信息--%>
                                    <div class="review-version layui-hide">

                                        <div style="padding-left: 20px;background-color: #FFFFFF;">

                                            <div style="margin: 10px;padding-top: 10px;">
                                                <i class="layui-icon layui-icon-location"></i>
                                                <span style="padding-left: 5px;">
                                                    <!-- 订单地址信息 -->
                                                    <span style="color: #000000;font-size: 16px;">${order.address.username}&nbsp;&nbsp; ${order.address.phone}</span>

                                                    <p style="color: dimgrey;margin-left: 23px;">地址：${order.address.description}</p>
                                                </span>
                                            </div>

                                            <div style="margin: 10px;">
                                                <span style="color: dimgrey;font-size: 16px;">
                                                    订单金额：<span style="color: red;">${order.orderPrice}元</span>
                                                </span>
                                            </div>
                                            <div style="margin: 10px;">
                                                <span style="color: dimgrey;font-size: 16px;">
                                                    支付方式：
                                                    <span style="color: #000000;">
                                                        <c:if test="${order.orderType == 0}">
                                                            货到付款
                                                        </c:if>
                                                        <c:if test="${order.orderType == 1}">
                                                            在线支付
                                                        </c:if>
                                                    </span>
                                                </span>
                                            </div>
                                            <div style="margin: 10px;">
                                                <span style="color: dimgrey;font-size: 16px;">
                                                    订单状态：
                                                    <span style="color: #000000;">
                                                        <c:if test="${order.orderStatus.status == 1}">
                                                            <span style="color: blue;">待付款</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 2}">
                                                            <span style="color:orange;">待发货</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 3}">
                                                            <span style="color:red;">待收货</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 4}">
                                                            <span style="color: green">交易完成</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 5}">
                                                            <span style="color:dimgrey;">交易关闭</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 6}">
                                                            <span style="color:yellow;">申请退款中</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 7}">
                                                            <span style="color:dimgrey;">交易关闭</span>
                                                        </c:if>
                                                        <c:if test="${order.orderStatus.status == 8}">
                                                            <span style="color:black;">拒绝退款</span>
                                                        </c:if>
                                                    </span>
                                                </span>
                                            </div>
                                                <%--支付时间不为空--%>
                                            <c:if test="${!empty order.orderStatus.paymentTime}">
                                                <div style="margin: 10px;">
                                                    <span style="color: dimgrey;font-size: 16px;">
                                                        支付时间：
                                                        <span style="color: #000000;">${order.orderStatus.paymentTime}</span>
                                                    </span>
                                                </div>
                                            </c:if>

                                                <%--发货时间不为空--%>
                                            <c:if test="${!empty order.orderStatus.consignTime}">
                                                <div style="margin: 10px;">
                                                    <span style="color: dimgrey;font-size: 16px;">
                                                        发货时间：
                                                        <span style="color: #000000;">${order.orderStatus.consignTime}</span>
                                                    </span>
                                                </div>
                                            </c:if>

                                                <%--申请退款时间不为空--%>
                                            <c:if test="${!empty order.orderStatus.applyRefundTime}">
                                                <div style="margin: 10px;">
                                                    <span style="color: dimgrey;font-size: 16px;">
                                                        申请退款时间：
                                                        <span style="color: #000000;">${order.orderStatus.applyRefundTime}</span>
                                                    </span>
                                                </div>
                                            </c:if>

                                                <%--申请退款时间不为空--%>
                                            <c:if test="${!empty order.orderStatus.refundTime}">
                                                <div style="margin: 10px;">
                                                    <span style="color: dimgrey;font-size: 16px;">
                                                        退款到账时间：
                                                        <span style="color: #000000;">${order.orderStatus.refundTime}</span>
                                                    </span>
                                                </div>
                                            </c:if>

                                                <%--成交时间不为空--%>
                                            <c:if test="${!empty order.orderStatus.endTime}">
                                                <div style="margin: 10px;">
                                                    <span style="color: dimgrey;font-size: 16px;">
                                                        成交时间：
                                                        <span style="color: #000000;">${order.orderStatus.endTime}</span>
                                                    </span>
                                                </div>
                                            </c:if>

                                                <%--订单关闭时间不为空--%>
                                            <c:if test="${!empty order.orderStatus.closeTime}">
                                                <div style="margin: 10px;">
                                                    <span style="color: dimgrey;font-size: 16px;">
                                                        订单关闭时间：
                                                        <span style="color: #000000;">${order.orderStatus.closeTime}</span>
                                                    </span>
                                                </div>
                                            </c:if>



                                            <div style="margin: 10px;padding-bottom: 10px;">
                                                <span style="color: dimgrey;font-size: 16px;">
                                                    订单备注：
                                                </span>
                                                <div style="padding-top: 10px;">
                                                    <textarea name="desc" class="layui-textarea" style="color: #000000;" disabled=""><c:if test="${!empty order.orderNote}">${order.orderNote}</c:if><c:if test="${empty order.orderNote}">此订单没有备注信息。</c:if></textarea>
                                                </div>
                                            </div>
                                            <!-- <div style="margin: 10px;">
                                            <span style="color: dimgrey;font-size: 16px;">
                                            订单进度：
                                            </span>
                                            <div id="steps" style="padding-top: 10px;padding-bottom: 10px;"></div>
                                            </div> -->
                                        </div>

                                        <!--待付款 已付款 已发货 确认收货 申请退款 允许退款 拒绝退款 评价？-->
                                        <div style="text-align: right;">
                                            <c:if test="${order.orderStatus.status == 1}">
                                                <button type="button" class="layui-btn layui-btn-primary">不想卖了</button>
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 2}">
                                                <button onclick="deliver('${order.orderId}')" type="button" class="layui-btn layui-btn-primary">发货</button>
                                                <button onclick="notSell('${order.orderId}')" type="button" class="layui-btn layui-btn-primary">不想卖了</button>
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 3}">
                                                <button onclick="notSell('${order.orderId}')" type="button" class="layui-btn layui-btn-primary">不想卖了</button>
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 4}">
                                                <button type="button" class="layui-btn layui-btn-primary">评价</button>
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 5}">
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 6}">
                                                <button onclick="refuseRefund('${order.orderId}')" type="button" class="layui-btn layui-btn-primary">拒绝退款</button>
                                                <button onclick="refund('${order.orderId}')" type="button" class="layui-btn layui-btn-primary">同意退款</button>
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 7}">
                                            </c:if>
                                            <c:if test="${order.orderStatus.status == 8}">
                                            </c:if>
                                        </div>
                                    </div><%--下拉展示订单详细信息 完...--%>


                                </div>

                            </c:forEach>
                        </c:if>

                    </div>

                </div>

            </div>

        </div>
    </div>
</div>

<%--footer--%>
<%@ include file="footer.jsp" %>


<!-- 引入jquery-->
<script type="text/javascript" src="<%=basePath%>res/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
    layui.config({
        base: '<%=basePath%>res/js/util/'
    }).use(['element', 'laypage', 'form', 'menu'], function () {
        element = layui.element, form = layui.form, menu = layui.menu;

        menu.init();
        menu.off();
        menu.submit()
    })
</script>
<script>

    layui.use(['element', 'layer', 'form'], function () {
        var element = layui.element, layer = layui.layer, form = layui.form;

        //Hash地址的定位
        var layid = location.hash.replace(/^#status=/, '');
        element.tabChange('status', layid);

        //监听上架物品、下架物品选项卡切换事件
        element.on('tab(status)', function (data) {//选型卡tab切换事件
            console.log(data.index);//tab下标索引   0 1 2 ...
            console.log($(this).attr('lay-id')); //lay-id 每个tab唯一表示的id
            location.hash = 'status=' + $(this).attr('lay-id');
        });

    });

    //发货
    function deliver(param) {
        layer.msg('确定已经发货了吗？', {
            time: 0 //不自动关闭
            ,btn: ['已经发货', '尚未发货']
            ,yes: function(index){
                layer.close(index);//关闭提示框
                layer.load();//开启加载层-默认风格
                //ajax 执行发货操作
                $.ajax({
                    url: "<%=basePath%>order/deliver",
                    data: {"orderId": param},
                    type: "get",
                    dataType: "json",
                    success: function (result) {
                        if (result.flag) {
                            layer.closeAll('loading');//关闭加载层
                            location.reload();//刷新页面
                        } else {
                            layer.closeAll('loading');//关闭加载层
                        }
                    }
                });

            },no:function (index) {
                layui.close(index);
            }
        });
    }

    //确认收货
    function receiving(param) {
        layer.msg('确定已经收到物品了吗？', {
            time: 0 //不自动关闭
            ,btn: ['已经收到', '尚未收到']
            ,yes: function(index){
                layer.close(index);//关闭提示框
                layer.load();//开启加载层-默认风格
                //ajax 执行发货操作
                $.ajax({
                    url: "<%=basePath%>order/receiving",
                    data: {"orderId": param},
                    type: "get",
                    dataType: "json",
                    success: function (result) {
                        if (result.flag) {
                            layer.closeAll('loading');//关闭加载层
                            location.reload();//刷新页面
                        } else {
                            layer.closeAll('loading');//关闭加载层
                        }
                    }
                });

            },no:function (index) {
                layui.close(index);
            }
        });
    }

    //取消订单
    function cancel(param){
        layer.msg('确定取消订单吗？', {
            time: 0 //不自动关闭
            ,btn: ['取消订单', '暂不取消']
            ,yes: function(index){
                layer.close(index);//关闭提示框
                layer.load();//开启加载层-默认风格
                //ajax 执行发货操作
                $.ajax({
                    url: "<%=basePath%>order/cancel",
                    data: {"orderId": param},
                    type: "get",
                    dataType: "json",
                    success: function (result) {
                        if (result.flag) {
                            layer.closeAll('loading');//关闭加载层
                            location.reload();//刷新页面
                        } else {
                            layer.closeAll('loading');//关闭加载层
                        }
                    }
                });

            },no:function (index) {
                layui.close(index);
            }
        });
    }

    //申请退款
    function applyRefund(param) {
        layer.msg('确定申请退款吗？', {
            time: 0 //不自动关闭
            ,btn: ['申请退款', '取消']
            ,yes: function(index){
                layer.close(index);//关闭提示框
                layer.load();//开启加载层-默认风格
                //ajax 执行发货操作
                $.ajax({
                    url: "<%=basePath%>order/applyRefund",
                    data: {"orderId": param},
                    type: "get",
                    dataType: "json",
                    success: function (result) {
                        if (result.flag) {
                            layer.closeAll('loading');//关闭加载层
                            location.reload();//刷新页面
                        } else {
                            layer.closeAll('loading');//关闭加载层
                        }
                    }
                });

            },no:function (index) {
                layui.close(index);
            }
        });
    }

    //同意退款
    function refund(param){
        layer.msg('确定同意买家的退款申请吗？', {
            time: 0 //不自动关闭
            ,btn: ['同意', '暂不处理']
            ,yes: function(index){
                layer.close(index);//关闭提示框
                layer.load();//开启加载层-默认风格
                //ajax 执行发货操作
                $.ajax({
                    url: "<%=basePath%>order/refund",
                    data: {"orderId": param},
                    type: "get",
                    dataType: "json",
                    success: function (result) {
                        if (result.flag) {
                            layer.closeAll('loading');//关闭加载层
                            location.reload();//刷新页面
                        } else {
                            layer.closeAll('loading');//关闭加载层
                        }
                    }
                });

            },no:function (index) {
                layui.close(index);
            }
        });
    }

    //不想卖了
    function notSell(param){
        layer.msg('确定不想卖了吗？', {
            time: 0 //不自动关闭
            ,btn: ['确定', '取消']
            ,yes: function(index){
                layer.close(index);//关闭提示框
                layer.load();//开启加载层-默认风格
                //ajax 执行发货操作
                $.ajax({
                    url: "<%=basePath%>order/notSell",
                    data: {"orderId": param},
                    type: "get",
                    dataType: "json",
                    success: function (result) {
                        if (result.flag) {
                            layer.closeAll('loading');//关闭加载层
                            location.reload();//刷新页面
                        } else {
                            layer.closeAll('loading');//关闭加载层
                        }
                    }
                });

            },no:function (index) {
                layui.close(index);
            }
        });
    }

    //取消退款申请
    function cancelRefund(param){
        layer.msg('确定取消退款申请吗？', {
            time: 0 //不自动关闭
            ,btn: ['是', '否']
            ,yes: function(index){
                layer.close(index);//关闭提示框
                layer.load();//开启加载层-默认风格
                //ajax 执行发货操作
                $.ajax({
                    url: "<%=basePath%>order/cancelRefund",
                    data: {"orderId": param},
                    type: "get",
                    dataType: "json",
                    success: function (result) {
                        if (result.flag) {
                            layer.closeAll('loading');//关闭加载层
                            location.reload();//刷新页面
                        } else {
                            layer.closeAll('loading');//关闭加载层
                        }
                    }
                });

            },no:function (index) {
                layui.close(index);
            }
        });
    }

    //卖家拒绝买家退款申请
    function refuseRefund(param){
        layer.msg('确定拒绝该买家的退款申请吗？', {
            time: 0 //不自动关闭
            ,btn: ['是', '否']
            ,yes: function(index){
                layer.close(index);//关闭提示框
                layer.load();//开启加载层-默认风格
                //ajax 执行发货操作
                $.ajax({
                    url: "<%=basePath%>order/refuseRefund",
                    data: {"orderId": param},
                    type: "get",
                    dataType: "json",
                    success: function (result) {
                        if (result.flag) {
                            layer.closeAll('loading');//关闭加载层
                            location.reload();//刷新页面
                        } else {
                            layer.closeAll('loading');//关闭加载层
                        }
                    }
                });

            },no:function (index) {
                layui.close(index);
            }
        });
    }

</script>


</body>
</html>