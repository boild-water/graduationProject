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
    <title>基本资料</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=basePath%>layui_mini2/lib/layui-v2.5.5/css/layui.css" media="all">
    <link rel="stylesheet" href="<%=basePath%>layui_mini2/css/public.css" media="all">
    <style>
        .layui-form-item .layui-input-company {width: auto;padding-right: 10px;line-height: 38px;}
    </style>
</head>
<body>
<div class="layuimini-container">
    <div class="layuimini-main">

        <div class="layui-form layuimini-form">

            <div class="layui-form-item">
                <label class="layui-form-label required">用户名</label>
                <div class="layui-input-block">
                    <input type="text" name="username" lay-verify="required" lay-reqtext="用户名不能为空" placeholder="请输入用户名"  value="${admin.username}" class="layui-input">
                    <%--<tip>填写自己管理账号的名称。</tip>--%>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label required">手机</label>
                <div class="layui-input-block">
                    <input type="text" name="phone" lay-verify="required|phone" lay-reqtext="手机不能为空" placeholder="请输入手机"  value="${admin.phone}" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">邮箱</label>
                <div class="layui-input-block">
                    <input type="email" name="email" placeholder="请输入邮箱"  value="" class="layui-input">
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">备注信息</label>
                <div class="layui-input-block">
                    <textarea name="remark" class="layui-textarea" placeholder="请输入备注信息"></textarea>
                </div>
            </div>

            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn layui-btn-normal" lay-submit lay-filter="saveBtn">确认保存</button>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="<%=basePath%>layui_mini2/lib/layui-v2.5.5/layui.js" charset="utf-8"></script>
<script src="<%=basePath%>layui_mini2/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
<script>
    layui.use(['form','miniTab'], function () {
        var form = layui.form,
            layer = layui.layer,
            miniTab = layui.miniTab;

        //监听提交
        form.on('submit(saveBtn)', function (data) {
            var index = layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            }, function () {
                layer.close(index);
                miniTab.deleteCurrentByIframe();




            });
            return false;
        });

    });
</script>
</body>
</html>