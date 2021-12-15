<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" import="java.util.*"%>
<%@ page import="jdk.nashorn.internal.ir.LexicalContextNode" %>
<%@ page import="jdk.nashorn.internal.ir.LexicalContext" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>显示所有书籍</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="stylesheet" href="css/layui.css"  media="all">
    <script>
        function btnDelete(id){
            if(confirm("确认删除该条记录吗?"))
                location.href="delete?id="+id; }
    </script>
</head>

<body>
<% 	request.setCharacterEncoding("utf-8");
    String s1=(String)session.getAttribute("NAME");
    if(s1==null)
    {
        response.sendRedirect("error.jsp");
    }
    Calendar now=Calendar.getInstance();
    int year=now.get(Calendar.YEAR);
    int month=now.get (Calendar.MONTH)+1;
    int date=now.get(Calendar.DATE);
%>
<blockquote class="layui-elem-quote layui-quote-nm">
    今天是<%=year %>年<%=month %>月<%=date%>日，欢迎!
</blockquote>
<button class="layui-btn" type="button" onClick="location.href='bookAdd'">添加</button>
<button class="layui-btn layui-btn-normal" type="button" onClick="location.href='/zizhuxuexi/Search/Search.jsp'">查询</button>
<table class="layui-table" lay-even lay-skin="line">
    <colgroup>
        <col width="150">
        <col width="200">
    </colgroup>
    <thead>
    <tr><th>序号</th>
        <th>书号</th>
        <th>书名</th>
        <th>作者</th>
        <th>价格</th>
        <th>类别</th>
        <th>操作</th>
        <th>出版社序号</th>
        <th>出版社名字</th>
        <th>书籍情况</th>
    </tr></thead>
    <tbody>
    <%
        Class.forName("com.mysql.jdbc.Driver");
        //2.获取数据库连接
        //分页
        Connection c = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/mysql", "root", "root");//分页容器
        int pageIndex=1;//默认第一页
        final int recCountInPage=10;//每一页显示10个
        int recordCount=0;//获取在数据库中的数量
        int pageCount=0;
        int start=0;
        int end=0;//当前分页页数显示从多少到多少个信息
        //1.获取当前页码
        String s=request.getParameter("pageIndex");
        if (s!=null){
            pageIndex=Integer.parseInt(s);
        }
        //2.获取记录数量
        String sqlCount="select count(*) as reccount from books";
        PreparedStatement pstCount=c.prepareStatement(sqlCount);
        ResultSet rsCount = pstCount.executeQuery();
        rsCount.next();
        recordCount=rsCount.getInt("reccount");

        //3.计算分页信息
        pageCount=recordCount/recCountInPage+(recordCount%recCountInPage==0?0:1);
        start=(pageIndex-1)*recCountInPage+1;
        end=pageIndex*recCountInPage;
        end=end>recordCount?recordCount:end;

        //4.分页查询
        String sql="select * from books cross join publish cross join state where books.publish=publish.publishId and books.state=state.stateId "
                +"order by books.id desc limit "+(start-1)+" , "+ recCountInPage;
        PreparedStatement pst = c.prepareStatement(sql);
        ResultSet rs = pst.executeQuery();
        while(rs.next()) {%>
    <tr><td><%=rs.getString("bookId") %></td>
        <td><%=rs.getString("bookNumber") %></td>
        <td><%=rs.getString("bookName") %></td>
        <td><%=rs.getString("author") %></td>
        <td><%=rs.getString("price") %></td>
        <td><%=rs.getString("type") %></td>
        <td>
            <a href="edit?id=<%=rs.getString("bookId") %>" class="layui-btn layui-btn-primary layui-btn-sm">编辑</a>&nbsp;
            <a href="bookManagement"onclick="btnDelete('<%=rs.getString("bookId") %>')" class="layui-btn layui-btn-danger layui-btn-sm">删除</a>
        </td>
        <td><%=rs.getString("publishId") %></td>
        <td><%=rs.getString("publishName") %></td>
        <td><%=rs.getString("stateName") %></td>
    </tr></tbody>
    <%} %>
</table>
<%
    rs.close();
    c.close();
%>
<div id="test" style="text-align: center;"></div>
<script src="js/layui.js"></script>
<script>
    layui.use(['element','layer'], function(){
        var element = layui.elemment;
        var layer = layui.layer;
    });</script>

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
                    window.location.href = 'BookManagement.jsp?pageIndex='+obj.curr;
                }
            }
        });
    });

</script>
</body>
</html>