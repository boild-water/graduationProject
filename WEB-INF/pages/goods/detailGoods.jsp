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
	<title>物品详情</title>
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
</head>
<body>

<!-- header -->
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
	
<!--[if lt IE 9]>  <script src="<%=basePath%>layui_fly/static/js/html5.min.js"></script>  <script src="<%=basePath%>layui_fly/static/js/respond.min.js"></script><![endif]-->
<div class="shop-nav shopdata">
	<!-- 搜索框 -->
	<div id="LAY-topbar">
		<form action="<%=basePath%>goods/category/0">
			<div class="input-search">
				<div>
					<input type="text" placeholder="搜索你想要的闲置物品" id="searchStr" name="search" autocomplete="off" value="">
					<button type="button" class="layui-btn layui-btn-shop" id="searchBtn"><i class="layui-icon layui-icon-search"></i></button>
					<!-- 热搜内容 -->
					<dl class="layui-hide-sm layui-show-md-inline-block"> <dt>最新热搜：</dt>
						<c:forEach items="${hotSearches}" var="hotSearch">
							<dd><a href="<%=basePath%>goods/category/0?search=${hotSearch.content}">${hotSearch.content}</a></dd>
						</c:forEach>
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

<!-- 物品详情展示 -->
<div>

	<!-- 左侧物品图片+右侧物品信息（包括一些用户的相关信息） -->
	<div class="class1">

		<!-- layui栅栏布局 -->
		<div class="layui-row">

			<!-- 市场首页/闲置数码/罗马仕充电宝 导航栏 -->
			<div class="layui-col-xs12" style="padding: 20px;">
				<span class="layui-breadcrumb" lay-separator="/">
					<a href="<%=basePath%>goods/homeGoods">市场首页</a>
					<a href="<%=basePath%>goods/category/${category.id}">${category.name}</a>
					<a><cite>物品详情</cite></a>
				</span>
			</div>

			<!-- 左侧物品图片 -->
			<div class="layui-col-xs6" style="padding: 20px;">
			  <div>
				<!-- 填充物品图片 -->
				<div class="">
					<img id="spec-img" alt="" src="<%=basePath%>upload/goods/${goodsExtend.images[0].imgUrl}" width="450" height="400px">
				</div>

			  </div>
			</div>

			<!-- 右侧物品相关信息展示（包括一些用户的相关信息） -->
			<div class="layui-col-xs6" style="padding: 20px;">
				<!-- 物品信息 -->
				<div>
					<p class="class2" style="font-size: 24px;font-weight: 500;">${goodsExtend.goods.name}</p>
					<p class="class2" style="font-size: 20px;">
						现价：<span style="color: #EF5350;font-weight: 700;">${goodsExtend.goods.price}￥</span>
					</p>
					<p class="class2" style="font-size: 16px;color: #aaa;">
						原价：<span style="text-decoration: line-through;">${goodsExtend.goods.realPrice}￥</span>
					</p>
					<!-- 待处理 需要goods表中含有bargain、address字段之后才能处理 -->
					<p class="class2">
						<span style="margin-right: 10px;">可讲价</span>
						<i class="layui-icon layui-icon-location"></i>
						<span style="font-size: 16px;">安徽工程大学 12栋 210</span>
					</p>
				</div>
				<!-- 卖家信息 -->
				<div style="width: 440px;height: 190px;">
					<fieldset class="layui-elem-field layui-field-title" style="margin-top: 0px;">
					  <legend style="font-size: 16px;">卖家信息</legend>
					</fieldset>

					<!-- 用户未登录 -->
					<c:if test="${cur_user == null}">
						<p class="class2" style="font-size: 20px;">
							<a href="<%=basePath%>user/login" style="color: #039be5;">登录</a>&nbsp;后才能查看哦！
						</p>
					</c:if>

					<!-- 用户已经登录 -->
					<c:if test="${cur_user != null}">
						<p class="class2" style="padding-top: 0px;">
							<i class="layui-icon layui-icon-username"></i>
							<span style="font-size: 16px;">${seller.username}</span>
						</p>
						<p class="class2">
							<i class="layui-icon layui-icon-cellphone"></i>
							<span style="font-size: 16px;">${seller.phone}</span>
						</p>
						<p class="class2">
							<i class="layui-icon layui-icon-email"></i>
							<c:if test="${seller.email != null}">
								<span style="font-size: 16px;">${seller.email}</span>
							</c:if>
							<c:if test="${seller.email == null}">
								<span style="font-size: 16px;">这位卖家很懒，还没有留下email...</span>
							</c:if>
						</p>
						<p class="class2">
							<i class="layui-icon layui-icon-note"></i>
							<%--信誉分--%>
							<span style="font-size: 16px;">${seller.power}</span>
							<!-- 加入关注、立即购买按钮 -->
							<!-- 还要判断是否是自己发布的物品，不能购买自己发布的物品 -->
							<c:if test="${goodsExtend.goods.userId == cur_user.id}">
								<button class="layui-btn layui-btn-radius layui-btn-disabled" title="不能购买自己发布的物品哦~" style="float: right;"><i class="layui-icon layui-icon-rmb"></i></button>
								<!-- 可以在此处进行加入关注、取消关注操作 -->
								<button class="layui-btn layui-btn-radius layui-btn-disabled" title="不能关注自己发布的物品哦~" style="float: right;">
									<i class="layui-icon layui-icon-star"></i>
								</button>
							</c:if>
							<c:if test="${goodsExtend.goods.userId != cur_user.id}">
								<a href="<%=basePath%>goods/orderCheck/${goodsExtend.goods.id}" class="layui-btn layui-btn-radius layui-btn-danger" title="立即购买" style="float: right;"><i class="layui-icon layui-icon-rmb"></i></a>
								<!-- 可以在此处进行加入关注、取消关注操作 -->
								<button lay-submit="" lay-filter="addOrCancelFocusBtn" class="layui-btn layui-btn-radius layui-btn-warm" title="加入关注" style="float: right;">
									<i id="addOrCancelFocusIcon" class="layui-icon layui-icon-star"></i>
								</button>
							</c:if>

						</p>
					</c:if>

				</div>

				<div>
					<p style="padding: 10px;font-size: 14px;color: #999;">擦亮于 ${goodsExtend.goods.polishTime}</p>
				</div>

			</div>

		</div>

	</div>

	<!-- 物品描述 -->
	<div class="class1">
		<div class="class3">
			<fieldset class="layui-elem-field layui-field-title" >
				<legend style="margin-bottom: 0px;font-weight: 500;">物品描述</legend>
			</fieldset>
		</div>
		<div style="padding-bottom: 20px;padding-left: 10px">
			<p style="text-indent: 2em;line-height:30px;font-size: 16px;padding-bottom: 20px;">${goodsExtend.goods.description}</p>
			<p></p>
			<p style="text-indent: 2em;font-size: 16px;color: #aaa;">注：联系我的时候请记得说明是来自“闲置物品交易市场”的同学哦！</p>
		</div>
	</div>

	<!-- 物品评论信息 -->
	<div class="class1">
		<div class="class3">
			<fieldset class="layui-elem-field layui-field-title" >
				<legend style="margin-bottom: 0px;font-weight: 500;">物品评论</legend>
			</fieldset>
		</div>
		<div id="iteratorCommentsDiv">
			<!-- 此处遍历评论信息 -->
			<c:forEach items="${goodsExtend.comments}" var="comment">
				<div style="padding-bottom: 30px;">
					<div style="padding-left: 25px;">
						<!-- 评论者头像 -->
						<img src="<%=basePath%>upload/user/${comment.user.headImgUrl}" class="layui-circle" width="30px" height="30px">
						<!-- 评论者用户名 -->
						<c:if test="${comment.user.id == cur_user.id}">
							<span style="font-size: 16px;font-weight: 600;color: orange">我：</span>
						</c:if>
						<c:if test="${comment.user.id != cur_user.id}">
							<span style="font-size: 16px;font-weight: 600;">${comment.user.username}：</span>
						</c:if>
						<!-- 评论内容 -->
						<span style="font-size: 16px;">${comment.content}</span>
					</div>
					<div>
						<!-- 评论时间 -->
						<span style="font-size: 14px;color: #999;float: right;padding-right: 10px">${comment.createAt}</span>
					</div>
				</div>
			</c:forEach>
		</div>

		<hr class="layui-bg-orange">

		<!-- 添加评论 -->
		<div style="text-align: center;">
			<form class="layui-form layui-form-pane" style="width: 80%;display: inline-block;">
				<div class="layui-form-item layui-form-text" style="text-align: center;margin-bottom: 10px;">
					<!-- 评论输入框上面的一个小图标 -->
					<label class="layui-form-label" style="text-align: center;font-size: 20px;"><i class="layui-icon layui-icon-dialogue"></i></label>
					<!-- 评论内容输入框 -->
					<div class="layui-input-block" style="text-align: center;">
						<%--goodsId隐藏域--%>
						<input id="goodsId" name="goodsId" value="${goodsExtend.goods.id}" type="hidden"/>
						<%--评论内容--%>
						<textarea placeholder="请输入内容" lay-verify="content" name="content" class="layui-textarea"></textarea>
					</div>
				</div>
				<div class="layui-form-item" style="text-align: center;">
					<!-- 需要判断当前用户是否已经登录，如果未登录 按钮layui-btn-disabled 同时还要禁止提交-->
					<c:if test="${cur_user == null}">
						<button type="button" class="layui-btn layui-btn-radius layui-btn-disabled" title="您还没有登录，请先登录！">发布评论</button>
					</c:if>
					<c:if test="${cur_user != null}">
						<button type="submit" class="layui-btn layui-btn-radius layui-btn-danger" lay-submit="" lay-filter="publishCommentBtn">发布评论</button>
					</c:if>
				</div>
			</form>
		</div>
	</div>

