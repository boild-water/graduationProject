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
    <title>求购信息</title>
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

<!-- 面包屑导航栏 -->
<div style="margin : 50px 10px 20px 250px;">
		<span class="layui-breadcrumb">
		  <a href="<%=basePath%>user/home"><i class="layui-icon layui-icon-home"></i>首页</a>
		  <a><cite>求购信息</cite></a>
		</span>
</div>

<div class="content whisper-content leacots-content">

    <div class="cont w1000">
        <div class="whisper-list">
            <div class="item-box">
                <div class="review-version">
                    <div class="form-box">
                        <img class="banner-img" src="<%=basePath%>res/img/qiugou.jpg">
                        <div class="form">
                            <form class="layui-form" action="">
                                <div class="layui-form-item layui-form-text">
                                    <div class="layui-input-block">
                                        <textarea name="context" placeholder="此处填写求购信息" id="context"
                                                  class="layui-textarea" lay-verify="context"></textarea>
                                    </div>
                                </div>
                                <div class="layui-form-item">
                                    <div class="layui-input-block" style="text-align: right;">
                                        <button class="layui-btn" lay-submit="" lay-filter="publishBuyinfo">发布</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="volume">
                        全部求购信息 <%--<span>10</span>--%>
                    </div>
                    <div class="list-cont">
                        <%--<c:forEach items="${buyinfos}" var="buyinfo">
                            <div class="cont">
                                <div class="img">
                                        &lt;%&ndash;填充用户头像&ndash;%&gt;
                                    <img src="<%=basePath%>res/img/header.png" alt="">
                                </div>
                                <div class="text">
                                    <p class="tit">
                                            &lt;%&ndash;填充用户名&ndash;%&gt;
                                        <span class="name">
                                            &lt;%&ndash;判断是否是自己发布的，如果是自己发布的则填充“我”&ndash;%&gt;
                                            <c:if test="${buyinfo.user.username == cur_user.username}">我</c:if>
                                            <c:if test="${buyinfo.user.username != cur_user.username}">${buyinfo.user.username}</c:if>

                                        </span>
                                            &lt;%&ndash;填充求购信息发布的时间&ndash;%&gt;
                                        <span class="data">${buyinfo.createAt}</span>
                                    </p>
                                        &lt;%&ndash;填充求购信息内容&ndash;%&gt;
                                    <p class="ct">${buyinfo.context}</p>
                                </div>
                            </div>
                        </c:forEach>--%>
                    </div>
                </div>
            </div>
        </div>

        <%--分页--%>
        <div id="demo" style="text-align: center;"></div>
    </div>
</div>

<%--footer--%>
<%@ include file="footer.jsp"%>


<!-- 引入jquery-->
<script type="text/javascript" src="<%=basePath%>res/js/jquery-3.4.1.js"></script>
<script>
    layui.config({
        base: '<%=basePath%>res/js/util/'
    }).use(['element', 'laypage', 'form', 'layer','jquery','menu'], function () {
        var element = layui.element,
            laypage = layui.laypage,
            form = layui.form,
            menu = layui.menu,
            $ = layui.jquery,
            layer = layui.layer;

        menu.init();
        menu.submit();
    })
</script>

