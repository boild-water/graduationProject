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
    <title>编辑物品</title>
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
		
			<!-- id隐藏域 -->
			<input type="hidden" name="id" value="${goodsExtend.goods.id}">

			<div class="layui-form-item">
				<label class="layui-form-label">物品名称</label>
				<div class="layui-input-inline">
					<input type="text" name="name" lay-verify="title" autocomplete="off"
						   value="${goodsExtend.goods.name}" class="layui-input">
				</div>
			</div>

			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">物品分类</label>
					<div class="layui-input-inline" style="width: 150px">
						<select name="categoryId" id="categoryIdSelected">
							<c:forEach items="${categories}" var="category">
								<option value="${category.id}">${category.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">所属用户ID</label>
					<div class="layui-input-inline" style="width: 150px">
						<input type="text" id="userId" name="userId" lay-verify="title" autocomplete="off"
							   class="layui-input" disabled value="${goodsExtend.goods.userId}">
					</div>
					<!-- 查看该用户 -->
					<div class="layui-form-mid layui-word-aux" style="padding: 0 !important;">
						<button lay-submit="" lay-filter="queryUser" class="layui-btn layui-btn-normal" title="查看发布者">
							<%-- 使用图标代替文字 --%>
							<i class="fa fa-user" style="width: 14px;height: 14px"></i>
						</button>
					</div>
				</div>
			</div>

			<div class="layui-form-item layui-form-text">
				<label class="layui-form-label">物品描述</label>
				<div class="layui-input-block">
					<textarea name="description" class="layui-textarea">${goodsExtend.goods.description}</textarea>
				</div>
			</div>

			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">物品原价</label>
					<div class="layui-input-inline" style="width: 100px;">
						<input type="text" name="realPrice" value="${goodsExtend.goods.realPrice}"
							   autocomplete="off" class="layui-input">
					</div>
					<label class="layui-form-label">物品现价</label>
					<div class="layui-input-inline" style="width: 100px;">
						<input type="text" name="price" value="${goodsExtend.goods.price}" autocomplete="off"
							   class="layui-input">
					</div>
				</div>
			</div>

			<div class="layui-form-item">
				<div class="layui-input-inline">
					<label class="layui-form-label">是否可讲价</label>
					<div class="layui-input-block">
						<%-- js监听开关切换，为隐藏域设置值 --%>
						<input type="hidden" id="isBargain" name="isBargain" value="${goodsExtend.goods.isBargain}">
						<c:if test="${goodsExtend.goods.isBargain == 0}">
							<input type="checkbox" checked="" lay-skin="switch" lay-filter="isBargain" lay-text="是|否">
						</c:if>
						<c:if test="${goodsExtend.goods.isBargain == 1}">
							<input type="checkbox" lay-skin="switch" lay-filter="isBargain" lay-text="是|否">
						</c:if>
					</div>
				</div>
				<div class="layui-input-inline">
					<label class="layui-form-label">是否上架</label>
					<div class="layui-input-block">
						<%-- js监听开关切换，为隐藏域设置值 --%>
						<input type="hidden" id="status" name="status" value="${goodsExtend.goods.status}">
						<c:if test="${goodsExtend.goods.status == 1}">
							<input type="checkbox" checked="" lay-skin="switch" lay-filter="status" lay-text="是|否">
						</c:if>
						<c:if test="${goodsExtend.goods.status == 0}">
							<input type="checkbox" lay-skin="switch" lay-filter="status" lay-text="是|否">
						</c:if>
					</div>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">物品地址</label>
				<div class="layui-input-inline" style="width: 160px">
					<select name="addressDescUtil.campusName" id="campusNameSelected">
						<option value="">请选择学校</option>
						<option value="安徽工程大学">安徽工程大学</option>
						<option value="安徽大学">安徽大学</option>
						<option value="合肥工业大学">合肥工业大学</option>
					</select>
				</div>
				<div class="layui-input-inline" style="width: 160px">
					<select name="addressDescUtil.dormitoryBuilding" id="dormitoryBuildingSelected">
						<option value="">请选择宿舍楼</option>
						<option value="男生宿舍12栋">男生宿舍12栋</option>
						<option value="男生宿舍13栋">男生宿舍13栋</option>
						<option value="女生宿舍6栋">女生宿舍6栋</option>
						<option value="女生宿舍8栋">女生宿舍8栋</option>
					</select>
				</div>
				<div class="layui-input-inline" style="width: 120px;">
					<input class="layui-input" type="text" name="addressDescUtil.dormitoryNum" id="" placeholder="请输入房间号"
						   value="${goodsExtend.goods.addressDescUtil.dormitoryNum}"/>
				</div>
			</div>
			
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">发布时间</label>
					<div class="layui-input-inline">
						<input type="text" id="startTime" name="startTime" autocomplete="off"
							   class="layui-input" value="${goodsExtend.goods.startTime}" placeholder="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
				<div class="layui-inline">
					<label class="layui-form-label">擦亮时间</label>
					<div class="layui-input-inline">
						<input type="text" id="polishTime" name="polishTime" autocomplete="off"
							   class="layui-input" value="${goodsExtend.goods.startTime}" placeholder="yyyy-MM-dd HH:mm:ss"/>
					</div>
				</div>
			</div>
			
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">浏览量</label>
					<div class="layui-input-inline">
						<input type="number" id="pageviews" name="pageviews" autocomplete="off"
							   class="layui-input" value="${goodsExtend.goods.pageviews}">
					</div>
				</div>
			</div>

			<!-- 物品图片上传框-->
			<div class="layui-form-item" style="text-align: center;">
				<!-- 支持多图片文件上传-->
				<div class="layui-upload">
					<blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;">
						<div class="layui-upload-list" id="goodsPreviewDiv">
							<img src="<%=basePath%>upload/goods/${goodsExtend.images[0].imgUrl}" alt=""
								 class="layui-upload-img" style="max-width: 196px">
						</div>
						<input name="imgUrl" value="${goodsExtend.images[0].imgUrl}" type="hidden">
					</blockquote>
					<button type="button" class="layui-btn layui-btn-primary layui-btn-radius" id="selectGoodsImg">选择图片</button>
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
		
		//物品发布时间 日期时间选择器
		laydate.render({
			elem: '#startTime',
			type: 'datetime'
		});
		//物品擦亮时间 日期时间选择器
		laydate.render({
			elem: '#polishTime',
			type: 'datetime'
		});

		//监听是否可讲价开关切换
		form.on('switch(isBargain)',function (obj) {
			if(obj.elem.checked){
				$("#isBargain").val(0);
			} else{
				$("#isBargain").val(1);
			}
		});

		//监听是否可讲价开关切换
		form.on('switch(status)',function (obj) {
			if(obj.elem.checked){
				$("#status").val(1);
			} else {
				$("#status").val(0);
			}
		});

		//监听“查看该用户”按钮提交
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
					url: "<%=basePath%>admin/goods/update",
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

        //回显物品分类信息<select><option></option></select>
		$("#categoryIdSelected option[value='${goodsExtend.goods.categoryId}']").attr("selected", "selected");
		//页面回显学校名称种类<select><option></option></select>
		$("#campusNameSelected option[value='${goodsExtend.goods.addressDescUtil.campusName}']").attr("selected", "selected");
		//页面回显宿舍楼层名称<select><option></option></select>
		$("#dormitoryBuildingSelected option[value='${goodsExtend.goods.addressDescUtil.dormitoryBuilding}']").attr("selected", "selected");

		/**
		 * 刷新layui表单 回显<select>元素数据
		 * 此处只需要刷新class="layui-form"的表单中的选择框<select>元素即可
		 */
		form.render('select'); //刷新select选择框渲染
    });