</div>


<!-- footer -->
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

	//在页面加载完成以后执行以下逻辑
	//1.查看当前用户是否已经登录
	//2.如果已经登录，就ajax查询当前用户是否已经关注了当前物品，如果已经关注，修改“加入关注”的图标样式
	$(document).ready(function(){

		if (${cur_user != null}){
			//ajax判断该商品是否已经被当前登录用户关注
			$.ajax({
				url: "<%=basePath%>user/isFocus",
				data: {"goodsId":${goodsExtend.goods.id}},
				type: "get",
				dataType: "json",
				success: function (result) {
					//此处的flag返回为true表示当前用户还没有关注该物品，false表示已经关注该物品
					if (result.flag){

						$("#addOrCancelFocusIcon").attr("class","layui-icon layui-icon-star");
					} else {

						$("#addOrCancelFocusIcon").attr("class","layui-icon layui-icon-star-fill");
					}
				}
			});
		}
	});

	layui.use(['form','layer'], function() {
		var form = layui.form,
			layer = layui.layer;

		//自定义验证规则
		form.verify({
			content: function(value){
				// "^((\s.*)|(.*\s))$"匹配空格
				if(value.length <= 0 || (/^((\s.*)|(.*\s))$/).test(value)){
					return '评论内容为空或包含非法字符！';
				}
			}
		});

		//监听"关注"按钮点击
		form.on('submit(addOrCancelFocusBtn)', function(data){

			//ajax判断该商品是否已经被当前登录用户关注,如果已经关注就取消关注，如果还没有关注就关注。
			$.ajax({
				url: "<%=basePath%>user/addOrCancelFocus",
				data: {"goodsId":${goodsExtend.goods.id}},
				type: "get",
				dataType: "json",
				success: function (result) {
					//此处的flag返回为true表示当前用户还没有关注该物品，false表示已经关注该物品
					if (result.flag){
						//提示关注成功！
						layer.msg(result.message, {
							icon: 6,//成功的表情
							time: 1000 //1秒关闭（如果不配置，默认是3秒）
						}, function () {
							$("#addOrCancelFocusIcon").attr("class","layui-icon layui-icon-star-fill");
						});
					} else {
						//提示取消关注成功！
						layer.msg(result.message, {
							icon: 6,//成功的表情
							time: 1000 //1秒关闭（如果不配置，默认是3秒）
						}, function () {
							$("#addOrCancelFocusIcon").attr("class","layui-icon layui-icon-star");
						});
					}
				}
			});

			return false;
		});

		//监听"发布评论"按钮提交
		form.on('submit(publishCommentBtn)', function(data){

			//ajax发布评论
			$.ajax({
				url: "<%=basePath%>goods/addComments",
				data: data.field,
				type: "post",
				dataType: "json",
				success: function (result) {
					if (result.flag){
						//发布评论成功
						layer.msg(result.message, {
							icon: 6,//成功的表情
							time: 1000 //1秒关闭（如果不配置，默认是3秒）
						}, function () {
							//清空<textarea></textarea>中缓存的内容
							$("textarea[name='content']").val("");

							//layui 加载层
							layer.load();
							setTimeout(function(){
								layer.closeAll('loading');
							}, 300);//0.3s关闭

							//在遍历评论信息div的头部添加新发布的评论信息
							$("#iteratorCommentsDiv").append(
									'<div style="padding-bottom: 30px;">\n' +
									'\t\t\t\t\t<div style="padding-left: 25px;">\n' +
									'\t\t\t\t\t\t<!-- 评论者头像 -->\n' +
									'\t\t\t\t\t\t<img src="<%=basePath%>upload/user/${cur_user.headImgUrl}" class="layui-circle" width="30px" height="30px">\n' +
									'\t\t\t\t\t\t<!-- 评论者用户名 -->\n' +
									'\t\t\t\t\t\t<span style="font-size: 16px;font-weight: 550;color: orange">我：</span>\n' +
									'\t\t\t\t\t\t<!-- 评论内容 -->\n' +
									'\t\t\t\t\t\t<span style="font-size: 16px;">' + result.data.content + '</span>\n' +
									'\t\t\t\t\t</div>\n' +
									'\t\t\t\t\t<div>\n' +
									'\t\t\t\t\t\t<!-- 评论时间 -->\n' +
									'\t\t\t\t\t\t<span style="font-size: 14px;color: #999;float: right;padding-right: 10px">' + result.data.createAt + '</span>\n' +
									'\t\t\t\t\t</div>\n' +
									'\t\t\t\t</div>'
							);
						});
					} else {
						//发布评论失败...
					}
				}
			});


			return false;
		});


	});
</script>
</body>
</html>
