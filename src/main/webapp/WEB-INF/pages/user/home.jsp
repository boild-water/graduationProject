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
    <title>个人中心首页</title>
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
<%@ include file="header.jsp"%>


<div class="banner" style="height: 620px">
    <div class="cont w1000">
        <div class="title">
            <h1 style="color: #ff7f21">闲置物品交易网站<br/>你，值得拥有！</h1><br>
            <h2 style="padding-top: 20px">欢迎回来，${cur_user.username}<br>上次登录：${lastLogin}</h2>
        </div>
        <div class="amount">
            <%--<p>今日物品访问量：<span class="daily-record">99+</span></p>--%>
            <p>您当前的物品访问总量：
                <span class="daily-record">
                    <c:if test="${allGoodsPageViews != null}">
                        ${allGoodsPageViews}
                    </c:if>
                    <c:if test="${allGoodsPageViews == null}">
                        0
                    </c:if>
                </span>
            </p>
        </div>
    </div>
</div>

<%--footer--%>
<%@ include file="footer.jsp"%>


</body>
</html>