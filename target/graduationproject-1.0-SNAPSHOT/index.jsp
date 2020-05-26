<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <title>首页---欢迎您！</title>
    <link rel="icon" href="<%=basePath%>res/img/logo.svg" type="image/x-icon"/>
    <%--
        META HTTP-EQUIV="REFRESH" 实现网页自动跳转
        < META HTTP-EQUIV="REFRESH" CONTENT="x; URL=*.*">
        作用：
        x 是刷新的时间，单位是秒。*.* 是刷新的文件。 利用< META >标签实现Web的自动跳转。
        在Web上显示一段欢迎信息，隔一定秒数后，自动跳转到其他的Web页面，由此可以造成新奇的效果。
    --%>
    <META HTTP-EQUIV="Refresh" CONTENT="1;URL=<%=basePath%>goods/homeGoods">
</head>
<body>

    <%--这里可以干一些事情！！！--%>

</body>
</html>