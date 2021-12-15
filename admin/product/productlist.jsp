<%--
  Created by IntelliJ IDEA.
  User: 23888
  Date: 2020/4/13
  Time: 15:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat" %>
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
    function delproduct(id){
        layer.open({
            type: 1
            ,title: false //不显示标题栏
            ,closeBtn: false
            ,area: '300px;'
            ,shade: 0.8
            ,id: 'LAY_layuipro' //设定一个id，防止重复弹出
            ,btn: ['确定', '取消']
            ,btnAlign: 'c'
            ,moveType: 1 //拖拽模式，0或者1
            ,content: '<div style="background-color: #393D49; color: #fff;"><h1 style="text-align: center">确认删除</h1></div>'
            ,success: function(layero){
                var btn = layero.find('.layui-layer-btn');
                btn.find('.layui-layer-btn0').attr({
                    href: 'productdel.jsp?id='+id
                    ,target: '_blank'
                });
            }
        });
    }
</script>

<div class="layui-layout layui-layout-admin">
    <jsp:include page="../main/top.jsp"/>
    <div class="layui-body">
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
                int pageIndex=1;
                final int recCountInPage=10;
                int recordCount=0;
                int pageCount=0;
                int start=0;
                int end=0;
                try {

                    Class.forName("com.mysql.jdbc.Driver");
                    c = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop?serverTimezone=UTC", "root",
                            "root");
                    //1.获取当前页码
                    String s=request.getParameter("pageIndex");
                    if (s!=null){
                        pageIndex=Integer.parseInt(s);
                    }
                    //2.获取记录数量
                    String sqlCount="select count(*) as reccount from product";
                    PreparedStatement pstCount=c.prepareStatement(sqlCount);
                    ResultSet rsCount=pstCount.executeQuery();
                    rsCount.next();
                    recordCount=rsCount.getInt("reccount");


                    //3.计算分页信息
                    pageCount=recordCount/recCountInPage+(recordCount%recCountInPage==0?0:1);
                    start=(pageIndex-1)*recCountInPage+1;
                    end=pageIndex*recCountInPage;
                    end=end>recordCount?recordCount:end;


                    //4.分页查询
                    String sql = "select product.*,product_category.name as category_name,user.user_name from product "
                            + "left join product_category on product.category_id =product_category.id   "
                            + "left join user ON  product.update_user_id = user.id   "
                            + "order by product.id desc limit "+(start-1)+" , "+ recCountInPage;

                    PreparedStatement pst = c.prepareStatement(sql);
                    ResultSet rs = pst.executeQuery();
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
                    //out.print(df.format(new java.util.Date()));// new Date()为获取当前系统时间
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
                    out.print(ex);
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
        <div class="col-sm-6"><div class="dataTables_info" id="productInfoList_info" role="status" aria-live="polite">
            显示第<%=start%>至<%=end%>项结果，共<%=recordCount %>项
        </div>
        </div>
        <div id="test" style="text-align: center;"></div>
    </div>
</div>
        <script>
            var pageCount = <%=recordCount%>;
            layui.use('laypage', function(){
                var laypage = layui.laypage;

                //完整功能

                laypage.render({
                    elem: 'test'
                    ,count: pageCount
                    ,layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']
                    ,curr : <%=pageIndex%>
                    ,jump: function(obj, first){
                        //obj包含了当前分页的所有参数，比如：
                        console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                        console.log(obj.limit); //得到每页显示的条数
                        //首次不执行
                        if(!first){
                            window.location.href = 'productlist.jsp?pageIndex='+obj.curr;
                        }
                    }
                });
            });
        </script>
</body>
</html>