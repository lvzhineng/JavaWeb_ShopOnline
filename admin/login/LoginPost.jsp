<%--
  Created by IntelliJ IDEA.
  User: 23888
  Date: 2020/4/13
  Time: 14:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page import="jdk.nashorn.internal.ir.RuntimeNode" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    String URL = "jdbc:mysql://localhost:3306/shop";
    String USER = "root";
    String PASSWORD = "root";

    try {
        //1.加载驱动程序
        Class.forName("com.mysql.jdbc.Driver");
        //2. 获得数据库连接
        Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
        //3.操作数据库，实现增删改查
        Statement stmt = conn.createStatement();
//        ResultSet rs = stmt.executeQuery("SELECT username, password FROM user");
        //如果有数据，rs.next()返回true
        String sql = "select * from user where user_name='" + username+"'" ;
        PreparedStatement st = conn.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        if(rs.next()) {
            String pwd = rs.getString("pwd");
            if(pwd.equals(password)){
                session.setAttribute("user",username);
                session.setAttribute("userid",rs.getInt("id"));
                response.sendRedirect("../main.jsp");
            }else{
                session.setAttribute("error","用户名或者密码错误");
                response.sendRedirect("login.jsp");
            }
        }else{
            session.setAttribute("error","用户名或者密码错误");
            response.sendRedirect("login.jsp");
        }
    }catch (Exception e){
        session.setAttribute("error",e);
        out.print(e);
        response.sendRedirect("login.jsp");
    }


%>
<html>
<head>
    <title>后台</title>
</head>
<body>

</body>
</html>
