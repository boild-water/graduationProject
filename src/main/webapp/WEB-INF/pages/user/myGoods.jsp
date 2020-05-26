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
    <title>我的闲置</title>
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

<%-- 物品显示部分 --%>
<div class="content whisper-content" >
    <div class="cont">
        <div class="whisper-list">

            <!-- 面包屑导航栏 -->
            <div style="margin : 5px 10px 20px 5px;">
			<span class="layui-breadcrumb">
			  <a href="<%=basePath%>user/home"><i class="layui-icon layui-icon-home"></i>首页</a>
			  <a><cite>我的闲置</cite></a>
			</span>
            </div>

            <%-- 上架物品、下架物品选项卡 --%>
            <div class="layui-tab" lay-filter="status">
                <ul class="layui-tab-title">
                    <li class="layui-this" lay-id="1">上架物品</li>
                    <li lay-id="0">下架物品</li>
                </ul>
                <div class="layui-tab-content" style="padding: 10px 0px 10px 0px">
                    <%--上架物品显示--%>
                    <div class="layui-tab-item layui-show" id="onSaleGoodsDiv">

                        <c:if test="${empty goodsExtends}">
                            <div class="no_share" style="height: 400px;width: 500px">
                                <span>没有任何物品，去发布一个吧！
                                    <a href="<%=basePath%>goods/publishGoods">去发布</a>
                                </span>
                            </div>
                        </c:if>
                        <c:if test="${!empty goodsExtends}">
                            <c:forEach items="${goodsExtends}" var="goodsExtend">
                                <%--展示物品信息的卡片--%>
                                <div class="item-box">
                                    <div class="item">
                                        <div class="whisper-title">
                                            <!-- 显示擦亮时间 -->
                                            <i class="layui-icon layui-icon-date"></i>
                                            <span class="hour" id="polishTime">${goodsExtend.goods.polishTime}</span>
                                            <!-- 擦亮 -->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <i class="layui-icon layui-icon-fire"></i>
                                            <a href="javascript:;"
                                               onclick="polishGoods(${goodsExtend.goods.id})"><span>擦亮</span></a>
                                            <!-- 编辑 -->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <svg class="icon" aria-hidden="true" style="font-size: 16px"><use xlink:href="#icon-icon-extendbianji"></use></svg>
                                            <a href="<%=basePath%>goods/editGoods/${goodsExtend.goods.id}"><span>编辑</span></a>
                                            <!-- 下架 -->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <svg class="icon" aria-hidden="true" style="font-size: 16px"><use xlink:href="#icon-icon-extendxiajia"></use></svg>
                                            <a href="javascript:;" onclick="offGoods(${goodsExtend.goods.id})"><span>下架</span></a>
                                        </div>
                                        <div style="margin: 10px 0px 10px 0px;">
                                            <!-- 填充物品描述信息 -->
                                            <span class="layui-badge layui-bg-green">物品名称</span>&nbsp;&nbsp;&nbsp;
                                            <span style="font-size: 15px;">${goodsExtend.goods.name}</span><br/>
                                        </div>
                                        <div style="margin: 10px 0px 10px 0px;">
                                            <!-- 填充物品价格 -->
                                            <span class="layui-badge layui-bg-green">物品价格</span>&nbsp;&nbsp;&nbsp;
                                            <span style="font-size: 15px;">${goodsExtend.goods.price}￥</span>
                                        </div>

                                        <div class="img-box">
                                                <%--这里填充物品图片--%>
                                            <img src="<%=basePath%>upload/goods/${goodsExtend.images[0].imgUrl}" alt=""
                                                 class="layui-upload-img" style="max-width: 296px">
                                        </div>

                                        <div style="margin: 10px 0px 10px 0px;">
                                            <!-- 填充物品描述信息 -->
                                            <span class="layui-badge layui-bg-green" style="margin: 0px 0px 5px 0px;">物品描述</span>
                                            <p style="font-size: 15px;text-indent: 2em;">${goodsExtend.goods.description}</p>
                                        </div>
                                        <div class="op-list">
                                            <!-- 显示多少浏览量 -->
                                            <p class="edit">
                                                <i class="layui-icon layui-icon-log"></i>
                                                <span>${goodsExtend.goods.pageviews}</span>
                                            </p>
                                            <!-- 展开评论-->
                                            <p class="off"><span>展开</span><i class="layui-icon layui-icon-down"></i></p>
                                        </div>
                                    </div>
                                    <div class="review-version layui-hide">
                                        <div class="form">
                                            <!-- 显示当前登录者头像 -->
                                            <img class="layui-circle" src="<%=basePath%>upload/user/${cur_user.headImgUrl}" style="width:50px;height: 50px">
                                            <!-- 物品的留言板 -->
                                            <form class="layui-form" action="#">
                                                    <%--当前物品id隐藏域--%>
                                                <input type="hidden" name="goodsId" value="${goodsExtend.goods.id}"
                                                       id="goodsId">
                                                    <%--评论内容--%>
                                                <div class="layui-form-item layui-form-text">
                                                    <div class="layui-input-block">
                                                        <textarea name="content" class="layui-textarea"></textarea>
                                                    </div>
                                                </div>
                                                <div class="layui-form-item">
                                                    <div class="layui-input-block"
                                                         style="text-align: right;">
                                                        <button lay-filter="addComment" class="layui-btn" lay-submit="">评论</button>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>

                                        <!-- 物品下的评论信息 -->
                                        <div class="list-cont" id="commentInfoContListDiv">
                                            <c:forEach items="${goodsExtend.comments}" var="comment">
                                                <div class="cont">
                                                    <div class="img">
                                                        <%--填充评论者的头像--%>
                                                        <img class="layui-circle" src="<%=basePath%>upload/user/${comment.user.headImgUrl}" style="width:50px;height: 50px">
                                                    </div>
                                                    <div class="text">
                                                            <%--填充评论者的用户名、评论时间信息--%>
                                                        <p class="tit">
                                                            <c:if test="${comment.user.id == cur_user.id}">
                                                                <span class="name" style="color: #800a1a">我</span>
                                                            </c:if>
                                                            <c:if test="${comment.user.id != cur_user.id}">
                                                                <span class="name">${comment.user.username}</span>
                                                            </c:if>
                                                            <span class="data">${comment.createAt}</span>
                                                        </p>
                                                            <%--填充评论的内容--%>
                                                        <p class="ct">${comment.content}</p>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>

                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>

                    <%--下架物品显示--%>
                    <div class="layui-tab-item" id="offGoodsDiv">
                        <c:if test="${empty goodsExtends1}">
                            <div class="no_share" style="height: 400px;width: 500px">
                                <span>没有任何物品，去发布一个吧！
                                    <a href="<%=basePath%>goods/publishGoods">去发布</a>
                                </span>
                            </div>
                        </c:if>
                        <c:if test="${!empty goodsExtends1}">
                            <c:forEach items="${goodsExtends1}" var="goodsExtend">
                                <%--展示物品信息的卡片--%>
                                <div class="item-box">
                                    <div class="item">
                                        <div class="whisper-title">
                                            <!-- 上架 -->
                                            <svg class="icon" aria-hidden="true" style="font-size: 16px"><use xlink:href="#icon-icon-extendshangjia"></use></svg>
                                            <a href="javascript:;"
                                               onclick="onSaleGoods(${goodsExtend.goods.id})"><span>上架</span></a>
                                            <!-- 编辑 -->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <svg class="icon" aria-hidden="true" style="font-size: 16px"><use xlink:href="#icon-icon-extendbianji"></use></svg>
                                            <a href="<%=basePath%>goods/editGoods/${goodsExtend.goods.id}"><span>编辑</span></a>
                                            <!-- 删除 -->&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            <i class="layui-icon layui-icon-delete"></i><a href="#"><span>删除</span></a>
                                        </div>
                                        <div style="margin: 10px 0px 10px 0px;">
                                            <!-- 填充物品描述信息 -->
                                            <span class="layui-badge layui-bg-green">物品名称</span>&nbsp;&nbsp;&nbsp;
                                            <span style="font-size: 15px;">${goodsExtend.goods.name}</span><br/>
                                        </div>
                                        <div style="margin: 10px 0px 10px 0px;">
                                            <!-- 填充物品价格 -->
                                            <span class="layui-badge layui-bg-green">物品价格</span>&nbsp;&nbsp;&nbsp;
                                            <span style="font-size: 15px;">${goodsExtend.goods.price}￥</span>
                                        </div>
                                        <div class="img-box">
                                                <%--这里填充物品图片--%>
                                            <img src="<%=basePath%>upload/goods/${goodsExtend.images[0].imgUrl}" alt=""
                                                 class="layui-upload-img" style="max-width: 296px">
                                        </div>
                                        <div style="margin: 10px 0px 10px 0px;">
                                            <!-- 填充物品描述信息 -->
                                            <span class="layui-badge layui-bg-green" style="margin: 0px 0px 5px 0px;">物品描述</span>
                                            <p style="font-size: 15px;text-indent: 2em;">${goodsExtend.goods.description}</p>
                                        </div>
                                        <div class="op-list">
                                            <!-- 显示多少浏览量 -->
                                            <p class="edit">
                                                <i class="layui-icon layui-icon-log"></i>
                                                <span>${goodsExtend.goods.pageviews}</span>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>

                </div>
            </div>
            <!-- 分页 -->
            <!-- <div id="demo" style="text-align: center;"></div> -->
        </div>
    </div>
