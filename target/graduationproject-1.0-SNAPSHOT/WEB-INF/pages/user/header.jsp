<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<html>
<head>

    <!-- 引入自定义的阿里矢量图标库 -->
    <link rel="stylesheet" type="text/css" href="<%=basePath%>res/layui/lay/modules/layui-icon-extend/iconfont.css"/>
    <!-- 阿里矢量图标 Symbol 引用 -->
    <script src="<%=basePath%>res/layui/lay/modules/layui-icon-extend/iconfont.js"></script>
    <style>
        .icon {
            width: 1em;
            height: 1em;
            vertical-align: -0.15em;
            fill: currentColor;
            overflow: hidden;
        }
    </style>

</head>
<body>

<div class="header" style="height: 100px;">
    <div class="menu-btn">
        <div class="menu"></div>
    </div>
    <div>
        <h1 class="logo" style="height: 100px;">
            <a href="<%=basePath%>goods/homeGoods">
                <img src="<%=basePath%>res/img/logo.svg" style="vertical-align:baseline;">
                <span>闲置物品交易市场</span>
            </a>
        </h1>
    </div>
    <div class="nav">
        <a href="<%=basePath%>goods/publishGoods">
				<span  style="font-size: 18px;">
					<svg class="icon" aria-hidden="true"><use xlink:href="#icon-icon-extendfabuxianzhi"></use></svg>
					发布闲置
				</span>
        </a>
        <a href="<%=basePath%>user/allGoods">
				<span style="font-size: 18px;">
					<svg class="icon" aria-hidden="true"><use xlink:href="#icon-icon-extendwodexianzhi"></use></svg>
					我的闲置
				</span>
        </a>
        <a href="<%=basePath%>user/myOrders">
				<span style="font-size: 18px;">
					<svg class="icon" aria-hidden="true"><use xlink:href="#icon-icon-extenddingdan"></use></svg>
					我的订单
				</span>
        </a>
        <a href="<%=basePath%>user/allFocus">
				<span style="font-size: 18px;">
					<svg class="icon" aria-hidden="true"><use xlink:href="#icon-icon-extendguanzhu"></use></svg>
					我的关注
				</span>
        </a>
        <a href="<%=basePath%>user/buyinfo">
				<span style="font-size: 18px;">
					<svg class="icon" aria-hidden="true"><use xlink:href="#icon-icon-extendqiugouxinxi"></use></svg>
					求购信息
				</span>
        </a>
        <%--<a href="about">
				<span style="font-size: 18px;">
					<svg class="icon" aria-hidden="true"><use xlink:href="#icon-icon-extendguanyu"></use></svg>
					关于
				</span>
        </a>--%>
    </div>

    <ul class="layui-nav header-down-nav">
        <li class="layui-nav-item"><a href="#" class="active">文章</a></li>
        <li class="layui-nav-item"><a href="#">微语</a></li>
        <li class="layui-nav-item"><a href="#">相册</a></li>
        <li class="layui-nav-item"><a href="#">求购信息</a></li>
        <li class="layui-nav-item"><a href="#">关于</a></li>
    </ul>
    <!-- 导航栏右侧个人信息 -->
    <p class="welcome-text">
        <!-- 欢迎来到<span class="name">小明</span>的博客~ -->
    <div style="float:right;">
        <ul class="layui-nav" style="background-color: white;height: 100px;">
            <li class="layui-nav-item" lay-unselect="">
                <a href="javascript:;">
                    <!-- 填充用户头像 -->
                    <c:if test="${empty cur_user.headImgUrl}">
                        <%--使用默认头像--%>
                        <img src="<%=basePath%>upload/user/user_head_default.jpeg" id="headImg_navigation" class="layui-nav-img" style="width: 36px;height: 36px">
                    </c:if>
                    <c:if test="${!empty cur_user.headImgUrl}">
                        <img src="<%=basePath%>upload/user/${cur_user.headImgUrl}" id="headImg_navigation" class="layui-nav-img" style="width: 36px;height: 36px">
                    </c:if>

                    <!-- 填充用户名 -->
                    <span style="color: #000000;" id="username_navigation">${cur_user.username}</span>
                </a>
                <dl class="layui-nav-child">
                    <!-- 问题遗留，在这几个按钮前加上图标-->
                    <dd style="text-align: center;">
                        <a href="javascript:personalSetting();"><i class="iconfont">&#xe6a8;</i>个人资料</a>
                    </dd>
                    <dd style="text-align: center;">
                        <a href="javascript:modifyPassword();"><i class="iconfont">&#xe606;</i>修改密码</a>
                    </dd>
                    <dd style="text-align: center;">
                        <a href="javascript:logout();"><i class="iconfont">&#xe70b;</i>退出登录</a>
                    </dd>
                </dl>
            </li>
        </ul>
    </div>
    </p>
