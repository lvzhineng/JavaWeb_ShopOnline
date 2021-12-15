<%--
  Created by IntelliJ IDEA.
  User: 23888
  Date: 2020/4/22
  Time: 22:29
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: 23888
  Date: 2020/4/19
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page session="true"%>
<%@include file="../priv.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%
    Connection c = null;
    try {

        Class.forName("com.mysql.jdbc.Driver");
        c = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/shop", "root",
                "root");
        //1、根据传入的ID号获取商品记录
        String sId = request.getParameter("id");
        String sql = "select * from product where id=?";
        PreparedStatement pst = c.prepareStatement(sql);
        pst.setString(1, sId);
        ResultSet rsProduct = pst.executeQuery();
        if (rsProduct.next() == false) {
            response.sendRedirect("productadd.jsp");
            return;
        }
%>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>商城后台</title>
    <link rel="stylesheet" href="../../layui/css/layui.css">
    <script>
        function validate() {
            var name = document.form_productInfo.name.value;
            if (name == null || name.length == 0) {
                document.getElementById("name-error").innerHTML = '请输入商品名!';
                document.getElementById("name-error").style.display = 'block';
                return false;
            }
            return true;
        }
    </script>
</head>
<style>
    .div {
        width: 660px;
        border: 25px;
        padding: 100px;
        margin: 0 auto;
    }
</style>
<script src="../../layui/layui.js"></script>
<script>
    layui.use(['element', 'layer', 'form'], function () {
        var element = layui.element;
        var layer = layui.layer;
        var form = layui.form;
    });
    form.render();
</script>

<body class="layui-layout layui-layout-admin">
<jsp:include page="../main/top.jsp"/>
<div class="layui-body">
    <div>
        <h1 style="text-align: center">商品信息</h1>
    </div>
    <div class="div">
        <div id="tab-1">
            <form name="form_productInfo" action="producteditpost.jsp"
                  method="POST" onsubmit="return validate();" class="layui-form">
                <div class="layui-row">
                    <div class="layui-form-item layui-col-md6" style="text-align: center">
                        <div class="layui-inline">
                            <label class="layui-form-label">商品名称</label>
                            <div class="layui-input-inline">
                                <input type="tel" name="name" value="<%=rsProduct.getString("name")%>" required autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <div class="layui-inline">
                            <label class="layui-form-label">所属分类</label>
                            <div class="layui-input-block">
                                <select class="interest" name="categoryId">
                                    <%
                                        String sqlCategory = "select * from product_category";
                                        PreparedStatement pstCategory = c.prepareStatement(sqlCategory);
                                        ResultSet rs = pstCategory.executeQuery();
                                        while (rs.next()) {
                                    %>
                                    <option value="<%=rs.getInt("id")%>"
                                            <%if (rsProduct.getInt("category_id") == rs.getInt("id")) {%>
                                            selected <%}%>><%=rs.getString("name")%>
                                    </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item layui-col-md6">
                        <div class="layui-inline">
                            <label class="layui-form-label">市场价格</label>
                            <div class="layui-input-inline">
                                <input type="tel" name="price" value="<%=rsProduct.getDouble("price") / 100%>" required
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <div class="layui-inline" style="text-align: center">
                            <label class="layui-form-label">店内价格</label>
                            <div class="layui-input-inline">
                                <input type="text" name="shopPrice" value="<%=rsProduct.getDouble("shop_price") / 100%>"
                                       required autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item layui-col-md6" style="text-align: center">
                        <div class="layui-inline">
                            <label class="layui-form-label">商品库存</label>
                            <div class="layui-input-inline">
                                <input type="text" name="quantity" value="<%=rsProduct.getString("quantity")%>" required
                                       autocomplete="off" class="layui-input">
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <div class="layui-inline">
                            <label class="layui-form-label">状态</label>
                            <div class="layui-input-inline">
                                <select name="productStatus"
                                        class="form-control">
                                    <option value="0"
                                            <%if (rsProduct.getInt("product_status") == 0) {%>
                                            selected <%}%>>上架
                                    </option>
                                    <option value="1"
                                            <%if (rsProduct.getInt("product_status") == 1) {%>
                                            selected <%}%>>下架
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-row">
                    <div class="layui-form-item layui-col-md6" style="text-align: center">
                        <div class="layui-inline">
                            <label class="layui-form-label">是否热销</label>
                            <div class="layui-input-block">
                                <label> <input type="radio" value="0"
                                               class="i-checks" name="hot"
                                        <%if (rsProduct.getInt("hot") == 0) {%>
                                               checked <%}%> />&nbsp;&nbsp;非热门商品
                                </label>&nbsp;&nbsp; <label> <input type="radio" value="1"
                                                                    class="i-checks" name="hot"
                                    <%if (rsProduct.getInt("hot") == 1) {%>
                                                                    checked <%}%> />&nbsp;&nbsp;热门商品
                            </label>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md6">
                        <div class="layui-form-item layui-form-text">
                            <div class="layui-inline">
                                <label class="layui-form-label">商品概要说明</label>
                                <div class="layui-input-block">
                                    <textarea name="generalExplain" placeholder="商品概要说明"
                                              value="<%=rsProduct.getString("general_explain")%>"
                                              class="layui-textarea"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="id" value="<%=sId%>" />
                <div class="layui-form-item" style="text-align: center">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
                        <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                        <button id="back" class="layui-btn" type="button"
                                onclick="window.location='productlist.jsp'">
                            返回
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<%
    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        try {
            if (c != null) {
                c.close();
            }
        } catch (Exception ex) {

        }
    }
%>
</html>