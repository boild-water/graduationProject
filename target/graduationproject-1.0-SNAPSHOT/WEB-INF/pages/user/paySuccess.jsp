<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html class="fly-html-layui fly-html-store">
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>支付成功</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="icon" href="<%=basePath%>res/img/logo.svg" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/font_24081_qs69ykjbea.css">
    <link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/layui.css">
    <link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/global.css" charset="utf-8">
    <link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/global_1.css" charset="utf-8">
    <link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/store.css" charset="utf-8">
    <link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/myclass.css" charset="utf-8">
    <![endif]-->

    <!-- 进度条需要的css样式 -->
    <style>
        #steps {
        }

        .step-item {
            display: inline-block;
            line-height: 26px;
            position: relative;
            background: #ffffff;
        }

        .step-item-tail {
            width: 100%;
            padding: 0 10px;
            position: absolute;
            left: 0;
            top: 13px;
        }

        .step-item-tail i {
            display: inline-block;
            width: 100%;
            height: 5px;
            vertical-align: top;
            background: #c2c2c2;
            position: relative;
        }

        .step-item-tail-done {
            background: green !important;
        }

        .step-item-head {
            position: relative;
            display: inline-block;
            height: 26px;
            width: 26px;
            text-align: center;
            vertical-align: top;
            color: green;
            border: 1px solid #009688;
            border-radius: 50%;
            background: #ffffff;
        }

        .step-item-head.step-item-head-active {
            background: green;
            color: #ffffff;
        }

        .step-item-main {
            background: #ffffff;
            display: block;
            position: relative;
        }

        .step-item-main-title {
            font-weight: bolder;
            color: #555555;
        }

        .step-item-main-desc {
            color: #aaaaaa;
        }
    </style>

</head>

<body>
<%--header--%>
<div class="layui-header header header-store" style="background-color: #55aa7f;">
    <div class="layui-container">
        <a class="logo" href="<%=basePath%>goods/homeGoods">
            <img src="<%=basePath%>layui_fly/static/picture/logo1.png" alt="闲置物品交易网站">
        </a>
        <div class="layui-form component" lay-filter="LAY-site-header-component"></div>

        <ul class="layui-nav">

            <li class="layui-nav-item fly-layui-user" style="margin: auto;" id="FLY-notice">

                <c:if test="${cur_user == null}">
                    <!-- 用户尚未登录 -->
                    <a class="fly-nav-avatar" href="#" id="LAY_header_avatar">
                        <img src="<%=basePath%>layui_fly/static/images/visitor.svg">
                        <cite class="layui-hide-xs">游客</cite>
                        <span class="layui-nav-more"></span>
                    </a>
                    <dl class="layui-nav-child layui-anim layui-anim-upbit">
                        <dd><a href="<%=basePath%>user/login">登录</a></dd>
                        <dd><a href="<%=basePath%>user/register">注册</a></dd>
                    </dl>
                </c:if>
                <c:if test="${cur_user != null}">
                    <!-- 用户已经登录 -->
                    <a class="fly-nav-avatar" href="#" id="LAY_header_avatar">
                        <img src="<%=basePath%>upload/user/${cur_user.headImgUrl}">
                        <cite class="layui-hide-xs">${cur_user.username}</cite> <span class="layui-nav-more"></span>
                    </a>
                    <dl class="layui-nav-child layui-anim layui-anim-upbit" >
                        <dd><a href="<%=basePath%>user/home">个人中心</a></dd>
                        <dd><a href="<%=basePath%>goods/publishGoods">我要发布</a></dd>
                        <dd><a href="<%=basePath%>user/myOrders">我的订单</a></dd> <hr>
                        <dd><a href="<%=basePath%>user/logout" style="text-align: center;">退出登录</a></dd>
                    </dl>
                </c:if>
            </li>
        </ul>
    </div>
</div>

