<%--
  Created by IntelliJ IDEA.
  User: 23888
  Date: 2020/4/13
  Time: 16:59
  To change this template use File | Settings | File Templates.
--%>
<%
    session.invalidate();
    response.sendRedirect(request.getContextPath()+"/admin/login/login.jsp");
%>

