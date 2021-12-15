<%--
  Created by IntelliJ IDEA.
  User: 23888
  Date: 2020/4/26
  Time: 22:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true"%>
<%@ page import="java.sql.*"%>
<%@ include file="../priv.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>商城后台</title>
    <link rel="stylesheet" href="../../layui/css/layui.css">
</head>
<body class="layui-layout-body">
<script src="../../layui/layui.js"></script>
<script>
    layui.use(['element','layer'], function(){
        var element = layui.element;
        var layer = layui.layer;

    });
</script>

<div class="layui-layout layui-layout-admin">
    <jsp:include page="../main/top.jsp"/>
    <div class="layui-body">
        <form name="form_productInfo" action="productfind.jsp"
              method="POST" onsubmit="return validate();" class = "layui-form">
            <div class="layui-form-item" style="text-align: center;">
                <div class="layui-inline">
                    <label class="layui-form-label">关键字查询</label>
                    <div class="layui-input-inline">
                        <input type="tel" name="keyword" lay-verify="required|phone" autocomplete="off" class="layui-input">

                    </div>
                </div>
                <button type="submit" class="layui-btn">查询</button>
            </div>
        </form>
        </form>
        <%
            request.setCharacterEncoding("utf-8");
            String keyWord = request.getParameter("keyword");
            if(keyWord!=null){%>
        <div>
            <table class="layui-table">
                <thead>
                <tr role="row">
                    <th >商品名</th>
                    <th >商品分类</th>
                    <th >店内价格</th>
                    <th >市场价格</th>
                    <th >数量</th>
                    <th >热门商品</th>
                    <th >状态</th>
                    <th >更新时间</th>
                    <th >更新者</th>
                    <th >操作</th>
                </tr>
                </thead>
                <tbody>
                <%
                    Connection c = null;

                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        c = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&characterEncoding=utf-8", "root",
                                "root");
                        String sql = "select product.*,product_category.name as category_name,user.user_name from product "
                                + "left join product_category on product.category_id =product_category.id   "
                                + "left join user ON  product.update_user_id = user.id "
                                + "where product.name like ?";

                        keyWord = "%" + keyWord+ "%";

                        PreparedStatement pst = c.prepareStatement(sql);
                        pst.setString(1,keyWord);
                        ResultSet rs = pst.executeQuery();
                        while (rs.next()) {%>
                <tr>
                    <td><%=rs.getString("name") %></td>
                    <td><%=rs.getString("category_name") %></td>
                    <td><%=rs.getDouble("shop_price")/100%></td>
                    <td><%=rs.getDouble("price")/100%></td>
                    <td><%=rs.getString("quantity")%></td>
                    <td>
                        <% if (rs.getInt("hot")==0){ %>
                        是
                        <%}else{ %>
                        否
                        <%} %>
                    </td>
                    <td>
                        <% if (rs.getInt("product_status")==0){ %>
                        已上架
                        <%}else{ %>
                        已下架
                        <%} %>
                    </td>
                    <td><%=rs.getString("update_time")%></td>
                    <td><%=rs.getString("user_name")%></td>
                    <td>
                        <button id="update" class="layui-btn layui-btn-sm" onclick="window.location='productedit.jsp?id=<%=rs.getInt("id")%>'"><i class="fa fa-pencil"></i>编辑</button>&nbsp;&nbsp;
                        <button id="delete" class="layui-btn layui-btn-sm" onclick="window.location='productdel.jsp?id=<%=rs.getInt("id")%>'"><i class="fa fa-pencil"></i>删除</button>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception ex) {
                        ex.printStackTrace();
                    } finally {
                        try {
                            if (c!=null){
                                c.close();
                            }
                        } catch (Exception ex) {

                        }
                    }
                %>
                </tbody>
            </table>

        </div>
    </div>
    <%}%>
</body>
</html>