<%--ajax+js模板+laypage分页插件 实现数据物理分页--%>
<script>
    $(function () {
        //页面加载完成后，获取第一页内容
        loadPage(0,5);
    });
    
    function loadPage(curr,limit) {
        $.ajax({
            url: "<%=basePath%>user/buyinfoPage",
            data: {"page":curr,"rows":limit},
            type: "get",
            dataType: "json",
            success: function (result) {
                if (result.flag){//表示查询成功
                    var pageHeader = result.data;//获取分页信息
                    var buyinfos = pageHeader.results;//获取分页信息中的数据
                    $(".list-cont").html(myconts(buyinfos));//展示数据

                    //渲染layui分页条
                    //获取一个laypage实例
                    layui.use('laypage', function () {
                        var laypage = layui.laypage;
                        //渲染分页
                        laypage.render({
                            elem: 'demo',//分页栏显示在哪个元素上的id
                            count: pageHeader.count,//总数目，从服务器端获取
                            curr: curr,//当前页码
                            limit:limit,//每页多少条
                            limits: [5,10,15],//可以手动调整每页多少条
                            layout: ['count', 'prev', 'page', 'next', 'limit', 'skip'],
                            jump: function (obj, first) {
                                //obj包含了当前分页的所有参数，比如：
                                // console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                                // console.log(obj.limit); //得到每页显示的条数
                                if(!first) {
                                    //如果不是第一次渲染分页栏，就调用下面的分页函数，没有这行代码就会出现死循环
                                    loadPage(obj.curr,obj.limit);
                                }
                            },
                            /* 用于修改上一页下一页的显示样式
                            prev: '<',
                            next: '>',
                            */
                            theme: '#f9c357'
                        })
                    });

                }
            }
        });
    }

    //遍历buyinfos生成html
    function myconts(buyinfos) {
        var mycontsHtml = "";
        for (var i = 0;i < buyinfos.length;i++){
            //这里使用js模板的方式填充内容，而不使用字符串拼接。
            var reg = new RegExp("\\[([^\\[\\]]*?)\\]", 'igm'); //i g m是指分别用于指定区分大小写的匹配、全局匹配和多行匹配。
            var html = $("#mycont").html();//获取js模板中的html代码
            //将mycontHtml中一些需要填充的变量通过正则表达式替换
            var mycontHtml = html.replace(reg, function (node, key) {
                return {
                    'headImgUrl':buyinfos[i].user.headImgUrl,
                    'username': buyinfos[i].user.username,
                    'createAt': buyinfos[i].createAt,
                    'context': buyinfos[i].context}[key]; });
            mycontsHtml += mycontHtml;//拼串
        }

        return mycontsHtml;
    }

</script>

<script>
    layui.use(['layedit','layer','jquery','form'],function () {
        var layedit = layui.layedit,
            layer = layui.layer,
            form = layui.form,
            $ = layui.jquery;

        //自定义验证求购信息表单是否被输入内容
        form.verify({
            context: function (value) {
                if ($.trim(value) == '') {
                    return '求购信息不能为空！';
                }
            }
        });

        //监听发布求购信息的按钮提交
        form.on('submit(publishBuyinfo)', function (data) {
            // layer.alert(JSON.stringify(data.field), {
            //     title: '最终的提交信息'
            // });
            // return false;

            if ($("#context").val().length <= 0){
                layer.msg("求购信息不能为空！");
                return false;
            } else {
                $.ajax({
                    url: "<%=basePath%>user/buyinfo",
                    data: data.field,
                    type: "post",
                    dataType: "json",
                    success: function (json) {
                        layer.msg("发布求购信息成功！", {
                            icon: 6,//成功的表情
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        }, function () {
                            $("textarea").val("");//清空<textarea>中缓存的评论内容，防止页面刷新之后，<textarea>中还存在值。

                            /* 下面的做法想的太简单了，没有考虑到很多情况，比如分页啊、如果当前页面求购信息小于rows呢？
                            //这里使用js模板的方式填充内容，而不使用字符串拼接。
                            var reg = new RegExp("\\[([^\\[\\]]*?)\\]", 'igm'); //i g m是指分别用于指定区分大小写的匹配、全局匹配和多行匹配。
                            var html = $("#mycont").html();//获取js模板中的html代码
                            //将mycontHtml中一些需要填充的变量通过正则表达式替换
                            var mycontHtml = html.replace(reg, function (node, key) {
                                return {
                                'headImgUrl':"",
                                'username': '我','createAt': json.createAt,
                                'context': json.context}[key]; });
                            //然后再将mycont拼装到<div class="list-cont">中
                            $(".list-cont").prepend(mycontHtml);//追加在头部
                            //然后移除本页<div class="list-cont">中最后一个<div class="cont">元素
                            $(".list-cont .cont").last().remove();
                            */

                            //直接刷新本页面
                            location.reload();
                        });
                    }
                });
            }

            return false;
        });
    })
</script>

<%--js模板--%>
<script type="text/html" id="mycont">
    <div class="cont">
        <div class="img">
            <%--填充用户头像--%>
            <img src="<%=basePath%>upload/user/[headImgUrl]" class="layui-nav-img" alt="" style="width: 50px;height: 50px">
        </div>
        <div class="text">
            <p class="tit">
                <%--填充用户名--%>
                <span class="name">[username]</span>
                <%--填充求购信息发布的时间--%>
                <span class="data">[createAt]</span>
            </p>
            <%--填充求购信息内容--%>
            <p class="ct">[context]</p>
        </div>
    </div>
</script>


</body>
</html>