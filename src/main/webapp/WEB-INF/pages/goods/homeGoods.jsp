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
	<title>闲置物品交易市场</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="icon" href="<%=basePath%>res/img/logo.svg" type="image/x-icon"/>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/font_24081_qs69ykjbea.css">
	<link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/layui.css">
	<link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/global.css" charset="utf-8">
	<link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/global_1.css" charset="utf-8">
	<link rel="stylesheet" href="<%=basePath%>layui_fly/static/css/store.css" charset="utf-8">
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
							<img src="<%=basePath%>layui_fly/static/images/visitor1.svg">
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
	<div class="shop-nav shop-index">
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
		
		<div class="shop-banner">
			<!-- 左侧分类条 -->
			<div class="layui-container layui-hide-xs">
				<div class="product-list">
					<dl>
						<dt><a>全部分类</a></dt>
						<%--实际上此处也应该进行遍历，不应该写死在这里--%>
						<dd><a href="<%=basePath%>goods/category/1">电子数码</a></dd>
						<dd><a href="<%=basePath%>goods/category/2">生活日用</a></dd>
						<dd><a href="<%=basePath%>goods/category/3">图书教材</a></dd>
						<dd><a href="<%=basePath%>goods/category/4">美妆衣物</a></dd>
						<dd><a href="<%=basePath%>goods/category/5">运动娱乐</a></dd>
						<dd><a href="<%=basePath%>goods/category/6">耳机音响</a></dd>
						<dd><a href="<%=basePath%>goods/category/7">其他闲置</a></dd>
					</dl>
				</div>
			</div>
			
			<!-- 这里打算用于显示本网站的公告信息的滚动条，待处理 -->
			<div class="layui-carousel" lay-filter="LAY-store-banner" id="LAY-store-banner" style="background: #F2E6D6">
				<div carousel-item>

					<div style="background: #3cb371">
						<div class="layui-container">
							<a href="">
								<img src="<%=basePath%>layui_fly/static/picture/gonggao1.jpg" alt="公告1">
							</a>
						</div>
					</div>
					<div style="background: #ffe4e1">
						<div class="layui-container">
							<a href="">
								<img src="<%=basePath%>layui_fly/static/picture/gonggao2.jpg" alt="公告2">
							</a>
						</div>
					</div>
					<div style="background: #e7e5fa">
						<div class="layui-container">
							<a href="">
								<img src="<%=basePath%>layui_fly/static/picture/gonggao3.jpg" alt="公告3">
							</a>
						</div>
					</div>

					<%--<div style="background: #F2E6D6">
						<div class="layui-container"> 
							<a href="/store/layuiHomeMall/" target="_blank"> 
								<img src="<%=basePath%>layui_fly/static/picture/168_1541579354090_82219.jpg" alt="简约家居商城模板">
							</a> 
						</div>
					</div>

					<div style="background: #E7E6EE">
						<div class="layui-container"> <a href="/store/layuiSimpleNews/" target="_blank"> <img src="<%=basePath%>layui_fly/static/picture/168_1541751659392_62620.jpg"
								 alt="极简新闻资讯模板"> </a> </div>
					</div>
					<div style="background: #171717">
						<div class="layui-container"> <a href="/store/layuiQuietBlog/" target="_blank"> <img src="<%=basePath%>layui_fly/static/picture/168_1541578489374_99939.jpg"
								 alt="静谧风格个人博客模板"> </a> </div>
					</div>
					<div style="background: #F5F5F5">
						<div class="layui-container"> <a href="/store/layuiCateCompany/" target="_blank"> <img src="<%=basePath%>layui_fly/static/picture/168_1542012881618_47524.jpg"
								 alt="餐饮企业网站模板"> </a> </div>
					</div>
					<div style="background: #E2DEF5">
						<div class="layui-container"> <a href="/store/layuiMaternalBabyMall/" target="_blank"> <img src="<%=basePath%>layui_fly/static/picture/168_1542013154213_82579.jpg"
								 alt="母婴商城模板"> </a> </div>
					</div>--%>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="shop-temp">
		
		<!-- 热门闲置模块 -->
		<div class="temp-hot">
			<div class="layui-container">

				<p class="temp-title-cn"><span></span>热门闲置<span></span></p>
				<div class="layui-row layui-col-space20" style="margin:-10px 100px -10px 100px;">
					
					<!-- 此处开始遍历位置 -->
					<c:forEach items="${goodsExtendsHot}" var="goodsExtend">
						<div class="layui-col-xs6 layui-col-md3">
							<a class="template store-list-box" href="<%=basePath%>goods/goodsId/${goodsExtend.goods.id}">
								<%--物品图片--%>
								<img src="<%=basePath%>upload/goods/${goodsExtend.images[0].imgUrl}" class="store-list-cover">
								<%--物品名称--%>
								<h2 class="layui-elip">${goodsExtend.goods.name}</h2>
								<%-- 物品浏览量 --%>
								<p class="price">
									<span title="金额"> 浏览量:${goodsExtend.goods.pageviews} </span>
								</p>
							</a>
						</div>
					</c:forEach>
				</div>

			</div>
		</div>
		
		<!-- 最新发布模块 -->
		<div class="temp-normal">
			<div class="layui-container">
				<p class="temp-title-cn">
					<span></span> <a href="<%=basePath%>goods/category/0/">最新发布</a> <span></span>
				</p>
				<div class="layui-row layui-col-space20 shoplist" style="margin:-10px 100px -10px 100px;">
					<%--此处开始遍历位置--%>
					<c:forEach items="${goodsExtendsNew}" var="goodsExtend">
						<div class="layui-col-xs12 layui-col-sm6 layui-col-md4 layui-col-lg3">
							<a class="template store-list-box" href="<%=basePath%>goods/goodsId/${goodsExtend.goods.id}">
								<%--物品图片--%>
								<img src="<%=basePath%>upload/goods/${goodsExtend.images[0].imgUrl}" class="store-list-cover">
								<%--物品名称--%>
								<h2 class="layui-elip">${goodsExtend.goods.name}</h2>
								<div>
									<!-- 填充物品价格 -->
									<label class="layui-badge-rim store-list-pay" title="价格"> ${goodsExtend.goods.price} </label><br/>
									<!-- 擦亮时间 -->
									<label class="layui-badge-rim store-list-polishdate" title="擦亮时间">擦亮于&nbsp;${goodsExtend.goods.polishTime}</label>
									<!-- 浏览量 -->
									<div class="store-list-pageviews" title="浏览量">
										<span><i class="layui-icon layui-icon-log"></i>${goodsExtend.goods.pageviews}</span>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>

				</div>
				
				<!-- “<”按钮位置 -->
				<div class="shop-more">
					<a href="<%=basePath%>goods/category/0">
						<i class="layui-icon layui-icon-next" style="color: #279659"></i>
					</a>
				</div>
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
	layui.use('carousel', function(){
	  var carousel = layui.carousel;
	  //建造实例
	  carousel.render({
		elem: '#LAY-store-banner'
		,width: '100%' //设置容器宽度
		,arrow: 'hover' //悬停显示箭头
		//,anim: 'updown' //切换动画方式
		,height: '460px'
		,anim: 'fade'
		,interval: 5000
	  });
	});
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
	

</body>
</html>
