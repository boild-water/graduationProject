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
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
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
		<form class="layui-form" action="" method="">
		
			<!-- orderId隐藏域 -->
			<!-- <input type="hidden" name="orderId" value=""> -->
			
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label" style="width: 100px;">订单ID</label>
					<div class="layui-input-inline" style="width: 150px">
						<input type="text" id="orderId" name="orderId" lay-verify="title" autocomplete="off"
							   value="${orderStatus.orderId}" style="width: 180px" class="layui-input" disabled="">
					</div>
				</div>
			</div>
			

			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label" style="width: 100px;">订单创建时间</label>
					<div class="layui-input-inline">
						<input type="text" id="createTime" name="createTime" autocomplete="off" class="layui-input" 
							value="${orderStatus.createTime}" placeholder="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label" style="width: 100px;">订单支付时间</label>
					<div class="layui-input-inline">
						<input type="text" id="paymentTime" name="paymentTime" autocomplete="off" class="layui-input myDatetime"
							value="${orderStatus.paymentTime}" placeholder="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label" style="width: 100px;">订单发货时间</label>
					<div class="layui-input-inline">
						<input type="text" id="consignTime" name="consignTime" autocomplete="off" class="layui-input myDatetime"
							value="${orderStatus.consignTime}" placeholder="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
				
				<div class="layui-inline">
					<label class="layui-form-label" style="width: 100px;">申请退款时间</label>
					<div class="layui-input-inline">
						<input type="text" id="applyRefundTime" name="applyRefundTime" autocomplete="off" class="layui-input myDatetime"
							value="${orderStatus.applyRefundTime}" placeholder="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
				
			</div>
			<div class="layui-form-item">
				
				<div class="layui-inline">
					<label class="layui-form-label" style="width: 100px;">退款到账时间</label>
					<div class="layui-input-inline">
						<input type="text" id="refundTime" name="refundTime" autocomplete="off" class="layui-input myDatetime"
							value="${orderStatus.refundTime}" placeholder="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label" style="width: 100px;">订单关闭时间</label>
					<div class="layui-input-inline">
						<input type="text" id="closeTime" name="closeTime" autocomplete="off" class="layui-input myDatetime"
							value="${orderStatus.closeTime}" placeholder="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
			</div>
			
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label" style="width: 100px;">订单完成时间</label>
					<div class="layui-input-inline">
						<input type="text" id="endTime" name="endTime" autocomplete="off" class="layui-input myDatetime"
							value="${orderStatus.endTime}" placeholder="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label" style="width: 100px;">订单评价时间</label>
					<div class="layui-input-inline">
						<input type="text" id="commentTime" name="commentTime" autocomplete="off" class="layui-input myDatetime"
							value="${orderStatus.commentTime}" placeholder="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
			</div>
			
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label" style="width: 100px;">订单状态</label>
					<div class="layui-input-inline" style="width: 150px">
						<select name="status" id="statusSelected">
							<option value="1">待付款</option>
							<option value="2">待发货</option>
							<option value="3">待收货</option>
							<option value="6">申请退款中</option>
							<option value="5">订单关闭</option>
							<option value="4">订单完成</option>
							<option value="8">拒绝退款</option>
						</select>
					</div>
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

		//时间日期 遍历所有类为myDatetime的元素，为其添加laydate日期时间组件
		// 不用像上面一样一个个根据id添加
		$('.myDatetime').each(function(){
			laydate.render({
				elem: this,       //使用this指向当前元素,不能使用class名, 否则只有第一个有效
				type: 'datetime'
			});
		});

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var index = layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            }, function () {

                // 关闭弹出层
                layer.close(index);

                var iframeIndex = parent.layer.getFrameIndex(window.name);
                parent.layer.close(iframeIndex);

            });

			$.ajax({
				url: "<%=basePath%>admin/orderStatus/update",
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

            return false;
        });


        //回显订单状态
		$("#statusSelected option[value='${orderStatus.status}']").attr("selected","selected");

		/**
		 * 刷新layui表单 回显<select>元素数据
		 * 此处只需要刷新class="layui-form"的表单中的选择框<select>元素即可
		 */
		form.render('select'); //刷新select选择框渲染

    });
</script>




</body>
</html>