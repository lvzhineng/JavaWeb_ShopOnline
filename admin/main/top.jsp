<%--&lt;%&ndash;--%>
<%--  Created by IntelliJ IDEA.--%>
<%--  User: 23888--%>
<%--  Date: 2020/4/18--%>
<%--  Time: 13:24--%>
<%--  To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="layui-header">
    <div class="layui-logo">商品后台</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
    </ul>
    <ul class="layui-nav layui-layout-right">
        <li class="layui-nav-item">
<%--            <a href="javascript:;">--%>
<%--                <img src="http://t.cn/RCzsdCq" class="layui-nav-img">--%>
<%--                贤心--%>
<%--            </a>--%>
<%--            <dl class="layui-nav-child">--%>
<%--                <dd><a href="">基本资料</a></dd>--%>
<%--                <dd><a href="">安全设置</a></dd>--%>
<%--            </dl>--%>
        </li>
        <li class="layui-nav-item"><a href=<%=request.getContextPath()%>/admin/login/logout.jsp>退出</a></li>
    </ul>
</div>

<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree" lay-filter="test">
            <li class="layui-nav-item layui-nav-itemed">
                <a class="" href="javascript:;" >商品管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="<%=request.getContextPath()%>/admin/product/productlist.jsp">所有商品</a></dd>
                    <dd><a href="<%=request.getContextPath()%>/admin/product/productadd.jsp">添加商品</a></dd>
                    <dd><a href="<%=request.getContextPath()%>/admin/product/productfind.jsp">查询商品</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item"><a href="">有待开发</a></li>
        </ul>
    </div>
</div>