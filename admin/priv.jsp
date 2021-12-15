<%--
  Created by IntelliJ IDEA.
  User: 23888
  Date: 2020/4/13
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%--<%@ page contentType="text/html;" language="java" %>--%>
<%
    Object user = session.getAttribute("user");
    if(user == null){
        response.sendRedirect(request.getContextPath()+"/admin/login/login.jsp");
        return;
    }
%>
