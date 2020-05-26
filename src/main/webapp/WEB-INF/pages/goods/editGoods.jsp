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
    <title>编辑物品</title>
    <link rel="icon" href="<%=basePath%>res/img/logo.svg" type="image/x-icon"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/css/main.css">
    <!--加载meta IE兼容文件-->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <!-- 设置一下laydate日历组件的大小-->
    <style>
        /* 设置laydate日历组件的大小 */
        #mycalendar .layui-laydate-main {
            width: 360px;
        }

        #mycalendar .layui-laydate-content td,
        #mycalendar .layui-laydate-content th {
            width: 60px;
        }

        /*设置猜你喜欢 轮播展示物品图片大小自适应 */
        .myimg {
            width: auto;
            height: auto;
            max-width: 100%;
            max-height: 100%;
        }

    </style>
</head>
<body>

<%--header--%>
<%@ include file="../user/header.jsp"%>

<!-- 使用栅栏布局的方式，设计发布闲置物品表单与左侧信息栏 -->
<div class="layui-fluid" style="background: url(<%=basePath%>res/img/bg3.jpg) no-repeat;background-size:100% 100%;">

    <div class="layui-row layui-col-space20">
        <!-- 左侧信息栏占据 3/12的空间-->
        <div class="layui-col-md3" style="margin-left: 50px">

            <!-- 添加一个日历显示 -->
            <div class="site-demo-laydate">
                <div class="layui-inline" id="mycalendar"></div>
            </div>

            <fieldset class="layui-elem-field layui-field-title">
                <legend>猜你喜欢</legend>
            </fieldset>
            <div class="layui-carousel" id="test10">
                <div carousel-item="">
                    <c:if test="${! empty goodsExtends}">
                        <%--遍历推荐物品--%>
                        <c:forEach items="${goodsExtends}" var="goodsExtend">
                            <div>
                                <a href="<%=basePath%>goods/goodsId/${goodsExtend.goods.id}">
                                    <img style="width: 360px;height: 250px" class="myImg"
                                         src="<%=basePath%>upload/goods/${goodsExtend.images[0].imgUrl}">
                                </a>
                            </div>
                        </c:forEach>
                    </c:if>

                    <c:if test="${empty goodsExtends}">
                        <div><img class="myImg" src="<%=basePath%>upload/0583cb1e-6acd-46da-bebc-4a9f1d6c3ac7.jpg"></div>
                    </c:if>
                </div>
            </div>

            <fieldset class="layui-elem-field layui-field-title">
                <legend>求购信息</legend>
            </fieldset>
            <div class="layui-carousel" id="test1" lay-filter="test1">
                <div carousel-item>
                    <c:forEach items="${buyInfos}" var="buyInfo">
                        <div>
                            <p>
                            <div style="padding: 10px 10px">
                                    <%--头像--%>
                                <img src="<%=basePath%>upload/user/${buyInfo.user.headImgUrl}" class="layui-nav-img">
                                    <%--用户名--%>
                                <span>${buyInfo.user.username}</span>:<br>
                            </div>
                            <div style="padding: 0px 10px 30px 10px;">
                                    <%--求购信息内容--%>
                                <p style="text-indent: 2em;">${buyInfo.context}</p>

                            </div>
                                <%--求购信息发布时间--%>
                            <span style="position:absolute;bottom:10px;right:10px">${buyInfo.createAt}</span>
                            </p>
                        </div>
                    </c:forEach>
                </div>
            </div>

        </div>

        <!-- 发布闲置物品表单 占据8/12的空间-->
        <div class="layui-col-md8" style="margin-left: 20px">
            <!-- 面包屑导航栏 -->
            <div style="margin : 5px 10px 20px 15px;">
                <span class="layui-breadcrumb">
                    <a href="<%=basePath%>user/home"><i class="layui-icon layui-icon-home"></i>首页</a>
                    <a><cite>发布闲置</cite></a>
                </span>
            </div>
            <!-- 编辑物品的表单，需要填充值 -->
            <div style="margin : 50px 10px 15px 10px;">
                <form class="layui-form" action="<%=basePath%>goods/editGoodsSubmit" method="post">

                    <div class="layui-form-item">
                        <%--物品id的隐藏域--%>
                        <input type="hidden" name="id" value="${goodsExtend.goods.id}">
                        <label class="layui-form-label">物品名称</label>
                        <div class="layui-input-inline">
                            <input type="text" name="name" lay-verify="name" autocomplete="off"
                                   value="${goodsExtend.goods.name}" class="layui-input">
                        </div>
                        <!-- 提示该项是否为必填项 -->
                        <div class="layui-form-mid layui-word-aux"><span style="font-size: 18px;color: red;">*</span></div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">物品分类</label>
                            <div class="layui-input-inline" style="width: 150px">
                                <%--如何在页面刚出现的时候，就回显正确的物品种类？1.使用<c:if> 2.jquery--%>
                                <%--这里使用jquery来解决这个问题--%>
                                <select name="categoryId" id="categoryIdSelected" lay-verify="required">
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.id}">${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <!-- 提示该项是否为必填项 -->
                            <div class="layui-form-mid layui-word-aux"><span style="font-size: 18px;color: red;">*</span></div>
                        </div>
                    </div>

                    <div class="layui-form-item layui-form-text">
                        <label class="layui-form-label">物品描述</label>
                        <div class="layui-input-block">
                            <textarea name="description" class="layui-textarea">${goodsExtend.goods.description}</textarea>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">物品原价</label>
                            <div class="layui-input-inline" style="width: 100px;">
                                <input type="text" name="realPrice" lay-verify="realPrice" value="${goodsExtend.goods.realPrice}"
                                       autocomplete="off" class="layui-input">
                            </div>
                            <label class="layui-form-label">物品现价</label>
                            <div class="layui-input-inline" style="width: 100px;">
                                <input type="text" name="price" lay-verify="price" value="${goodsExtend.goods.price}" autocomplete="off"
                                       class="layui-input">
                            </div>
                            <!-- 提示该项是否为必填项 -->
                            <div class="layui-form-mid layui-word-aux"><span style="font-size: 18px;color: red;">*</span></div>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">是否可讲价</label>
                        <div class="layui-input-block">
                            <c:if test="${goodsExtend.goods.isBargain == 0}">
                                <input type="checkbox" checked="" name="is_bargain" lay-skin="switch"
                                       lay-filter="bargainSwitch"
                                       lay-text="是|否">
                            </c:if>
                            <c:if test="${goodsExtend.goods.isBargain != 0}">
                                <input type="checkbox" name="is_bargain" lay-skin="switch"
                                       lay-filter="bargainSwitch"
                                       lay-text="是|否">
                            </c:if>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">是否上架</label>
                        <div class="layui-input-block">
                            <c:if test="${goodsExtend.goods.status == 0}">
                                <input type="checkbox" name="onSale" lay-skin="switch" lay-filter="onSaleSwitch"
                                       lay-text="是|否">
                            </c:if>
                            <c:if test="${goodsExtend.goods.status != 0}">
                                <input type="checkbox" checked="" name="onSale" lay-skin="switch"
                                       lay-filter="onSaleSwitch"
                                       lay-text="是|否">
                            </c:if>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <label class="layui-form-label">物品地址</label>
                        <div class="layui-input-inline" style="width: 160px">
                            <select name="addressDescUtil.campusName" id="campusNameSelected" lay-verify="required">
                                <option value="">请选择学校</option>
                                <option value="安徽工程大学">安徽工程大学</option>
                                <option value="安徽大学">安徽大学</option>
                                <option value="合肥工业大学">合肥工业大学</option>
                            </select>
                        </div>
                        <div class="layui-input-inline" style="width: 160px" >
                            <select name="addressDescUtil.dormitoryBuilding" id="dormitoryBuildingSelected" lay-verify="required">
                                <option value="">请选择宿舍楼</option>
                                <option value="男生宿舍12栋">男生宿舍12栋</option>
                                <option value="男生宿舍13栋">男生宿舍13栋</option>
                                <option value="女生宿舍6栋">女生宿舍6栋</option>
                                <option value="女生宿舍8栋">女生宿舍8栋</option>
                            </select>
                        </div>
                        <div class="layui-input-inline" style="width: 120px;">
                            <%-- 宿舍房间号 --%>
                            <input class="layui-input" type="text" lay-verify="dormitoryNum" name="addressDescUtil.dormitoryNum" id="" placeholder="请输入房间号"
                                   value="${goodsExtend.goods.addressDescUtil.dormitoryNum}"/>
                        </div>
                        <!-- <div class="layui-form-mid layui-word-aux">此处只是演示联动排版，并未做联动交互</div> -->
                        <!-- 提示该项是否为必填项 -->
                        <div class="layui-form-mid layui-word-aux"><span style="font-size: 18px;color: red;">*</span></div>
                    </div>

                    <!-- 物品图片上传框-->
                    <div class="layui-form-item" style="text-align: center;">
                        <!-- 支持多图片文件上传-->
                        <div class="layui-upload">
                            <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;">
                                <svg class="icon" aria-hidden="true" style="font-size: 30px"><use xlink:href="#icon-icon-extendtupian"></use></svg>
                                <div class="layui-upload-list" id="goodsPreviewDiv">
                                    <img src="<%=basePath%>upload/goods/${goodsExtend.images[0].imgUrl}" alt=""
                                         class="layui-upload-img" style="max-width: 196px">
                                </div>
                                <%--图片uuid地址信息隐藏域--%>
                                <input name="imgUrl" value="${goodsExtend.images[0].imgUrl}" type="hidden">
                            </blockquote>
                            <button type="button" class="layui-btn layui-btn-primary layui-btn-radius" id="selectGoodsImg">选择图片</button>
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button type="button" class="layui-btn layui-btn-danger" lay-submit="" lay-filter="editBtn" style="float: right">保存修改</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

    </div>