</div>

<%--footer--%>
<%@ include file="footer.jsp"%>


<%--评论信息js模板--%>
<script type="text/html" id="commentInfo_jsTemplate">
    <div class="cont">
        <div class="img">
            <%--填充评论者的头像--%>
            <img class="layui-circle" src="<%=basePath%>upload/user/[headImgUrl]" style="width:50px;height: 50px">
        </div>
        <div class="text">
            <%--填充评论者的用户名、评论时间信息--%>
            <p class="tit">
                <span class="name" style="color: #800a1a">我</span>
                <span class="data">[createAt]</span>
            </p>
            <%--填充评论的内容--%>
            <p class="ct">[content]</p>
        </div>
    </div>
</script>


<!-- 引入jquery-->
<script type="text/javascript" src="<%=basePath%>res/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
    layui.config({
        base: '<%=basePath%>res/js/util/'
    }).use(['element','laypage','form','menu'],function(){
        element = layui.element,form = layui.form,menu = layui.menu;

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
            location.hash = 'status='+ $(this).attr('lay-id');
        });

        //监听评论按钮提交事件
        form.on('submit(addComment)', function (data) {
            var commentInfo = data.field;//json序列化表单内容
            $.ajax({
                url: "<%=basePath%>goods/addComments",
                data: commentInfo,
                type: "post",
                dataType: "json",
                success: function (result) {
                    if (result.flag) {
                        layer.msg(result.message, {
                            icon: 6,//成功的表情
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        }, function () {
                            $("textarea").val("");//清空<textarea>中缓存的评论内容，防止页面刷新之后，<textarea>中还存在值。

                            //拼接html
                            var jsTemplateHtml = $("#commentInfo_jsTemplate").html();
                            //正则替换js模板中的变量, i g m是指分别用于指定区分大小写的匹配、全局匹配和多行匹配。
                            var reg = new RegExp("\\[([^\\[\\]]*?)\\]", 'igm');
                            var html = jsTemplateHtml.replace(reg, function (node, key) {
                                return {
                                    //注意: 下面不能用el表达式填充值，因为el表达式包含'{}' 会导致脚本解析错误(括号不匹配)，不能被执行
                                    'headImgUrl': result.data.user.headImgUrl,
                                    'createAt': result.data.createAt,
                                    'content': result.data.content}[key];});

                            $("#commentInfoContListDiv").prepend(html);

                        });
                    } else {
                        layer.msg(result.message, {icon: 5});//失败的表情
                        return false;
                    }
                }
            });
            return false;//阻止表单跳转
        });
    });

    //擦亮物品
    function polishGoods(param) {
        $.ajax({
            url: "<%=basePath%>goods/polishGoods",
            data: {"goodsId": param},
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.status == 0) {
                    //本函数polishGoods 不在layui 的use函数中，所以与layui相关的api都不能使用
                    // layer.msg("擦亮成功");
                    location.reload();//刷新页面
                } else {
                    // layer.msg("擦亮失败");
                    return false;
                }
            }
        });
        return false;//阻止超链接跳转
    }

    <%--物品下架 ajax--%>
    function offGoods(param) {
        $.ajax({
            url: "<%=basePath%>goods/offGoods",
            data: {"goodsId": param},
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.status == 0) {
                    // layer.msg("物品下架成功");
                    location.reload();//刷新页面
                } else {
                    // layer.msg("物品下架失败");
                    return false;
                }
            }
        });
        return false;//阻止超链接跳转
    }

    <%--物品上架 ajax--%>
    function onSaleGoods(param) {
        $.ajax({
            url: "<%=basePath%>goods/onSaleGoods",
            data: {"goodsId": param},
            type: "post",
            dataType: "json",
            success: function (data) {
                if (data.status == 0) {
                    // layer.msg("物品上架成功");
                    location.reload();//刷新页面
                } else {
                    // layer.msg("物品上架失败");
                    return false;
                }
            }
        });
        return false;//阻止超链接跳转
    }
</script>


</body>
</html>