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
    <title>订单列表</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=basePath%>layui_mini2/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>layui_mini2/css/public.css" media="all">
	<style>
		/*layui-table 表格内容允许换行 解决layui数据table中，某列内容过长，导致内容隐藏的问题 */
		.layui-table-cell{
		        height: auto;
		        overflow:visible;
		        text-overflow:inherit;
		        white-space:normal;
		    }
	</style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <fieldset class="table-search-fieldset">
            <legend>搜索信息</legend>
            <div style="margin: 10px 10px 10px 10px">
                <form class="layui-form layui-form-pane" action="">
                    <div class="layui-form-item">
                        <div class="layui-inline">
                            <label class="layui-form-label">订单ID</label>
                            <div class="layui-input-inline">
                                <input type="text" name="orderId" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">物品ID</label>
                            <div class="layui-input-inline">
                                <input type="text" name="goodsId" autocomplete="off" class="layui-input">
                            </div>
                        </div>
						<div class="layui-inline">
						    <label class="layui-form-label">买家ID</label>
						    <div class="layui-input-inline">
						        <input type="text" name="userId" autocomplete="off" class="layui-input">
						    </div>
						</div>
						<div class="layui-inline">
						    <label class="layui-form-label">卖家ID</label>
						    <div class="layui-input-inline">
						        <input type="text" name="sellerId" autocomplete="off" class="layui-input">
						    </div>
						</div>
						
						<div class="layui-inline">
						    <label class="layui-form-label">订单金额</label>
						    <div class="layui-input-inline">
						        <input type="text" name="orderPrice" autocomplete="off" class="layui-input">
						    </div>
						</div>
						
						<div class="layui-inline">
						    <label class="layui-form-label">订单类型</label>
							<div class="layui-input-inline">
								<select name="orderType" class="test1">
									<option value="">全部类型</option>
									<option value="0">货到付款</option>
									<option value="1">在线支付</option>
								</select>
							</div>
						</div>
						
                        <div class="layui-inline">
                            <button type="submit" class="layui-btn layui-btn-primary"  lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                        </div>
                    </div>
                </form>
            </div>
        </fieldset>

        <script type="text/html" id="toolbarDemo">
            <div class="layui-btn-container">
                <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加 </button>
                <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除 </button>
            </div>
        </script>

        <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

        <script type="text/html" id="currentTableBar">
			<a class="layui-btn layui-btn-warm layui-btn-xs data-count-edit" lay-event="queryOrderStatus">订单状态</a>
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>
		
		<!-- 订单类型 在线支付or货到付款 -->
		<script type="text/html" id="orderTypeTpl">
			
			{{#  if(d.orderType == 0){ }}
					货到付款
			{{#  } else { }}
					在线支付
			{{#  } }}
			
		</script>
		

    </div>
</div>
<script src="<%=basePath%>layui_mini2/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table;

        table.render({
            elem: '#currentTableId',
            url: '<%=basePath%>admin/orders',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'orderId', width: 180, title: '订单ID', sort: true,align:'center'},
				{field: 'userId', width: 100, title: '买家ID', sort: true,align:'center'},
				{field: 'sellerId', width: 100, title: '卖家ID', sort: true,align:'center'},
				{field: 'goodsId', width: 100, title: '物品ID', sort: true,align:'center'},
				{field: 'addressId', width: 100, title: '地址ID', sort: true,align:'center'},
				/* 这里要填充货到付款还是在线支付 */
                {field: 'orderType', minWidth: 100, title: '订单类型',templet: '#orderTypeTpl',align:'center'},
				{field: 'orderPrice', minWidth: 120, sort: true,title: '订单金额',align:'center'},
				{field: 'orderNote', width: 180, title: '订单备注',edit:'textarea',align:'center'},
				{field: 'createTime', width: 160, sort: true,title: '创建时间',edit:'text',align:'center'},
				/* 这里要填充订单描述状态，未付款，待发货，等待收货等 */
				/* {field: 'status', width: 90,title: '订单状态',templet: 'orderStatusTpl',align:'center'}, */
				
                {title: '操作', minWidth: 250, toolbar: '#currentTableBar', align: "center"}
            ]],
			//自定义分页查询 请求参数 默认为 xxx/xxx?page=xx&limit=xx
			request: {
			    pageName: 'page' //页码的参数名称，默认：page
			    ,limitName: 'rows' //每页数据量的参数名，默认：limit
			},
			//自定义数据返回格式
			parseData: function(res){ //res 即为原始返回的数据
			    return {
			      "code": (res.flag == true?0:1), //解析接口状态
			      "msg": res.message, //解析提示文本
			      "count": res.data.count, //解析数据长度
			      "data": res.data.results //解析数据列表
			    };
			},
            limits: [5, 10, 15, 20, 25, 30],
            limit: 5,
            page: true,
            skin: 'line'
        });
		
        // 监听搜索操作
        form.on('submit(data-search-btn)', function (data) {
            var result = JSON.stringify(data.field);
            layer.alert(result, {
                title: '最终的搜索信息'
            });

            //执行搜索重载
            table.reload('currentTableId', {
                page: {
                    curr: 1
                }
                , where: {
                    searchParams: result
                }
            }, 'data');

            return false;
        });

        /**
         * toolbar监听事件
         */
        table.on('toolbar(currentTableFilter)', function (obj) {
            if (obj.event === 'add') {  // 监听添加操作
                var index = layer.open({
                    title: '删除物品',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '<%=basePath%>admin/orders/add.html',
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            } else if (obj.event === 'delete') {  // 监听删除操作
                var checkStatus = table.checkStatus('currentTableId')
                    , data = checkStatus.data;
                layer.alert(JSON.stringify(data));
            }
        });

        //监听表格复选框选择
        table.on('checkbox(currentTableFilter)', function (obj) {
            console.log(obj)
        });

        table.on('tool(currentTableFilter)', function (obj) {
            var data = obj.data;
            if (obj.event === 'edit') {

                var index = layer.open({
                    title: '编辑订单信息',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '80%'],
                    content: '<%=basePath%>admin/orders/editPage?orderId=' + data.orderId,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('确定删除订单号为'+data.orderId+"的订单吗？", function (index) {
                    obj.del();
                    layer.close(index);

                    $.ajax({
                        url: "<%=basePath%>admin/orders/delete",
                        data: {id:data.id},
                        type: "post",
                        dataType: "json",
                        success: function (result) {
                            if (result.flag){//表示操作成功

                            } else {
                                layer.msg(result.message);
                            }
                        }
                    });
                });
            } else if (obj.event === 'queryOrderStatus'){
                var index = layer.open({
                    title: '编辑物品',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '80%'],
                    content: '<%=basePath%>admin/orderStatus/editPage?orderId=' + data.orderId,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
            }
        });
		
		//监听单元格编辑事件
		table.on('edit(currentTableFilter)', function(obj){
			var value = obj.value //得到修改后的值
			,data = obj.data //得到所在行所有键值
			,field = obj.field; //得到字段
		
			layer.msg('[ID: '+ data.id +'] ' + field + ' 字段更改为：'+ value);

            $.ajax({
                url: "<%=basePath%>admin/orders/updateField",
                //这里有个坑，json数据的字段名不能用变量表示，如：{field:value}就会报错，
                //所以只能这里只能将字段名和其对应的值拆分，然后传递给后台,由后台进行参数处理
                data: {orderId:data.orderId,fieldName:field,updateValue:value},
                type: "post",
                dataType: "json",
                success: function (result) {
                    if (result.flag){//表示操作成功
                        //这里不需要去做任何操作，layui自动完成了页面内容修改
                    } else {
                        layer.msg(result.message);

                    }
                }
            });
		});

    });
	
	
</script>


</body>
</html>