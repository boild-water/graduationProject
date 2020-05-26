<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html class="fly-html-layui fly-html-store">
<head>
    <meta charset="utf-8">
    <title>核对订单</title>
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
    <style>
        .orderinfo {
            border: 1px solid #e7e7e7;
            margin: 5px 100px 5px 100px;
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


<div style="height: 850px;width: 1300px;padding-left: 150px;">
<div style="margin: 20px 100px 5px 100px;">
    <span style="font-size: 16px;color: grey">填写并核对订单信息</span>
</div>
<div class="orderinfo" style="background-color: #f9f9f9">
    <form class="layui-form" action="<%=basePath%>order/addOrder" id="orderInfo" method="post">
        <div class="layui-form-item">
            <div style="margin: 20px 30px 10px 0px;">
                <label style="padding: 9px 15px 9px 15px;"><b>收货人信息</b></label><br>
                <a href="javascript:openModak();" style="float: right;">
                    <i class="layui-icon layui-icon-add-circle"></i><span>新增地址</span>
                </a>
            </div>
            <div style="margin: 20px 30px 10px 50px;">
                <!-- 此处遍历当前用户所有的收件人地址信息 -->
                <c:forEach items="${addresses}" var="address">

                    <div name="addressDetail" id="addressId${address.id}">

                        <div>
                            <%--收件人姓名--%>
                            <input type="radio" name="addressId" value="${address.id}" title="${address.username}"
                                <c:if test="${address.defaultAddr == 0}">checked</c:if> >
                        </div>
                        <div style="padding-right: 10px;margin: 6px 10px 0 0;height: 28px" name="detail">
                                <%--收件人地址，手机号码--%>
                            <span style="margin-right: 20px;margin-left: 5px">
                                    ${address.addressUtil.campusName} &nbsp;
                                    ${address.addressUtil.dormitoryBuilding} &nbsp;
                                    ${address.addressUtil.dormitoryNum} &nbsp;
                                    ${address.phone}
                            </span>&nbsp;&nbsp;&nbsp;
                                <%--是否是默认地址--%>
                            <c:if test="${address.defaultAddr == 0}">
                                <span class="layui-badge layui-bg-gray">默认地址</span>
                                <a href="javascript:toEdit(${address.id});"><span style="margin-right: 100px;float: right;">编辑</span></a>
                            </c:if>
                            <c:if test="${address.defaultAddr == 1}">
                                <a href="javascript:deleteAddr(${address.id});"><span style="margin-right: 100px;float: right;">删除</span></a>
                                <a href="javascript:toEdit(${address.id});"><span style="margin-right: 20px;float: right;">编辑</span></a>
                                <a href="javascript:setDefaultAddr(${address.id});"><span style="margin-right: 20px;float: right;">设为默认</span></a>
                            </c:if>
                        </div>
                    </div>

                </c:forEach>
            </div>
        </div>
        <hr>

        <div class="layui-form-item">
            <label style="padding: 9px 15px 9px 15px;"><b>支付方式</b></label><br>
            <div style="margin: 20px 30px 10px 50px;">
                <!-- 支持货到付款、在线支付两种方式 -->
                <input type="checkbox" name="orderType" value="0" title="货到付款" checked>
                <input type="checkbox" name="orderType" value="1" title="在线支付">
            </div>
        </div>
        <hr>

        <div class="layui-form-item">
            <label style="padding: 9px 15px 9px 15px;"><b>货物清单</b></label><br>

            <div style="margin: 20px 30px 10px 50px;background-color: #f3f3f3;width: 1020px;height: 200px;display: flex;justify-content: space-between;align-items: center;">
                <!-- 订单物品信息 -->
                <input type="hidden" name="goodsId" value="${goodsExtend.goods.id}">
                <div style="padding-left: 20px;">
                    <img src="<%=basePath%>upload/goods/${goodsExtend.images[0].imgUrl}" width="150" height="120">
                </div>
                <div>
                    <span>${goodsExtend.goods.name}</span>
                    <span>&nbsp;&nbsp;&nbsp;&nbsp;x1</span>
                </div>
                <div>
                    <input type="hidden" name="orderPrice" value="${goodsExtend.goods.price}">
                    <span style="color: red;padding-right: 100px;">合计：￥${goodsExtend.goods.price}0</span>
                </div>
            </div>
        </div>
        <hr>

        <div class="layui-form-item">
            <label style="padding: 9px 15px 9px 15px;"><b>备注信息</b></label><br>
            <div style="margin: 20px 30px 10px 50px;">
                <!-- 订单备注信息 -->
                <textarea name="orderNote" placeholder="此处输入备注信息" class="layui-textarea"></textarea>
            </div>
        </div>

    </form>
    <!-- 为了页面的美观，所以将该提交按钮放置在了form标签外 -->
    <div style="float: right;margin: 20px 0px 0px;">
        <button class="layui-btn layui-btn-danger" lay-submit="" lay-filter="summitOrder">提交订单</button>
    </div>

</div>
</div>

<%--footer--%>
<div class="fly-footer">
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



<!-- 新增地址模态框 -->
<div id="motaikuang" style="display: none;">
    <form class="layui-form" action="" id="motaiForm">

        <!-- 收货人姓名 -->
        <div class="layui-form-item" style="margin-top: 10px;">
            <label class="layui-form-label">收货人</label>
            <div class="layui-input-inline" style="width: 150px;">
                <input class="layui-input" lay-verify="textVerify" type="text" name="username" placeholder="请输入收货人姓名"/>
            </div>
            <!-- 提示该项是否为必填项 -->
            <div class="layui-form-mid layui-word-aux"><span style="font-size: 18px;color: red;">*</span></div>
        </div>
        <!-- 收货详细地址 -->
        <div class="layui-form-item">
            <label class="layui-form-label">请选择地址</label>
            <div class="layui-input-inline" style="width: 150px;">
                <select name="campusName">
                    <option value="" selected="">请选择学校</option>
                    <option value="安徽工程大学">安徽工程大学</option>
                    <option value="安徽大学">安徽大学</option>
                    <option value="合肥工业大学">合肥工业大学</option>
                </select>
            </div>
            <div class="layui-input-inline" style="width: 150px;">
                <select name="dormitoryBuilding">
                    <option value="">请选择宿舍楼</option>
                    <option value="男生宿舍12栋">男生宿舍12栋</option>
                    <option value="男生宿舍13栋">男生宿舍13栋</option>
                    <option value="女生宿舍6栋">女生宿舍6栋</option>
                    <option value="女生宿舍8栋">女生宿舍8栋</option>
                </select>
            </div>
            <div class="layui-input-inline" style="width: 120px;">
                <input class="layui-input" type="text" name="dormitoryNum" id="" placeholder="请输入房间号"/>
            </div>
            <!-- 提示该项是否为必填项 -->
            <div class="layui-form-mid layui-word-aux"><span style="font-size: 18px;color: red;">*</span></div>
        </div>

        <!-- 手机号码 -->
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">手机号码</label>
                <div class="layui-input-inline">
                    <input type="tel" name="phone" lay-verify="required|phone" autocomplete="off" class="layui-input">
                </div>
                <!-- 提示该项是否为必填项 -->
                <div class="layui-form-mid layui-word-aux"><span style="font-size: 18px;color: red;">*</span></div>
            </div>
        </div>

        <!-- 是否设置为默认地址 -->
        <div class="layui-form-item">
            <label class="layui-form-label">默认地址</label>
            <div class="layui-input-block">
                <input type="checkbox" name="isDefault" lay-skin="switch" lay-text="是|否">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn layui-btn-danger" lay-submit="" lay-filter="addAddr">保存地址</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>

    </form>
</div>
<%-- 编辑地址模态框 --%>
<div id="editMotaikuang" style="display: none;">
    <form class="layui-form" action="" id="editMotaiForm" lay-filter="editMotaikuang">
        <%--地址id隐藏域--%>
        <input type="hidden" id="addressId" name="id">
        <!-- 收货人姓名 -->
        <div class="layui-form-item" style="margin-top: 10px;">
            <label class="layui-form-label">收货人</label>
            <div class="layui-input-inline" style="width: 150px;">
                <input class="layui-input" lay-verify="textVerify" id="addrUsername" type="text" name="username"/>
            </div>
            <!-- 提示该项是否为必填项 -->
            <div class="layui-form-mid layui-word-aux"><span style="font-size: 18px;color: red;">*</span></div>
        </div>
        <!-- 收货详细地址 -->
        <div class="layui-form-item">
            <label class="layui-form-label">请选择地址</label>
            <div class="layui-input-inline" style="width: 150px;">
                <select name="campusName" id="campusName">
                    <option value="" selected="">请选择学校</option>
                    <option value="安徽工程大学">安徽工程大学</option>
                    <option value="安徽大学">安徽大学</option>
                    <option value="合肥工业大学">合肥工业大学</option>
                </select>
            </div>
            <div class="layui-input-inline" style="width: 150px;">
                <select name="dormitoryBuilding" id="dormitoryBuilding">
                    <option value="">请选择宿舍楼</option>
                    <option value="男生宿舍12栋">男生宿舍12栋</option>
                    <option value="男生宿舍13栋" disabled="">男生宿舍13栋</option>
                    <option value="女生宿舍6栋">女生宿舍6栋</option>
                    <option value="女生宿舍8栋">女生宿舍8栋</option>
                </select>
            </div>
            <div class="layui-input-inline" style="width: 120px;">
                <input class="layui-input" type="text" id="dormitoryNum" name="dormitoryNum"/>
            </div>
            <!-- 提示该项是否为必填项 -->
            <div class="layui-form-mid layui-word-aux"><span style="font-size: 18px;color: red;">*</span></div>
        </div>

        <!-- 手机号码 -->
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">手机号码</label>
                <div class="layui-input-inline">
                    <input type="tel" name="phone" id="addrPhone" lay-verify="required|phone" autocomplete="off" class="layui-input">
                </div>
                <!-- 提示该项是否为必填项 -->
                <div class="layui-form-mid layui-word-aux"><span style="font-size: 18px;color: red;">*</span></div>
            </div>
        </div>

        <!-- 是否设置为默认地址 -->
        <div class="layui-form-item">
            <label class="layui-form-label">默认地址</label>
            <div class="layui-input-block">
                <input type="checkbox" name="isDefault" id="isDefault" lay-skin="switch" lay-text="是|否">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn layui-btn-danger" lay-submit="" lay-filter="editAddr">修改地址</button>
            </div>
        </div>

    </form>
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
<script>

    //页面加载后，首先要隐藏所有地址div上的"编辑"、"删除"、"设为默认"超链接
    $("div[name='addressDetail']").find("div").find("a").hide();

    //鼠标移动到每一行地址div标签上，显示"编辑"、"删除"、"设为默认"
    $("div[name='addressDetail']").mouseover(function(event){

        //console.log(event);                 //获取事件对象
        //console.log(event.target);          //获取当前鼠标所在位置元素的对象，即能够获取到子元素标签对象
        //console.log(event.target.id);       //获取当前鼠标移动位置所在标签元素的id，即能够获取到子元素标签的id
        //console.log(event.currentTarget);   //获取触发事件的标签对象，即<div name="addressDetail">的div对象
        //console.log(event.currentTarget.id);//获取触发事件的标签的id，即<div name="addressDetail" id="?">的id
        //console.log(event.pageX);           //获取鼠标位置：x坐标
        //console.log(event.pageY);           //获取鼠标位置：y坐标

        var addressDetailDiv = event.currentTarget;
        $(event.currentTarget).find("div[name='detail']").css("background","#55aa7f");
        var divId = addressDetailDiv.id;//获取当前addressDetailDiv的id
        $(event.currentTarget).find("div").find("a").show();//显示<a></a>标签，即显示"编辑"、"删除"、"设为默认"
    });

    //鼠标从每一行地址div标签上移出后，隐藏"编辑"、"删除"、"设为默认"
    $("div[name='addressDetail']").mouseleave(function(event){
        // alert("鼠标移出了div");
        var addressDetailDiv = event.currentTarget;
        var divId = addressDetailDiv.id;//获取当前addressDetailDiv的id
        console.log(divId);
        $(event.currentTarget).find("div").find("a").hide();//隐藏<a></a>标签，即隐藏"编辑"、"删除"、"设为默认"
        $(event.currentTarget).find("div[name='detail']").css("background","#f9f9f9");
    });

    //设置默认地址
    function setDefaultAddr(param) {
        var addressId = param;
        $.ajax({
            url:"<%=basePath%>addr/setDefaultAddr",
            data:{"addressId":addressId},
            type:"post",
            dataType:"json",
            success:function(json){
                if(json.status == 0){
                    layer.msg(json.msg, {
                        icon: 6,//成功的表情
                        time: 1000 //1秒关闭（如果不配置，默认是3秒）
                    }, function(){
                        //只是设置一个默认地址，没必要全局刷新页面，如何局部刷新？待解决
                        location.reload();//页面刷新
                    });
                }else {
                    layer.msg(json.msg,{icon: 5});//失败的表情
                }
            },
            error: function( data1, status, error ) {
                console.log(data1);
                console.log(status);
                console.log(error);
            }
        });
    }

    //点击"编辑"地址，打开编辑地址模态框
    function toEdit(param) {

        var addressId = param;
        $.ajax({
            url:"<%=basePath%>addr/edit",
            data:{"addressId":addressId},
            type:"get",
            dataType:"json",
            success:function(json){
                //将json中的值用jquery填充到修改模态框表单中的各个文本域
                $("#addressId").val(json.id);
                $("#addrUsername").val(json.username);

                $("#campusName").val(json.addressUtil.campusName);
                $("#dormitoryBuilding").val(json.addressUtil.dormitoryBuilding);
                $("#dormitoryNum").val(json.addressUtil.dormitoryNum);

                $("#addrPhone").val(json.phone);

                if (json.defaultAddr == 0){

                    layui.form.val("editMotaikuang", {
                        "isDefault": true
                    });

                    //因为上行代码操作layui的checkbox，没有在layui.use({})函数里面进行操作。
                    layui.form.render();
                } else {
                    layui.form.val("editMotaikuang", {
                        "isDefault": false
                    });
                    layui.form.render();
                }
            },
            error: function( data1, status, error ) {
                console.log(data1);
                console.log(status);
                console.log(error);
            }
        });

        //展示修改地址模态框
        layui.use(['layer'], function () {
            var layer = layui.layer,
                $ = layui.jquery;
            layer.open({
                type: 1, //弹出层类型 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                anim: 1, //控制弹出动画 1表示从上掉落
                maxmin: true, //模态框是否有最大化最小化按钮
                shadeClose: false, //设置点击模态框的外部，即点击被遮挡页面不关闭模态框
                shade: 0.3, //设置被遮挡页面的透明度
                area: ['600px', '350px'], //设置模态框的大小
                title: '编辑地址', //设置标题
                content: $("#editMotaikuang")
            });
        });

    }

    //点击"删除"地址
    function deleteAddr(param) {
        layui.use(['layer'], function () {
            //询问框
            layer.confirm('确定要删除该条地址吗？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                //点击了"确定"
                //ajax执行删除地址操作
                $.ajax({
                    url:"<%=basePath%>addr/delete",
                    data:{"addressId":param},
                    type:"get",
                    dataType:"json",
                    success:function(json){
                        if(json.status == 0){
                            layer.msg(json.msg, {
                                icon: 6,//成功的表情
                                time: 1000 //1秒关闭（如果不配置，默认是3秒）
                            }, function(){
                                // location.reload();//页面刷新
                                //不需要使用reload()页面刷新，否则ajax就没有多大意义了
                                $("#addressId" + param).remove();//jquery选择器可以进行拼接字符串
                            });
                        }else {
                            layer.msg(json.msg,{icon: 5});//失败的表情
                            return false;
                        }
                    },
                    error: function( data1, status, error ) {
                        console.log(data1);
                        console.log(status);
                        console.log(error);
                    }
                });
            }, function(){
                //点击了"取消"
            });
        });

    }

    //新增地址模态框
    function openModak() {
        layui.use(['layer'], function () {
            var layer = layui.layer,
                $ = layui.jquery;
            layer.open({
                type: 1, //弹出层类型 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                anim: 1, //控制弹出动画 1表示从上掉落
                maxmin: true, //模态框是否有最大化最小化按钮
                shadeClose: false, //设置点击模态框的外部，即点击被遮挡页面不关闭模态框
                shade: 0.3, //设置被遮挡页面的透明度
                area: ['600px', '350px'], //设置模态框的大小
                title: '新增地址', //设置标题
                content: $("#motaikuang")
            })
        });
    }

    <!-- form、layedit、element、menu模块-->
    layui.config({
        base: '<%=basePath%>res/js/util/'
    }).use(['form', 'layer','layedit','element', 'menu'], function () {
        var form = layui.form,
            layer = layui.layer,
            layedit = layui.layedit,
            $ = layui.jquery,
            menu = layui.menu,
            element = layui.element;

        //自定义验证规则
        form.verify({
            //定义新增地址模态框 收货人姓名输入框验证规则
            textVerify: function (value) {
                if (value.length <= 0) {
                    return '收货人不能为空！';
                }
            }
            , content: function (value) {
                layedit.sync(editIndex);
            }
        });

        //监听"提交订单"按钮提交(提交按钮不在form标签内)
        form.on('submit(summitOrder)', function (data) {

            var params = $("#orderInfo").serialize();

            layer.alert(params, {
                title: '最终的提交信息'
            });

            $("#orderInfo").submit();

            return true;
        });

        //监听模态框中"保存地址"按钮提交
        form.on('submit(addAddr)',function(data){

            layer.alert(JSON.stringify(data.field),{
                title:'最终的提交信息'
            });

            $.ajax({
                url:"<%=basePath%>addr",
                data:data.field,
                type:"post",
                dataType:"json",
                success:function(json){
                    if(json.status == 0){
                        layer.msg(json.msg, {
                            icon: 6,//成功的表情
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            //清空模态框表单中缓存的内容，防止页面刷新之后，表单中还存在值。
                            $("#motaiForm")[0].reset();//jquery没有reset(),需要转化为dom对象
                            location.reload();//页面刷新
                        });
                    }else {
                        layer.msg(json.msg,{icon: 5});//失败的表情
                        return false;
                    }
                },
                error: function( data1, status, error ) {
                    console.log(data1);
                    console.log(status);
                    console.log(error);
                }
            });
            return false;//阻止表单跳转
        });

        //监听修改地址模态框中"修改地址"按钮提交
        form.on('submit(editAddr)',function(data){

            layer.alert(JSON.stringify(data.field),{
                title:'最终的提交信息'
            });

            $.ajax({
                url:"<%=basePath%>addr/edit",
                data:data.field,
                type:"post",
                dataType:"json",
                success:function(json){
                    if(json.status == 0){
                        layer.msg(json.msg, {
                            icon: 6,//成功的表情
                            time: 1000 //1秒关闭（如果不配置，默认是3秒）
                        }, function(){
                            //清空模态框表单中缓存的内容，防止页面刷新之后，表单中还存在值。
                            $("#editMotaiForm")[0].reset();//jquery没有reset(),需要转化为dom对象
                            location.reload();//页面刷新
                        });
                    }else {
                        layer.msg(json.msg,{icon: 5});//失败的表情
                        return false;
                    }
                },
                error: function( data1, status, error ) {
                    console.log(data1);
                    console.log(status);
                    console.log(error);
                }
            });
            return false;//阻止表单跳转
        });

        //将复选框改变为单选框
        form.on('checkbox', function (data) {
            if (data.elem.checked) {
                $('input[type=checkbox]').prop('checked', false);
                $(data.elem).prop('checked', true);
            }
            form.render();
        });

    });
</script>

</body>
</html>