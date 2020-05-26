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
	<form class="layui-form" action="" id="personalSettingMotaiForm">
		<div class="layui-form-item">
			<label class="layui-form-label">头像</label>
			<div class="layui-upload layui-input-block">
				<!-- 填充用户头像 -->
				<div id="previewDiv">
					<input name="headImgUrl" id="headImgUrl" value="${user.headImgUrl}" type="hidden">
					<img src="<%=basePath%>upload/user/${user.headImgUrl}" id="headImg" class="layui-nav-img" style="width: 90px;height: 90px;">
					<button type="button" class="layui-btn layui-btn-warm" id="selectImg">选择图片</button>
				</div>
			</div>
		</div>
		<!-- id隐藏域 -->
		<input type="hidden" name="id" value="${user.id}">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">用户名</label>
				<div class="layui-input-inline">
					<input type="text" id="username" name="username" lay-verify="title" autocomplete="off"
						   placeholder="boildwater" class="layui-input" value="${user.username}">
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">手机</label>
				<div class="layui-input-inline">
					<input type="tel" id="phone" name="phone" lay-verify="required|phone" autocomplete="off"
						   class="layui-input" value="${user.phone}">
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<label class="layui-form-label">性别</label>
			<div class="layui-input-block">
				<c:if test="${user.sex == 0}">
					<input type="radio" name="sex" value="0" title="男" checked>
					<input type="radio" name="sex" value="1" title="女">
				</c:if>
				<c:if test="${user.sex == 1}">
					<input type="radio" name="sex" value="0" title="男">
					<input type="radio" name="sex" value="1" title="女" checked>
				</c:if>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">出生日期</label>
				<div class="layui-input-inline">
					<input type="text" id="birthday" name="birthday" lay-verify="date" placeholder="yyyy-MM-dd"
						   autocomplete="off" class="layui-input" value="${user.birthday}">
				</div>
			</div>
		</div>

		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">邮箱</label>
				<div class="layui-input-inline">
					<input type="text" id="email" name="email" lay-verify="email" autocomplete="off"
						   class="layui-input" value="${user.email}">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">QQ</label>
				<div class="layui-input-inline">
					<input type="text" id="qq" name="qq" lay-verify="qq" autocomplete="off"
						   class="layui-input" value="${user.qq}">
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">创建时间</label>
				<div class="layui-input-inline">
					<input type="text" id="createAt" name="createAt" autocomplete="off"
						   class="layui-input" placeholder="yyyy-MM-dd HH:mm:ss" value="${user.createAt}"/>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">上次登录</label>
				<div class="layui-input-inline">
					<input type="text" id="lastLogin" name="lastLogin" autocomplete="off"
						   class="layui-input" placeholder="yyyy-MM-dd HH:mm:ss" value="${user.lastLogin}"/>
				</div>
			</div>
		</div>
		
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">评分</label>
				<div class="layui-input-inline">
					<input type="number" id="power" name="power" lay-verify="" autocomplete="off"
						   class="layui-input" value="${user.power}">
				</div>
			</div>
		</div>
		
		 <div class="layui-form-item">
		    <label class="layui-form-label">是否冻结中</label>
		    <div class="layui-input-block">
				<%-- 加一个隐藏域，js切换按钮时，往隐藏域中设置值
				好处:如果直接在checkbox中添加name="status",传入后端值就变成了 status = "on",还需要后端进一步处理
				--%>
				<input type="hidden" name="status" id="status" value="${user.status}">
				<c:if test="${user.status == 1}">
		      		<input type="checkbox" lay-filter="userStatus" lay-skin="switch" lay-text="是|否">
				</c:if>
				<c:if test="${user.status == 0}">
					<input type="checkbox" lay-filter="userStatus" lay-skin="switch" lay-text="是|否" checked>
				</c:if>
		    </div>
		  </div>

		<div class="layui-form-item">
			<div class="layui-input-block">
				<button type="submit" class="layui-btn" lay-submit="" lay-filter="saveBtn" style="float: right;margin-right: 30px">保存信息</button>
			</div>
		</div>

	</form>
	
</div>	
	
 
<script src="<%=basePath%>layui_mini2/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script>
    layui.use(['form','laydate'], function () {
        var form = layui.form,
            layer = layui.layer,
            $ = layui.$,
			laydate = layui.laydate;
			
		//出生 日期选择器
		laydate.render({
			elem: '#birthday'
		});	
		
		//创建时间 日期时间选择器
		laydate.render({
			elem: '#createAt',
			type: 'datetime'
		});
		//上一次登录 日期时间选择器
		laydate.render({
			elem: '#lastLogin',
			type: 'datetime'
		});

		//是否冻结按钮切换
		form.on('switch(userStatus)', function(obj){
			// layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
			if(obj.elem.checked){
				$("#status").val(0);
			} else {
				$("#status").val(1);
			}
		});

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var index = layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            }, function () {

                //关闭弹出层
                layer.close(index);

                var iframeIndex = parent.layer.getFrameIndex(window.name);
                parent.layer.close(iframeIndex);
				
				$.ajax({
					url: "<%=basePath%>admin/user/update",
					data: data.field,
					type: "post",
					dataType: "json",
					success: function (result) {
						if (result.flag){//表示操作成功

							//刷新上一个页面...历史遗留问题，尚未解决！
							// window.location.replace(document.referrer);
							// location.reload();

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

<!-- 文件上传模块-->
<script>
    layui.use(['upload','jquery'], function () {
        var $ = layui.jquery
            , upload = layui.upload;

        //头像上传
        var uploadInst = upload.render({
            elem: '#selectImg'
            , url: '<%=basePath%>user/uploadFile'  //改成您自己的上传接口
            , before: function (obj) {//提交服务器之前
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    //提交服务器之前，页面预览图片
                    $('#previewDiv img').attr("src",result);
                });
            }
            , done: function (res) {//提交服务器完成后
                //上传失败
                if (res.status > 0) {
                    return layer.msg('上传图片失败');
                } else {
                    $("#headImgUrl").val(res.fileUrl);
                    return layer.msg('上传图片成功', {icon: 1});
                }
            }
            , error: function () {//失败状态，并实现重传

                layer.confirm('图片上传异常，是否重传？', {//询问框
                    btn: ['重传', '取消'] //按钮
                }, function () {
                    uploadInst.upload();//执行重传操作
                }, function () {
                    $('#previewDiv img').attr("src","<%=basePath%>upload/user/user_head_default.jpeg");
                });
            }
        });

    });
</script>


</body>
</html>