</div>

<%-- 个人信息修改模态框 --%>
<div id="personalSettingMotaikuang" style="display: none;">
    <form class="layui-form" action="" id="personalSettingMotaiForm">
        <div class="layui-form-item">
            <label class="layui-form-label">头像</label>
            <div class="layui-upload layui-input-block">
                <!-- 填充用户头像 -->
                <div id="previewDiv">
                    <input name="headImgUrl" id="headImgUrl" value="" type="hidden">
                    <img src="<%=basePath%>upload/user/user_head_default.jpeg" id="headImg" class="layui-nav-img" style="width: 90px;height: 90px;">
                    <button type="button" class="layui-btn layui-btn-warm" id="selectImg">选择图片</button>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">用户名</label>
                <div class="layui-input-block">
                    <input type="text" id="username" name="username" lay-verify="required" autocomplete="off"
                           placeholder="boildwater" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">手机</label>
                <div class="layui-input-inline">
                    <input type="tel" id="phone" name="phone" lay-verify="required|phone" autocomplete="off"
                           class="layui-input" disabled>
                </div>
                <div class="layui-form-mid layui-word-aux">更改手机号码？</div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="sex" value="0" title="男">
                <input type="radio" name="sex" value="1" title="女">
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">出生日期</label>
                <div class="layui-input-inline">
                    <input type="text" id="birthday" name="birthday" id="date" lay-verify="date" placeholder="yyyy-MM-dd"
                           autocomplete="off" class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">邮箱</label>
                <div class="layui-input-inline">
                    <input type="text" id="email" name="email" lay-verify="myEmail" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">QQ</label>
                <div class="layui-input-inline">
                    <input type="text" id="qq" name="qq" lay-verify="qq" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">上次登录</label>
                <div class="layui-input-inline">
                    <input type="text" id="lastLogin" value="${lastLogin}" name="lastLogin" autocomplete="off" class="layui-input" disabled/>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="button" class="layui-btn" lay-submit="" lay-filter="updateInfo" style="float: right;margin-right: 30px">保存信息</button>
            </div>
        </div>

    </form>
</div>

<%--密码修改模态框--%>
<div id="modifyPasswordMotaikuang" style="display: none;">
    <form class="layui-form" action="" style="margin-top: 20px" id="modifyPasswordForm">
        <div class="layui-form-item">
            <label class="layui-form-label">旧密码</label>
            <div class="layui-input-inline">
                <input type="password" id="password" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux" id="tips"><%--<i class="layui-icon layui-icon-ok" style="color: green;"></i>ajax验证--%></div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">新密码</label>
            <div class="layui-input-inline">
                <input type="password" id="newPassword" name="password" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">确认密码</label>
            <div class="layui-input-inline">
                <input type="password" id="confirmPassword" name="password" required lay-verify="required" autocomplete="off" class="layui-input">
            </div>
            <div class="layui-form-mid layui-word-aux" id="confirmTips"><%--填图标--%></div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button type="submit" class="layui-btn layui-btn-danger" lay-submit="" lay-filter="modifyPass" id="modifyPassBtn">修改密码</button>
                <button type="reset" class="layui-btn layui-btn-primary" >重置</button>
            </div>
        </div>
    </form>

</div>


<script type="text/javascript" src="<%=basePath%>res/layui/layui.js"></script>
<!-- 引入jquery-->
<script type="text/javascript" src="<%=basePath%>res/js/jquery-3.4.1.js"></script>
<script type="text/javascript">
    layui.config({
        base: '<%=basePath%>res/js/util/'
    }).use(['element', 'laypage', 'jquery', 'menu'], function () {
        element = layui.element, laypage = layui.laypage, $ = layui.$, menu = layui.menu;
        menu.init();
    })
</script>

<%--个人信息、修改密码等模态框操作 *****************************开始 方便复制*********************--%>
<!-- form、laydate、layedit模块-->
<script>
    layui.use(['form', 'layedit', 'laydate'], function () {
        var form = layui.form
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;

        //日期
        laydate.render({
            elem: '#birthday'
        });

        //自定义验证规则
        form.verify({
            myEmail: function (value) {
                //email为空时不做验证，输入值时才做验证
                if(value != ''){
                    if (!new RegExp("^[a-zA-Z0-9]+([-_.][a-zA-Z0-9]+)*@[a-zA-Z0-9]+([-_.][a-zA-Z0-9]+)*\\.[a-z]{2,}$").test(value)) {
                        return '邮箱格式不正确！';
                    }
                }
            },
            qq: function (value) {
                //qq为空时不做验证，输入值时才做验证
                if(value != ''){
                    if (!new RegExp("^\\d{5,11}$").test(value)) {
                        return '输入的QQ不正确！';
                    }
                }
            }

        });
    });
