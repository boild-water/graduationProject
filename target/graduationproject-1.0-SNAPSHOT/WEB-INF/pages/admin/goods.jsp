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
    <title>物品管理</title>
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
                            <label class="layui-form-label">ID</label>
                            <div class="layui-input-inline">
                                <input type="text" name="id" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">物品名称</label>
                            <div class="layui-input-inline">
                                <input type="text" name="name" autocomplete="off" class="layui-input">
                            </div>
                        </div>
						<div class="layui-inline">
						    <label class="layui-form-label">物品种类</label>
							<div class="layui-input-inline">
								<select name="categoryId" class="test1">
									<option value="">全部种类</option>
									<option value="1">电子数码</option>
									<option value="2">生活日用</option>
									<option value="3">图书教材</option>
									<option value="4">美妆衣物</option>
									<option value="5">运动娱乐</option>
									<option value="6">耳机音响</option>
									<option value="7">其他闲置</option>
								</select>
							</div>
						</div>
						<div class="layui-inline">
						    <label class="layui-form-label">所属用户</label>
						    <div class="layui-input-inline">
						        <input type="text" name="userId" autocomplete="off" class="layui-input">
						    </div>
						</div>
						<div class="layui-inline">
						    <label class="layui-form-label">是否可讲价</label>
							<div class="layui-input-inline">
								<select name="isBargain" class="test1">
									<option value="">全部</option>
									<option value="0">可讲价</option>
									<option value="1">不可讲价</option>
								</select>
							</div>
						</div>
						<div class="layui-inline">
						    <label class="layui-form-label">物品状态</label>
							<div class="layui-input-inline">
								<select name="status" class="test1">
									<option value="">全部状态</option>
									<option value="1">上架</option>
									<option value="0">下架</option>
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
            <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
            <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
        </script>

        <script type="text/html" id="categoryTpl">
            {{#  if(d.categoryId == 1){ }}
                    电子数码
            {{#  } else if(d.categoryId == 2) { }}
                    生活日用
            {{#  } else if(d.categoryId == 3){ }}
                    图书教材
            {{#  } else if(d.categoryId == 4){ }}
                    美妆衣物
            {{#  } else if(d.categoryId == 5){ }}
                    运动娱乐
            {{#  } else if(d.categoryId == 6){ }}
                    耳机音响
            {{#  } else if(d.categoryId == 7){ }}
                    其他闲置
            {{#  } }}
        </script>
		
		<script type="text/html" id="isBargainTpl">
		  <!-- 这里的 checked 的状态只是演示 -->
		  <input type="checkbox" name="isBargain" value="{{d.id}}" title="可讲价" lay-filter="goodsIsBargain" {{ d.isBargain == 0 ? 'checked' : '' }}>
		</script>
		
		<script type="text/html" id="statusTpl">
		  <!-- 这里的 checked 的状态只是演示 -->
		  <input type="checkbox" name="status" value="{{d.id}}" lay-skin="switch" lay-text="上架|下架" lay-filter="goodsStatus" {{ d.status == 1 ? 'checked' : '' }}>
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
            url: '<%=basePath%>admin/goods',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 80, title: 'ID', sort: true,align:'center'},
				{field: 'name', minWidth: 100, title: '名称',edit:'text',align:'center'},
                {field: 'categoryId', minWidth: 100, title: '种类',templet: '#categoryTpl',align:'center'},
				{field: 'userId', minWidth: 100, title: '所属用户',align:'center'},
				{field: 'description', minWidth: 180, title: '物品描述',edit:'textarea',align:'center'},
				{field: 'price', minWidth: 100, sort: true,title: '现价',align:'center'},
				{field: 'realPrice', minWidth: 100, sort: true,title: '原价',align:'center'},
				{field: 'startTime', width: 160, sort: true,title: '发布时间',edit:'text',align:'center'},
				{field: 'polishTime', width: 160, sort: true,title: '擦亮时间',edit:'text',align:'center'},
				{field: 'pageviews', minWidth: 100, sort: true,title: '浏览量',align:'center'},
				{field: 'isBargain', width: 130, title: '是否可讲价',templet: '#isBargainTpl', unresize: true, align:'center'},
                {field: 'status', width: 100, title: '状态',templet: '#statusTpl', unresize: true, align:'center'},
				
				/* 查看或者修改更多信息，还包括：物品图片、物品详细描述、物品发布地址等信息 */
				
                {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
            ]],
			//自定义分页查询 请求参数 默认为 xxx/xxx?page=xx&limit=xx
			request: {
			    pageName: 'page' //页码的参数名称，默认：page
			    ,limitName: 'rows' //每页数据量的参数名，默认：limit
			},
			//自定义数据返回格式
			parseData: function(res){ //res 即为原始返回的数据
			    return {
			      "code": (res.flag==true?0:1), //解析接口状态
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
                    content: '../page/table/add.html',
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
                    title: '编辑物品',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '80%'],
                    content: '<%=basePath%>admin/goods/editPage?id=' + data.id
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('确定删除id为'+ data.id +'的物品么？', function (index) {
                    obj.del();
                    layer.close(index);
					
					$.ajax({
						url: "<%=basePath%>admin/goods/delete",
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
            }
        });
		
		//监听单元格编辑事件
		table.on('edit(currentTableFilter)', function(obj){
			var value = obj.value //得到修改后的值
			,data = obj.data //得到所在行所有键值
			,field = obj.field; //得到字段
		
			console.log("nihao");
			layer.msg('[ID: '+ data.id +'] ' + field + ' 字段更改为：'+ value);

            $.ajax({
                url: "<%=basePath%>admin/goods/updateField",
                //这里有个坑，json数据的字段名不能用变量表示，如：{field:value}就会报错，
                //所以只能这里只能将字段名和其对应的值拆分，然后传递给后台,由后台进行参数处理
                data: {id:data.id,fieldName:field,updateValue:value},
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
		
		
		//监听是否可讲价操作
		form.on('checkbox(goodsIsBargain)', function(obj){
			// layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
			
			var isBargain = 1;
			if(obj.elem.checked){
                isBargain = 0;
			}
			var id = this.value;
			$.ajax({
				url: "<%=basePath%>admin/goods/updateField",
				data: {id:id,isBargain:isBargain},
				type: "post",
				dataType: "json",
				success: function (result) {
					if (result.flag){//表示操作成功
						if(isBargain == 0){
							layer.msg("已将" + id + "号物品的设为可讲价！");
						} else{
							layer.msg("已将" + id + "号物品的设为不可讲价！")
						}
					} else {
						layer.msg(result.message);
						
					}
				}
			});
			
		});
		
		//监听是否上架操作
		form.on('switch(goodsStatus)', function(obj){
			
			// layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
			
			var status = 0;
			if(obj.elem.checked){
				status = 1;
			}
            var id = this.value;
			$.ajax({
				url: "<%=basePath%>admin/goods/updateField",
				data: {id:id,status:status},
				type: "post",
				dataType: "json",
				success: function (result) {
					if (result.flag){//表示操作成功
                        if(status == 0){
                            layer.msg("已将" + id + "号物品下架！");
                        } else{
                            layer.msg("已将" + id + "号物品上架！");
                        }
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