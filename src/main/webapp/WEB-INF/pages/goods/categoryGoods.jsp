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
						<input type="text" placeholder="搜索你想要的闲置物品" id="searchStr" name="search" autocomplete="off" value="${searchStr}">
						<button type="button" id="searchBtn" class="layui-btn layui-btn-shop"><i class="layui-icon layui-icon-search"></i></button>
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
	
	
	<div class="shoplist-filter">
		<div class="layui-container">
			<div class="layui-card">
				<!-- 面包屑导航栏 -->
				<div class="layui-card-header">
					<span class="layui-breadcrumb">
						<a href="<%=basePath%>goods/homeGoods">市场首页</a>
						<c:if test="${searchStr != null}">
							<a href="<%=basePath%>goods/category/0">搜索</a>
							<a><cite>${searchStr}</cite></a>
						</c:if>
						<c:if test="${searchStr == null}">
							<a href="<%=basePath%>goods/category/0">类别</a>
							<c:if test="${category.id == 0}">
								<a><cite>最新发布</cite></a>
							</c:if>
							<c:if test="${category.id != 0}">
								<a><cite>${category.name}</cite></a>
							</c:if>
						</c:if>
					</span> 
				</div>
				<div class="layui-card-body">
					<div class="store-cat-item"> <span><i class="layui-icon layui-icon-shop-fenlei"></i>类别：</span>
						<ul id="categoryUl">
							<!-- 物品分类 -->
							<li> <a href="javascript:" onclick="showGoods(this)" data-url="<%=basePath%>goods/category/0">最新发布</a> </li>
							<li> <a href="javascript:" onclick="showGoods(this)" data-url="<%=basePath%>goods/category/1">电子数码</a> </li>
							<li> <a href="javascript:" onclick="showGoods(this)" data-url="<%=basePath%>goods/category/2">生活日用</a> </li>
							<li> <a href="javascript:" onclick="showGoods(this)" data-url="<%=basePath%>goods/category/3">图书教材</a> </li>
							<li> <a href="javascript:" onclick="showGoods(this)" data-url="<%=basePath%>goods/category/4">美妆衣物</a> </li>
							<li> <a href="javascript:" onclick="showGoods(this)" data-url="<%=basePath%>goods/category/5">运动娱乐</a> </li>
							<li> <a href="javascript:" onclick="showGoods(this)" data-url="<%=basePath%>goods/category/6">耳机音响</a> </li>
							<li> <a href="javascript:" onclick="showGoods(this)" data-url="<%=basePath%>goods/category/7">其他闲置</a> </li>
						</ul>
					</div>

					<%--查询总数--%>
					<p class="filtEnd">筛选出:<span id="queryNum"></span></p>

				</div>
			</div>
		</div>
	</div>
	<div class="shop-temp shoplist">
		<div class="temp-normal">
			<div class="layui-container">
				<div class="layui-form">

					<!-- 按照浏览量和发布时间进行排序 待处理 -->
					<div class="layui-input-inline">
						<select lay-filter="storeOrder">
							<option value="auto">综合排序</option>
							<option value="hot">按人气</option>
						</select>
					</div>

				</div>

				<%-- 物品显示模块 --%>
				<div class="layui-row layui-col-space20 shoplist" style="margin:-10px 100px -10px 100px;" id="LAY_demo1">

					<%--此处用于流加载填充内容--%>

				</div>

				<div style="margin: 50px 0 80px; text-align: center;"> </div>
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

	layui.use('flow', function() {
		var flow = layui.flow;

		flow.load({
			elem: '#LAY_demo1' //流加载容器
				,
			/* scrollElem: '#LAY_demo1' //滚动条所在元素，一般不用填，此处只是演示需要。
				, */
			end:'<div class="layui-col-xs12">我也是有底线的~</div>', //用于显示末页内容，可传入任意HTML字符。默认为："没有更多了"
			done: function(page, next) { //执行下一页的回调

				var myDiv = [];
				var categoryId = ${category.id};

				//激活<ul id="categoryUl">下<li>的选中样式
				$("#categoryUl").find('li:eq(' + categoryId +')').addClass("active");

				//整合搜索功能
				var url = categoryId;
				if (${searchStr != null}){
					url += "?search=${searchStr}";
				}

				$.ajax({
					url: "<%=basePath%>goods/categoryPage/" + url,
					data: {"page":page,"rows":8},
					type: "get",
					dataType: "json",
					success: function (result) {
						if (result.flag){//表示查询成功
							var pageHeader = result.data;//获取分页信息
							var goodsExtends = pageHeader.results;//获取分页信息中的数据
							//渲染 筛选个数<span id="queryNum">13</span>
							$("#queryNum").html(pageHeader.count);

							myDiv.push(myDivHtml(goodsExtends));//为myDiv追加html

							//执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
							//pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
							next(myDiv.join(''), page < pageHeader.totalPages);
						}
					}
				});
			}
		});
	});

	function myDivHtml(params){

		var goodsExtends = params;
		var divHtml = "";

		for (var i = 0;i < goodsExtends.length;i++){
			//这里使用js模板的方式填充内容，而不使用字符串拼接。
			var reg = new RegExp("\\[([^\\[\\]]*?)\\]", 'igm'); //i g m是指分别用于指定区分大小写的匹配、全局匹配和多行匹配。
			var html = $("#myDiv").html();//获取js模板中的html代码
			//将myDiv中一些需要填充的变量通过正则表达式替换
			var html1 = html.replace(reg, function (node, key) {

				return {
					'goods_id': goodsExtends[i].goods.id,
					'imgUrl': goodsExtends[i].images[0].imgUrl,
					'name': goodsExtends[i].goods.name,
					'price': goodsExtends[i].goods.price,
					'polishTime': goodsExtends[i].goods.polishTime,
					'pageviews': goodsExtends[i].goods.pageviews

				}[key];});

			divHtml += html1;//拼串
		}

		return divHtml;
	}

</script>

<%--js模板--%>
<script type="text/html" id="myDiv">
	<div class="layui-col-xs12 layui-col-sm6 layui-col-md4 layui-col-lg3">
		<a class="template store-list-box" href="<%=basePath%>goods/goodsId/[goods_id]">
			<%--物品图片--%>
			<img src="<%=basePath%>upload/goods/[imgUrl]" class="store-list-cover">
			<%--物品名称--%>
			<h2 class="layui-elip">[name]</h2>
			<div>
				<!-- 填充物品价格 -->
				<label class="layui-badge-rim store-list-pay" title="价格"> [price] </label><br />
				<!-- 擦亮时间 -->
				<label class="layui-badge-rim store-list-polishdate" title="擦亮时间">擦亮于&nbsp;[polishTime]</label>
				<!-- 浏览量 -->
				<div class="store-list-pageviews" title="浏览量">
					<span><i class="layui-icon layui-icon-log"></i>[pageviews]</span>
				</div>
			</div>
		</a>
	</div>
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

	//点击分类查询
	function showGoods(a) {
		var href = a.getAttribute("data-url");
		var searchStr = $("#searchStr").val();
		if (searchStr == null || $.trim(searchStr).length == 0){
			window.location.href = href;
		} else {
			window.location.href = href + "?search=" + searchStr;
		}
	}
</script>

</body>
</html>