<!-- 订单支付页面主体内容 -->
<div style="background-color: #fff;">

    <div style="padding-left: 200px;height: 600px;width: 1000px;">
        <div style="padding:20px 100px;">
            <span style="color: green;">
                <i class="layui-icon layui-icon-ok" style="font-weight: 600;font-size: 40px;"></i>
            </span>
            <span style="color: green;font-size: 20px;">恭喜您，订单支付成功！</span>
        </div>
        <div style="padding:20px 130px;">
            <span><a href="<%=basePath%>user/myOrders" class="layui-btn layui-btn-primary">查看我的订单</a></span>
            <span>
                    <a class="layui-btn layui-btn-primary" href="<%=basePath%>">
                        <i class="layui-icon layui-icon-home"></i><span style="color: red;">返回市场</span>
                    </a>
                </span>
        </div>
        <div style="padding:10px 0;background-color: #ffffff;margin-left: 130px;box-shadow: 0 6px 32px rgba(0,0,0,.13);width: 1000px;">
                <%--填充订单号--%>
            <p style="margin:10px;">订单号：<span style="color: #5555ff;">${order.orderId}</span></p>
                <%--填充订单金额--%>
            <p style="margin:10px;">在线支付：<span style="color: red;font-weight: 600;">${order.orderPrice}元</span></p>
            <p style="margin:10px;">订单状态：待发货</p>
            <p style="margin:10px;">送货时间：<span style="color: red;font-weight: 600;">预计2天内送达</span></p>

            <div style="margin: 10px;width: 800px;">
                <div style="padding-top: 10px;padding-bottom: 10px;">订单进度：</div>

                <div id="steps"></div>
            </div>
        </div>
        <div style="padding:20px 130px;">
            <p style="margin: 10px;font-size: 16px;color: gray;">
                <i class="layui-icon layui-icon-notice" style="color: orange;"></i>
                重要提醒：本平台不会以任何形式要求您点击任何网址链接进行退款操作，请谨防网络诈骗。
            </p>
        </div>
    </div>

</div>

<%--footer--%>
<div class="fly-footer" style="margin-top: 0px">
    <p>
        <a href="">闲置物品交易网站</a> 2020 &copy;
        <span>boildwater</span>
    </p>
    <p>
        <a>友情链接</a>
        <a href="https://www.layui.com/doc/" target="_blank">Layui</a>
        <a href="https://jquery.com/" target="_blank">JQuery</a>
        <a href="https://www.iconfont.cn/" target="_blank">阿里巴巴矢量图标库</a>
        <a href="https://xiuxiu.web.meitu.com/"target="_blank">美图秀秀</a>
    </p>
    <div class="fly-union">
        <p style="display: block; margin-bottom: 10px;">
            <span>感谢以上平台及网站提供的技术支持</span>
        </p>
    </div>
</div>




<!-- 引入jquery-->
<script type="text/javascript" src="<%=basePath%>res/js/jquery-3.4.1.js"></script>
<script src="<%=basePath%>layui_fly/static/layui/layui.js"></script>
<script>
    //引入自定义的fly模块
    layui.config({
        base: '<%=basePath%>layui_fly/static/layui/lay/modules/'
    }).use('fly');

</script>
<%--分步进度条--%>
<script>
    layui.config({
        base: '<%=basePath%>res/extends/'
    });
    layui.use('steps', function () {
        var steps = layui.steps;

        var data = [{
            'title': "提交订单",
            "desc": "${order.createTime}"
        },
        {
            'title': "支付完成",
            "desc": "${order.orderStatus.paymentTime}"
        },
        {
            'title': "已发货",
            "desc": "？"
        },
        {
            'title': "确认收货",
            "desc": "？"
        }
        ];

        steps.make(data, '#steps', 2);
    });
</script>

<script>
    layui.use(['form'],function () {
        var form = layui.form;

        console.log("${order.orderId}");
        console.log("${order.orderStatus.paymentTime}");

        //监听""按钮点击
        form.on('submit(paySuccess)', function (data) {

        });
    })
</script>

</body>
</html>

