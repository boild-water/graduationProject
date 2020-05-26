<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html class="fly-html-layui fly-html-store">
<head>
	<meta charset="utf-8">
	<title>注册</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/font_24081_qs69ykjbea.css">
	<link rel="icon" href="<%=basePath%>res/img/logo.svg" type="image/x-icon"/>
	<link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/layui.css">
	<link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/global.css" charset="utf-8">
	<link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/global_1.css" charset="utf-8">
	<link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/store.css" charset="utf-8">
	<link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/myclass.css" charset="utf-8">
	
</head>
<body>
	
	<!--[if lt IE 9]>  <script src="<%=basePath%>layui_fly/static/js/html5.min.js"></script>  <script src="<%=basePath%>layui_fly/static/js/respond.min.js"></script><![endif]-->
	<div class="shop-nav shop-index">
		<!-- 搜索框 -->
		<div id="LAY-topbar">
			<form action="<%=basePath%>goods/category/0">
				<div class="input-search">
					<div>
						<input type="text" placeholder="搜索你想要的闲置物品" id="searchStr" name="search" autocomplete="off" value="">
						<button type="button" class="layui-btn layui-btn-shop" id="searchBtn"><i class="layui-icon layui-icon-search"></i></button>
						<!-- 热搜内容 -->
						<dl class="layui-hide-sm layui-show-md-inline-block"> <dt>热搜：</dt>
							<dd><a href="">充电宝</a></dd>
							<dd><a href="">iPhone 11Pro</a></dd>
							<dd><a href="">高等数学</a></dd>
							<dd><a href="">机械键盘</a></dd>
							<dd><a href="">java 编程思想</a></dd>
							<dd><a href="" style="color: #FF5722;">全部</a></dd>
						</dl>
					</div>
					<div class="layui-container layui-hide-xs">
						<a href="https://www.layui.com/" class="topbar-logo">
							<img src="<%=basePath%>layui_fly/static/picture/logo-1.png" alt="layui">
						</a>
					</div>
				</div>
			</form>
		</div>
	</div>


	<div style="background: url(<%=basePath%>layui_fly/static/images/load_bg.jpg) no-repeat;background-size: auto;background-size: cover;width: 100%;">
		<div class="class6">
			<div class="class4">
				<form class="layui-form" action="">
					<legend class="class8">账户注册</legend>
					<div class="layui-form-item">
						<!-- 用户名 -->
						<div class="layui-inline" style="margin-bottom: 20px;width: 100%;position: relative;">
							<div class="layui-input-inline" style="width: 100%;position: relative;">
								<i class="layui-icon layui-icon-username" style="position: absolute;top: 8px;left: 10px;color: #d3d3d3;font-size: 20px;"></i>
								<!-- 注意：表单验证 username -->
								<input type="text" name="username" id="username" lay-verify="username" placeholder="请输入用户名" autocomplete="off" class="layui-input" style="padding-left: 40px;">
							</div>
						</div>
						<!-- 手机号 -->
						<div class="layui-inline" style="margin-bottom: 20px;width: 100%;position: relative;">
							<div class="layui-input-inline" style="width: 100%;position: relative;">
								<i class="layui-icon layui-icon-cellphone" id="phoneTips" style="position: absolute;top: 8px;left: 10px;color: #d3d3d3;font-size: 20px;"></i>
								<input type="tel" name="phone" id="phone" lay-verify="phone" placeholder="请输入手机号" autocomplete="off" class="layui-input" style="padding-left: 40px;">
							</div>
						</div>
						<!-- 手机验证码登录 -->
						<!-- <div class="layui-inline veri-code" style="width: 100%;position: relative;">
							<div class="layui-input-inline" style="width: 100%;position: relative;">
								<input id="pnum" type="text" name="pnum" lay-verify="required" placeholder="请输入验证码" autocomplete="off" class="layui-input">
								<input type="button" class="layui-btn class5" id="find" value="验证码"> 
							</div>
						</div> -->
						<!-- 密码 -->
						<div class="layui-inline" style="margin-bottom: 20px;width: 100%;position: relative;">
							<div class="layui-input-inline" style="width: 100%;position: relative;">
								<i class="layui-icon layui-icon-password" style="position: absolute;top: 8px;left: 10px;color: #d3d3d3;font-size: 20px;"></i>
								<input type="password" name="password" id="password" lay-verify="password" placeholder="请输入密码" autocomplete="off" class="layui-input" style="padding-left: 40px;">
							</div>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-input-block" style="margin-left: 0;">
							<button type="submit" class="layui-btn" lay-submit="" lay-filter="registerBtn" style="width: 100%;background: #cfb2f6;font-size: 18px;">注册</button>
						</div>
					</div>
					<div class="layui-form-item">
						已有账号？<a href="<%=basePath%>user/login">点击登录</a>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	
	<!-- footer -->
	<div class="fly-footer" style="margin-top: 0px;">
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
			<!-- <a href="https://console.upyun.com/register/?invite=SJ0wu6g2-" target="_blank" rel="nofollow" sponsor="upyun">
				<img src="<%=basePath%>layui_fly/static/picture/upyun.png"> 
			</a> 
			<a href="https://www.maoyuncloud.com/?from=layui" target="_blank" rel="nofollow" sponsor="maoyun"> 
				<img src="<%=basePath%>layui_fly/static/picture/168_1559291577683_9348.png"> 
			</a> -->
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
<script>
	//点击“搜索按钮”
	$("#searchBtn").click(function(){
		var searchStr = $("#searchStr").val();
		//判断是否为空并且去除空格后的长度是否为0
		if (searchStr == null || $.trim(searchStr).length == 0) {
			window.location.href = "<%=basePath%>goods/category/0";
		} else {
			window.location.href = "<%=basePath%>goods/category/0?search=" + searchStr;
		}
	});