</div>


<!-- footer -->
<%@ include file="../user/footer.jsp"%>


<!-- 引入jquery-->
<script type="text/javascript" src="<%=basePath%>res/js/jquery-3.4.1.js"></script>
<%--<!-- 引入的layui模块-->
<script src="<%=basePath%>res/layui/layui.js"></script>--%>
<!-- 暂时不清楚 -->
<script>
    layui.config({
        base: '<%=basePath%>res/js/util/'
    }).use(['element', 'laypage', 'jquery', 'menu'], function () {
        element = layui.element, laypage = layui.laypage, $ = layui.$, menu = layui.menu;
        laypage.render({
            elem: 'demo'
            , count: 70 //数据总数，从服务端得到
        });
        menu.init();
    })
</script>

<!-- form、laydate、layedit模块-->
<script>
    layui.use(['form', 'layedit','layer', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;

        // form.render();
        //表单校验
        form.verify({
            name: function(value){
                if($.trim(value) == ''){
                    return '物品名称不能为空！';
                }
            },
            realPrice: function(value){
                if(!new RegExp("^(([1-9][0-9]*)|(([0]\\.\\d{1,2}|[1-9][0-9]*\\.\\d{1,2})))$").test(value)){
                    return '物品原价不正确！';
                }
            },
            price: function(value){
                if(!new RegExp("^(([1-9][0-9]*)|(([0]\\.\\d{1,2}|[1-9][0-9]*\\.\\d{1,2})))$").test(value)){
                    return '物品现价不正确！';
                }
            },
            dormitoryNum: function(value){
                if($.trim(value) == ''){
                    return '请完善宿舍房间号信息！';
                }
            }
        });


        //左侧日历组件设置
        laydate.render({
            elem: '#mycalendar'
            , position: 'static' //直接嵌套显示
            , calendar: true //显示公历节日
            , btns: ['now'],//只有一个现在按钮
            theme: '#ffaa7f'//自定义颜色
        });

        //监听“是否可讲价”开关切换事件
        form.on('switch(bargainSwitch)', function (data) {
            layer.msg('已设置' + (this.checked ? '可讲价' : '不可讲价'), {
                offset: '6px'
            });
        });
        //监听“是否上架”开关切换事件
        form.on('switch(onSaleSwitch)', function (data) {
            layer.tips('温馨提示：物品选择不上架，其他买家搜索不到哦', data.othis)
        });

        //监听"保存修改"按钮提交
        form.on('submit(editBtn)', function (data) {

            //判断是否上传了物品图片信息，给出提示
            if ($.trim(data.field.imgUrl) == ''){
                var confirmTips = layer.confirm('您确定不上传物品图片，就发布物品吗？', {
                    btn: ['确定','我再想想'] //按钮
                }, function(){
                    layer.close(confirmTips);
                    //继续执行下面的ajax方法
                }, function(){
                    layer.close(confirmTips);
                    return false;
                });
            }

            $.ajax({
                url: '<%=basePath%>goods/editGoodsSubmit',
                data: data.field,
                type:"post",
                dataType:"json",
                success:function(result){
                    if(result.flag){
                        layer.msg(result.message, {
                            icon: 6,//成功的表情
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            location.href = "<%=basePath%>user/allGoods"
                        });
                    }else {
                        layer.msg("更新物品信息失败，请稍后再试！",{icon: 5});//失败的表情
                    }
                },
                error: function( data1, status, error ) {
                    console.log(data1);
                    console.log(status);
                    console.log(error);
                }
            });

            return false;
        });

    });
