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
    <title>用户管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=basePath%>layui_mini2/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>layui_mini2/css/public.css" media="all">
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
                            <label class="layui-form-label">用户名</label>
                            <div class="layui-input-inline">
                                <input type="text" name="username" autocomplete="off" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-inline">
                            <label class="layui-form-label">手机号</label>
                            <div class="layui-input-inline">
                                <input type="text" name="phone" autocomplete="off" class="layui-input">
                            </div>
                        </div>
						<div class="layui-inline">
						    <label class="layui-form-label">用户性别</label>
							<div class="layui-input-inline">
								<select name="sex" class="test1">
									<option value="">全部性别</option>
									<option value="0">男</option>
									<option value="1">女</option>
								</select>
							</div>
						</div>
						<div class="layui-inline">
						    <label class="layui-form-label">用户状态</label>
							<div class="layui-input-inline">
								<select name="status" class="test1">
									<option value="">全部状态</option>
									<option value="0">冻结中</option>
									<option value="1">正常</option>
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
		
		<!-- 添加de内容位置********************* -->
		
		<script type="text/html" id="sexTpl">
		  <!-- 这里的 checked 的状态只是演示 -->
		  <input type="checkbox" name="sex" value="{{d.id}}" lay-skin="switch" lay-text="男|女" lay-filter="userSex" {{ d.sex == 0 ? 'checked' : '' }}>
		</script>
		
		<script type="text/html" id="statusTpl">
		  <!-- 这里的 checked 的状态只是演示 -->
		  <input type="checkbox" name="status" value="{{d.id}}" title="冻结" lay-filter="userStatus" {{ d.status == 0 ? 'checked' : '' }}>
		</script>

    </div>
</div>
<script src="<%=basePath%>layui_mini2/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form', 'table','laydate'], function () {
        var $ = layui.jquery,
            form = layui.form,
            table = layui.table,
			laydate = layui.laydate;

        table.render({
            elem: '#currentTableId',
            url: '<%=basePath%>admin/user',
            toolbar: '#toolbarDemo',
            defaultToolbar: ['filter', 'exports', 'print', {
                title: '提示',
                layEvent: 'LAYTABLE_TIPS',
                icon: 'layui-icon-tips'
            }],
            cols: [[
                {type: "checkbox", width: 50},
                {field: 'id', width: 80, title: 'ID', sort: true,align:'center'},
                {field: 'username', minWidth: 100, title: '用户名',edit:'text',align:'center'},
				{field: 'phone',width:150, title: '手机号',edit:'text',align:'center'},
                {field: 'sex', width: 80, title: '性别',templet: '#sexTpl', unresize: true, align:'center'},
				{field: 'birthday', width: 120, title: '出生日期',edit:'text',align:'center'},
				{field: 'email', width: 180, title: 'email',edit:'text',align:'center'},
				{field: 'qq', width: 120, title: 'QQ',edit:'text',align:'center'},
				{field: 'createAt', width: 160, title: '创建时间',sort: true,edit:'text',align:'center'},
				{field: 'lastLogin', width: 160, title: '上次登录',sort: true,edit:'text',align:'center'},
				{field: 'power', width: 100, title: '评分', sort: true,align:'center'},
				{field: 'status', title:'是否冻结', width:100, templet: '#statusTpl', unresize: true,align:'center'},
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
                    title: '添加用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['100%', '100%'],
                    content: '../page/user/add.html',
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
                    title: '编辑用户',
                    type: 2,
                    shade: 0.2,
                    maxmin:true,
                    shadeClose: true,
                    area: ['60%', '80%'],
                    content: '<%=basePath%>admin/user/editPage?id='+data.id,
                });
                $(window).on("resize", function () {
                    layer.full(index);
                });
                return false;
            } else if (obj.event === 'delete') {
                layer.confirm('确定删除id为'+ data.id +'的用户么？', function (index) {

                    obj.del();//缓存上删除本行
                    layer.close(index);
					
					$.ajax({
						url: "<%=basePath%>admin/user/delete",
						data: {id:data.id},
						type: "post",
						dataType: "json",
						success: function (result) {
							if (result.flag){//表示操作成功
								//上面已经从缓存中删除本行了 obj.del() 此处不需要额外处理
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
			
			//日期 遍历所有类为mydate的元素，为其添加laydate组件
			// $('.mydate').each(function(){
			// 	laydate.render({
			// 		elem: this       //使用this指向当前元素,不能使用class名, 否则只有第一个有效
			// 	});
			// });
			
			
			var value = obj.value //得到修改后的值
			,data = obj.data //得到所在行所有键值
			,field = obj.field; //得到字段
		
			layer.msg('[ID: '+ data.id +'] ' + field + ' 字段更改为：'+ value);
			
			// var object = "{id:'" + data.id + "'," + field + ":'" + value + "'}";
			// layer.msg(JSON.stringify(object));
			
			$.ajax({
				url: "<%=basePath%>admin/user/updateField",
				//这里有个坑，json数据的字段名不能用变量表示，如：{field:value}就会报错，
				//所以只能这里只能将字段名和其对应的值拆分，然后传递给后台,由后台进行参数处理
				data: {id:data.id,fieldName:field,updateValue:value},
				type: "post",
				dataType: "json",
				success: function (result) {
					if (result.flag){//表示操作成功
						//这里不需要去做任何操作，layui自动完成了页面内容修改
                        //也不需要刷新页面

					} else {
						layer.msg(result.message);
					}
				}
			});
			
		});
		
		
		//监听性别操作
		form.on('switch(userSex)', function(obj){
			// layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
			var sex = 1;
			if(obj.elem.checked){
				sex = 0;
			}
			$.ajax({
				url: "<%=basePath%>admin/user/updateField",
				data: {id:this.value,sex:sex},
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
		
		//监听是否冻结操作
		form.on('checkbox(userStatus)', function(obj){
			// layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
			var status = 1;
			if(obj.elem.checked){
                layer.tips('冻结用户，会导致用户无法登录哦');
				status = 0;
			}
			var id = this.value;
			$.ajax({
				url: "<%=basePath%>admin/user/updateField",
				data: {id:id,status:status},
				type: "post",
				dataType: "json",
				success: function (result) {
					if (result.flag){//表示操作成功
						if(status == 0){
							layer.msg("冻结id为" + id + "的用户成功！");
						} else{
							layer.msg("id为" + id + "的用户解冻成功！")
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