</script>

<!-- 文件上传模块-->
<script>
    layui.use('upload', function () {
        var $ = layui.jquery
            , upload = layui.upload;

        //多图片上传
        var uploadInst = upload.render({
            elem: '#selectGoodsImg'
            , url: '<%=basePath%>goods/uploadFile' //改成您自己的上传接口
            , multiple: true
            , before: function (obj) {//提交服务器之前
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    //首先清空goodsPreviewDiv(这样只适合上传物品的一张图片，做上传多物品图片功能再看看如何修改)
                    $('#goodsPreviewDiv').empty();
                    //然后再将新图片添加上去
                    $('#goodsPreviewDiv').append('<img src="' + result + '" alt="' + file.name + '" class="layui-upload-img"' + ' style="max-width: 196px">')
                });
            }
            , done: function (res) {//提交服务器完成后
                //上传失败
                if (res.status > 0) {
                    return layer.msg('上传图片失败');
                } else {
                    $("input[name='imgUrl']").val(res.fileUrl);
                    return layer.msg('上传图片成功', {icon: 1});
                }
            }
            , error: function () {//失败状态，并实现重传

                layer.confirm('图片上传异常，是否重传？', {//询问框
                    btn: ['重传', '取消'] //按钮
                }, function () {
                    uploadInst.upload();//执行重传操作
                }, function () {
                    $("#goodsPreviewDiv").empty();//清空所有的预览div中的所有图片
                });
            }
        });

    });
</script>


</body>
</html>