</script>
<script>
    //点击"个人资料"地址，打开编辑个人资料模态框
    function personalSetting() {

        $.ajax({
            url:"<%=basePath%>user/personalSetting",
            data:{},//不发送userId，在后端通过session获得当前用户的userId，比较安全
            type:"get",
            dataType:"json",
            success:function(result){
                if (result.flag){
                    //将result中的值用jquery填充到个人信息模态框表单中的各个文本域
                    if (!result.data.headImgUrl){
                        //表示用户还没有头像信息，使用默认头像
                        $("#headImg").attr("src","<%=basePath%>upload/user/user_head_default.jpeg");
                    } else {
                        $("#headImg").attr("src","<%=basePath%>upload/user/"+result.data.headImgUrl);
                    }
                    $("#headImgUrl").val(result.data.headImgUrl);
                    $("#username").val(result.data.username);//用户名
                    $("#phone").val(result.data.phone);//手机
                    $("input[name='sex'][value='"+ result.data.sex +"']").attr("checked",true);//性别
                    $("#birthday").val(result.data.birthday);//出生日期
                    $("#email").val(result.data.email);//邮箱
                    $("#qq").val(result.data.qq);//qq
                    // $("#lastLogin").val(result.data.lastLogin);

                    //一定要加上下行代码，否则上行代码执行完只会更改页面代码，显示在页面中的样式没有变化。
                    //因为上行代码操作layui的checkbox，没有在layui.use({})函数里面进行操作。
                    layui.form.render();
                } else {
                    alert("获取个人信息失败！")
                }
            },
            error: function( data1, status, error ) {
                console.log(data1);
                console.log(status);
                console.log(error);
            }
        });


        layui.use(['jquery','form','layer','element'], function () {
            var form = layui.form,
                layer = layui.layer,
                $ = layui.jquery,
                element = layui.element;

            //展示个人信息模态框
            var personalSettingMotaikuang = layer.open({
                type: 1, //弹出层类型 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                anim: 1, //控制弹出动画 1表示从上掉落
                maxmin: true, //模态框是否有最大化最小化按钮
                shadeClose: false, //设置点击模态框的外部，即点击被遮挡页面不关闭模态框
                shade: 0.3, //设置被遮挡页面的透明度
                area: ['750px', '550px'], //设置模态框的大小
                title: '个人资料', //设置标题
                content: $("#personalSettingMotaikuang")
            });

            //监听个人信息模态框中"保存信息"按钮提交
            form.on('submit(updateInfo)',function(data){

                // layer.alert(JSON.stringify(data.field),{
                //     title:'最终的提交信息'
                // });
                //
                // return false;

                $.ajax({
                    url:"<%=basePath%>user/updateInfo",
                    data:data.field,
                    type:"post",
                    dataType:"json",
                    success:function(result){
                        if(result.flag){
                            layer.msg(result.message, {
                                icon: 6,//成功的表情
                                time: 1000 //1秒关闭（如果不配置，默认是3秒）
                            }, function(){
                                // location.reload();//页面刷新
                                //如果让页面重新刷新，那还要ajax干什么呢？
                                //更新完成后显示给用户看的就一个地方，导航栏的用户名和用户头像
                                if (!result.data.headImgUrl){
                                    //表示用户还没有头像信息，使用默认头像
                                    $("#headImg_navigation").attr("src","<%=basePath%>upload/user/user_head_default.jpeg");
                                } else {
                                    $("#headImg_navigation").attr("src","<%=basePath%>upload/user/"+result.data.headImgUrl);
                                }
                                $("#username_navigation").text(result.data.username);

                                //最后还要关闭模态框
                                // $("#personalSettingMotaikuang").css("display","none");//这样做会出现问题
                                layer.close(personalSettingMotaikuang);//正确关闭layui模态框的方式
                            });
                        }else {
                            layer.msg("保存信息失败！",{icon: 5});//失败的表情
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
        });
    }

    //点击“修改密码”，打开修改密码模态框
    function modifyPassword() {

        layui.use(['jquery','form','layer','element'], function () {
            var form = layui.form,
                layer = layui.layer,
                $ = layui.jquery,
                element = layui.element;

            //展示密码修改模态框
            var modifyPasswordMotaikuang = layer.open({
                type: 1, //弹出层类型 0（信息框，默认）1（页面层）2（iframe层）3（加载层）4（tips层）
                anim: 0, //控制弹出动画 1表示从上掉落
                maxmin: true, //模态框是否有最大化最小化按钮
                shadeClose: false, //设置点击模态框的外部，即点击被遮挡页面不关闭模态框
                shade: 0.3, //设置被遮挡页面的透明度
                area: ['410px', '280px'], //设置模态框的大小
                title: '修改密码', //设置标题
                content: $("#modifyPasswordMotaikuang")
            });

            //监听密码修改模态框中"修改密码"按钮提交
            form.on('submit(modifyPass)',function(data){

                //判断新密码和确认密码输入的内容是否一致
                var newPass = $("#newPassword").val();
                var confirmPass = $("#confirmPassword").val();
                if (newPass == confirmPass){

                    $.ajax({
                        url:"<%=basePath%>user/modifyPass",
                        data:{"password":newPass},
                        type:"post",
                        dataType:"json",
                        success:function(result){
                            if(result.flag){
                                layer.msg(result.message, {
                                    icon: 6,//成功的表情
                                    time: 1000 //1秒关闭（如果不配置，默认是3秒）
                                }, function(){
                                    $("#tips").html("");
                                    //关闭模态框
                                    // $("#personalSettingMotaikuang").css("display","none");//这样做会出现问题
                                    layer.close(modifyPasswordMotaikuang);//正确关闭layui模态框的方式

                                    layer.msg("身份已过期，即将前往登录页面");
                                    setTimeout(function () {
                                        location.href="<%=basePath%>user/login";
                                    }, 2000);
                                });
                            }else {
                                layer.msg("修改密码失败！",{icon: 5});//失败的表情
                                layer.close(modifyPasswordMotaikuang);//正确关闭layui模态框的方式
                            }
                            //清空模态框中form表单中的缓存的值
                            $("#modifyPasswordForm")[0].reset();//正确重置方法(参考 https://www.cnblogs.com/yud123/p/7417148.html)
                            // $("#modifyPasswordForm").reset();//错误重置方法
                        },
                        error: function( data1, status, error ) {
                            console.log(data1);
                            console.log(status);
                            console.log(error);
                        }
                    });

                } else {
                    layer.msg("前后输入密码不一致！");
                    $("#confirmTips").html("<svg class='icon' aria-hidden='true'><use xlink:href='#icon-icon-extendmimabuyizhi'></use></svg>");
                }

                return false;//阻止表单跳转
            });

        });
    }

    //监听“旧密码”输入框失去焦点事件
    $("#password").blur(function(){

        //获取输入的旧密码值
        var password = $("#password").val();
        //发送ajax请求到后台，查看输入的旧密码是否正确
        $.ajax({
            url: "<%=basePath%>user/ajaxPassword",
            data: {"password": password},
            type: "post",
            dataType: "json",
            success: function (result) {
                if (result.flag) {
                    //密码正确,在旧密码的输入框右侧添加 “√”号
                    $("#tips").html("<i class='layui-icon layui-icon-ok' style='color: green;'></i>密码正确");
                    $("#modifyPassBtn").attr("disabled",false);
                } else {
                    //密码错误,在旧密码的输入框右侧添加“X”号
                    $("#tips").html("<i class='layui-icon layui-icon-close' style='color: red;'></i>密码错误");
                    $("#modifyPassBtn").attr("disabled",true);
                }
            }
        });

    });

    //退出登录
    function logout() {

        layui.use(['layer'],function () {

            layer.confirm('是否退出登录？', {
                btn: ['退出','取消'] //按钮
            }, function(){
                layer.msg('已退出登录', {icon: 1});
                window.location.href="<%=basePath%>/user/logout";
            }, function(){

            });

        });
    }

</script>

<!-- 文件上传模块-->
<script>
    layui.use(['upload','jquery'], function () {
        var $ = layui.jquery
            , upload = layui.upload;

        //头像上传
        var uploadInst = upload.render({
            elem: '#selectImg'
            , url: '<%=basePath%>user/uploadFile'  //改成您自己的上传接口
            , before: function (obj) {//提交服务器之前
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    //提交服务器之前，页面预览图片
                    $('#previewDiv img').attr("src",result);
                });
            }
            , done: function (res) {//提交服务器完成后
                //上传失败
                if (res.status > 0) {
                    return layer.msg('上传图片失败');
                } else {
                    $("#headImgUrl").val(res.fileUrl);
                    return layer.msg('上传图片成功', {icon: 1});
                }
            }
            , error: function () {//失败状态，并实现重传

                layer.confirm('图片上传异常，是否重传？', {//询问框
                    btn: ['重传', '取消'] //按钮
                }, function () {
                    uploadInst.upload();//执行重传操作
                }, function () {
                    $('#previewDiv img').attr("src","<%=basePath%>upload/user/user_head_default.jpeg");
                });
            }
        });

    });
</script>

</body>
</html>