</script>

<script>

	layui.use(['layer','form'],function () {

		var layer = layui.layer,
				form = layui.form;

		//自定义验证规则
		form.verify({
			//用户名验证规则
			username: function(value){
				// "^((\s.*)|(.*\s))$"匹配空格
				if(value.length <= 0 || (/^((\s.*)|(.*\s))$/).test(value)){
					return '用户名不能为空或者包含非法字符！';
				}
			},
			//手机号码验证规则
			phone: function(value){

				if(!(/^1[3456789]\d{9}$/.test(value))){
					return '请输入正确的手机号码！';
				}
			}
			//密码输入框验证规则
			,password: [
				/^[\S]{6,18}$/
				,'密码必须6到18位，且不能出现空格！'
			]
		});

		//ajax验证手机号(账号)是否存在(为了提升用户体验)
		$("#phone").blur(function(){

			var phone = $("#phone").val();
			//判断用户输入的手机号是否为空并且正则验证手机号码是否通过
			if (phone != null && $.trim(phone).length > 0 && (/^1[3456789]\d{9}$/.test(phone))){
				$.ajax({
					url: "<%=basePath%>user/ajaxPhone",
					data: {"phone":phone},
					type: "get",
					dataType: "json",
					success: function (result) {
						if (result.flag){//表示操作成功
							layer.msg(result.message);
							$("#phoneTips").attr("class","layui-icon layui-icon-close");
						} else {
							$("#phoneTips").attr("class","layui-icon layui-icon-ok");
						}
					}
				});
			} else {
				$("#phoneTips").attr("class","layui-icon layui-icon-cellphone");
			}
		});


		//监听"注册"按钮提交
		form.on('submit(registerBtn)', function(data){

			//ajax验证手机号和密码是否匹配成功
			$.ajax({
				url: "<%=basePath%>user/register",
				data: data.field,
				type: "post",
				dataType: "json",
				success: function (result) {
					if (result.flag){//表示操作成功
						layer.msg(result.message, {
							icon: 6,//成功的表情
							time: 1000 //1秒关闭（如果不配置，默认是3秒）
						}, function () {
							//注册完成后，跳转到登录页面
							location.href = "<%=basePath%>user/login";
						});
					} else {
						layer.msg(result.message, {icon: 5});//失败的表情
					}
				}
			});

			return false;//禁止表单提交
		});
	});




</script>
	
</body>
</html>
