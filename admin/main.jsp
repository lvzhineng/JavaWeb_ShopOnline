<%--
  Created by IntelliJ IDEA.
  User: 23888
  Date: 2020/4/13
  Time: 15:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true"%>
<%@page import="java.sql.*" %>
<%@ include file="priv.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>商城后台</title>
    <link rel="stylesheet" href="../layui/css/layui.css">
</head>

<body class="layui-layout layui-layout-admin ">
<jsp:include page="main/top.jsp"/>
    <div class="layui-body">
    <h1>欢迎使用！</h1>
    </div>

</div>
<script src="../layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
</script>
</body>
</html>