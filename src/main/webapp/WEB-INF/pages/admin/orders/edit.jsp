<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>订单修改</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" href="<%=basePath%>layui_mini2/lib/font-awesome-4.7.0/css/font-awesome.min.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>layui_mini2/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>layui_mini2/css/public.css" media="all">
    <style>
        body {
            background-color: #ffffff;
        }
    </style>
</head>
<body>
<div style="">
	<div style="">
		<form class="layui-form" action="<%=basePath%>goods/editGoodsSubmit" method="post">
		
			<!-- orderId隐藏域 -->
			<!-- <input type="hidden" name="orderId" value=""> -->
			
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">订单ID</label>
					<div class="layui-input-inline" style="width: 150px">
						<input type="text" id="orderId" name="orderId" lay-verify="title" autocomplete="off"
							   value="${order.orderId}" style="width: 180px" class="layui-input" disabled="">
					</div>
				</div>
			</div>
			
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">买家ID</label>
					<div class="layui-input-inline" style="width: 150px">
						<input type="text" id="userId" name="userId" lay-verify="title" autocomplete="off"
							   value="${order.userId}" placeholder="xxx" class="layui-input" disabled>
					</div>
					<!-- 查看买家 -->
					<div class="layui-form-mid layui-word-aux" style="padding: 0 !important;">
						<button lay-submit="" lay-filter="queryUser" class="layui-btn layui-btn-normal" title="查看该买家">
							<%-- 使用图标代替文字 --%>
							<i class="fa fa-user" style="width: 14px;height: 14px"></i>
						</button>
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">卖家ID</label>
					<div class="layui-input-inline" style="width: 150px">
						<input type="text" id="sellerId" name="sellerId" lay-verify="title" autocomplete="off"
							   value="${order.sellerId}" placeholder="xxx" class="layui-input" disabled>
					</div>
					<!-- 查看卖家 -->
					<div class="layui-form-mid layui-word-aux" style="padding: 0 !important;">
						<button lay-submit="" lay-filter="querySeller" class="layui-btn layui-btn-normal" title="查看该卖家">
							<%-- 使用图标代替文字 --%>
							<i class="fa fa-user" style="width: 14px;height: 14px"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">物品ID</label>
					<div class="layui-input-inline" style="width: 150px">
						<input type="text" id="goodsId" name="goodsId" lay-verify="title" autocomplete="off"
							   value="${order.goodsId}" placeholder="xxx" class="layui-input" disabled>
					</div>
					<!-- 查看物品 -->
					<div class="layui-form-mid layui-word-aux" style="padding: 0 !important;">
						<button lay-submit="" lay-filter="queryGoods" class="layui-btn layui-btn-normal" title="查看该物品">
							<%-- 使用图标代替文字 --%>
							<i class="fa fa-archive" style="width: 14px;height: 14px"></i>
						</button>
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">地址ID</label>
					<div class="layui-input-inline" style="width: 150px">
						<input type="text" id="addressId" name="addressId" lay-verify="title" autocomplete="off"
							   value="${order.addressId}" placeholder="xxx" class="layui-input" disabled>
					</div>
					<!-- 查看地址 -->
					<div class="layui-form-mid layui-word-aux" style="padding: 0 !important;">
						<button lay-submit="" lay-filter="queryAddress" class="layui-btn layui-btn-normal" title="查看该地址">
							<%-- 使用图标代替文字 --%>
							<i class="fa fa-map-marker" style="width: 14px;height: 14px"></i>
						</button>
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">订单金额</label>
					<div class="layui-input-inline" style="width: 150px">
						<input type="text" id="orderPrice" name="orderPrice" lay-verify="title" autocomplete="off"
							   value="${order.orderPrice}" placeholder="99.00" class="layui-input">
					</div>
				</div>
			</div>
			
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">订单类型</label>
					<div class="layui-input-inline" style="width: 150px">
						<select name="orderType" id="categoryIdSelected">
							<c:if test="${order.orderType == 0}">
								<option value="0" selected>货到付款</option>
								<option value="1">在线支付</option>
							</c:if>
							<c:if test="${order.orderType == 1}">
								<option value="0">货到付款</option>
								<option value="1" selected>在线支付</option>
							</c:if>
						</select>
					</div>
				</div>
			</div>
			
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">创建时间</label>
					<div class="layui-input-inline">
						<input type="text" id="createTime" name="createTime" autocomplete="off" class="layui-input" 
							value="${order.createTime}" placeholder="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
			</div>
			
			<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">订单备注</label>
				<div class="layui-input-block">
					<textarea name="orderNote" class="layui-textarea">${order.orderNote}</textarea>
				</div>
			</div>
			
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button type="submit" class="layui-btn layui-btn-danger" lay-submit="" lay-filter="saveBtn" style="float: right">保存修改</button>
				</div>
			</div>
		</form>
	</div>
	
</div>	
	
 
<script src="<%=basePath%>layui_mini2/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form','laydate'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$,
			laydate = layui.laydate;
		
		//订单创建时间 日期时间选择器
		laydate.render({
			elem: '#createTime',
			type: 'datetime'
		});

		//监听“查看该买家”按钮提交
		form.on('submit(queryUser)', function (data) {

			var index = layer.open({
				title: '编辑用户',
				type: 2,
				shade: 0.2,
				maxmin:true,
				shadeClose: true,
				area: ['100%', '100%'],
				content: '<%=basePath%>admin/user/editPage?id=' + data.field.userId
			});

			return false;
		});

		//监听“查看该卖家”按钮提交
		form.on('submit(querySeller)', function (data) {

			var index = layer.open({
				title: '编辑用户',
				type: 2,
				shade: 0.2,
				maxmin:true,
				shadeClose: true,
				area: ['100%', '100%'],
				content: '<%=basePath%>admin/user/editPage?id=' + data.field.sellerId
			});

			return false;
		});

		//监听“查看该物品”按钮提交
		form.on('submit(queryGoods)', function (data) {

			var index = layer.open({
				title: '编辑物品',
				type: 2,
				shade: 0.2,
				maxmin:true,
				shadeClose: true,
				area: ['100%', '100%'],
				content: '<%=basePath%>admin/goods/editPage?id=' + data.field.goodsId
			});

			return false;
		});

		//监听“查看该地址”按钮提交
		form.on('submit(queryAddress)', function (data) {

			var index = layer.open({
				title: '编辑地址',
				type: 2,
				shade: 0.2,
				maxmin:true,
				shadeClose: true,
				area: ['100%', '100%'],
				content: '<%=basePath%>admin/address/editPage?id=' + data.field.addressId
			});

			return false;
		});

        //监听“保存修改”按钮提交
        form.on('submit(saveBtn)', function (data) {
            var index = layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            }, function () {

                // 关闭弹出层
                layer.close(index);

                var iframeIndex = parent.layer.getFrameIndex(window.name);
                parent.layer.close(iframeIndex);

				$.ajax({
					url: "<%=basePath%>admin/orders/update",
					data: data.field,
					type: "post",
					dataType: "json",
					success: function (result) {
						if (result.flag){//表示操作成功

							//刷新当前页面...

						} else {
							layer.msg(result.message);
						}
					}
				});

            });

            return false;
        });

    });
</script>




</body>
</html>