</script>

<!-- 文件上传模块-->
<script>
    layui.use('upload', function () {
        var $ = layui.jquery
            , upload = layui.upload;

        //多图片上传
        var uploadInst = upload.render({
            elem: '#selectGoodsImg'
            , url: '<%=basePath%>goods/uploadFile' //改成您自己的上传接口
            , multiple: true
            , before: function (obj) {//提交服务器之前
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    //首先清空goodsPreviewDiv(这样只适合上传物品的一张图片，做上传多物品图片功能再看看如何修改)
                    $('#goodsPreviewDiv').empty();
                    //然后再将新图片添加上去
                    $('#goodsPreviewDiv').append('<img src="' + result + '" alt="' + file.name + '" class="layui-upload-img"' + ' style="max-width: 196px">')
                });
            }
            , done: function (res) {//提交服务器完成后
                //上传失败
                if (res.status > 0) {
                    return layer.msg('上传图片失败');
                } else {
                    $("input[name='imgUrl']").val(res.fileUrl);
                    return layer.msg('上传图片成功', {icon: 1});
                }
            }
            , error: function () {//失败状态，并实现重传

                layer.confirm('图片上传异常，是否重传？', {//询问框
                    btn: ['重传', '取消'] //按钮
                }, function () {
                    uploadInst.upload();//执行重传操作
                }, function () {
                    $("#goodsPreviewDiv").empty();//清空所有的预览div中的所有图片
                });
            }
        });

    });
