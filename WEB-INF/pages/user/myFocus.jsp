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
    <title>我的关注</title>
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


<div class="album-content w1000" id="layer-photos-demo" class="layer-photos-demo">

    <!-- 面包屑导航栏 -->
    <div style="margin : 50px 10px 20px 30px;">
		<span class="layui-breadcrumb">
		  <a href="<%=basePath%>user/home"><i class="layui-icon layui-icon-home"></i>首页</a>
		  <a><cite>我的关注</cite></a>
		</span>
    </div>

    <div class="img-info" style="margin-left: 100px">
        <c:if test="${focusList.size() > 0}">
            <%--这里填充物品图片--%>
            <img src="<%=basePath%>upload/goods/${focusList.get(0).goodsExtend.images[0].imgUrl}" width="550" height="400"
                 alt="">
            <div class="title">
                <!-- 关注时间 -->
                <p class="text">
                    <i class="layui-icon layui-icon-date"></i>&nbsp;&nbsp;&nbsp;&nbsp;
                        ${focusList.get(0).focusTime}
                </p>
                <!-- 物品名称 -->
                <p class="text">
                    <i class="layui-icon layui-icon-note"></i>&nbsp;&nbsp;&nbsp;&nbsp;
                        ${focusList.get(0).goodsExtend.goods.name}
                </p>
                <!-- 价格  -->
                <p class="data">
                    <i class="layui-icon layui-icon-rmb"></i>&nbsp;&nbsp;&nbsp;&nbsp;
                        ${focusList.get(0).goodsExtend.goods.price}
                </p>
                <p>
                        <%--前往物品的详情页--%>
                    <a href="<%=basePath%>goods/goodsId/${focusList.get(0).goodsExtend.goods.id}"
                       class="layui-btn layui-btn-warm layui-btn-radius">前往购买</a>
                        <%--取消关注--%>
                    <a href="<%=basePath%>user/deleteFocus/${focusList.get(0).goodsExtend.goods.id}"
                       class="layui-btn layui-btn-warm layui-btn-radius">取消关注</a>
                </p>
            </div>
        </c:if>
        <c:if test="${focusList.size() <= 0}">
            <img src="<%=basePath%>res/img/noFocus.jpg" alt="">
            <div class="title">
                <p class="briefly">您还没有关注任何物品，<a href="<%=basePath%>goods/homeGoods">去关注</a></p>
            </div>
        </c:if>
    </div>
    <div class="img-list">
        <div class="layui-fluid" style="padding:0">
            <div class="layui-row layui-col-space30 space">
                <%--用户有关注的物品--%>
                <c:if test="${focusList.size() > 0}">
                    <c:forEach items="${focusList}" var="focus">
                        <div class="layui-col-xs12 layui-col-sm4 layui-col-md4">
                            <div class="item">
                                    <%--填充物品图片--%>
                                <img src="<%=basePath%>upload/goods/${focus.goodsExtend.images[0].imgUrl}" width="200"
                                     height="160">
                                <div class="cont-text">
                                        <%--填充物品价格--%>
                                    <div class="data">
                                        <i class="layui-icon layui-icon-rmb"></i>&nbsp;&nbsp;&nbsp;&nbsp;
                                            ${focus.goodsExtend.goods.price}元
                                    </div>
                                        <%--填充物品名称--%>
                                    <p class="address">
                                        <i class="layui-icon layui-icon-note"></i>&nbsp;&nbsp;&nbsp;&nbsp;
                                            ${focus.goodsExtend.goods.name}
                                    </p>
                                    <p style="margin: 8px 0px 0px 0px;">
                                        <a href="<%=basePath%>goods/goodsId/${focus.goodsExtend.goods.id}"
                                                class="layui-btn layui-btn-warm layui-btn-sm layui-btn-radius">前往购买</a>
                                        <a href="<%=basePath%>user/deleteFocus/${focus.goodsExtend.goods.id}"
                                                class="layui-btn layui-btn-warm layui-btn-sm layui-btn-radius">取消关注</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
                <%--如果用户没有关注任何物品--%>
                <c:if test="${focusList.size() <= 0}">

                </c:if>

            </div>
        </div>
        <div id="demo"></div>
    </div>
</div>

<%--footer--%>
<%@ include file="footer.jsp"%>

<script type="text/javascript">
    layui.config({
        base: '<%=basePath%>res/js/util/'
    }).use(['element', 'laypage', 'form', 'layer', 'menu'], function () {
        element = layui.element, laypage = layui.laypage, form = layui.form, layer = layui.layer, menu = layui.menu;
        laypage.render({
            elem: 'demo'
            , count: 70 //数据总数，从服务端得到
        });
        layer.photos({
            photos: '#layer-photos-demo'
            , anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
            , tab: function (pic, layero) {
                console.log(pic, layero)
            }
        });
        menu.init();
    })
</script>

<script>

    layui.use(['form', 'layer'], function () {

        var form = layui.form, layer = layui.layer;
        var $ = layui.jquery  //取得layui中的jquery

        /*//监听提交
        form.on('submit(unFollow)', function (data) {
          console.log(data.field);
          layer.msg(data.goodsId);
          /!*$.post('http://localhost:8088/login',data.field,function(r){
            r = eval('('+r+')');
            if(r.code=='200'){
              location.href="http://www.baidu.com"
            }else{
              layer.msg(r.message);
            }
          });*!/
          return false;
        });*/
    })

</script>
</body>
</html>