</script>

<%--引入layui轮播模块--%>
<script>
    layui.use(['carousel', 'form'], function () {
        var carousel = layui.carousel
            , form = layui.form;

        //求购信息轮播
        carousel.render({
            elem: '#test1'
            , width: '360px'
            , height: '150px'
            , arrow: 'hover',
            anim: 'updown',
            indicator: 'none'
            , interval: 5000
            , autoplay: true
        });


        //猜你喜欢轮播
        carousel.render({
            elem: '#test10'
            , width: '360px'
            , height: '250px'
            , interval: 5000
        });

    });

</script>

<script>

    /**
     * 页面表单中<select>标签数据回显
     * 1.将下面代码放到页面最后，不要放到layui.use(){}函数内，
     * 2.需要额外引入jquery文件，否则页面解析不了jquery的"$"符号
     */

    //页面回显物品种类<select><option></option></select>
    $("#categoryIdSelected option[value='${goodsExtend.goods.categoryId}']").attr("selected", "selected");
    //页面回显学校名称种类<select><option></option></select>
    $("#campusNameSelected option[value='${goodsExtend.goods.addressDescUtil.campusName}']").attr("selected", "selected");
    //页面回显宿舍楼层名称<select><option></option></select>
    $("#dormitoryBuildingSelected option[value='${goodsExtend.goods.addressDescUtil.dormitoryBuilding}']").attr("selected", "selected");
</script>

</body>
</html>