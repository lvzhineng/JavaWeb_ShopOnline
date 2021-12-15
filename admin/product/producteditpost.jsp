<%--
  Created by IntelliJ IDEA.
  User: 23888
  Date: 2020/4/22
  Time: 22:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ include file="../priv.jsp" %>
<%@ page import="java.util.regex.*,java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%

    //1.提取表单数据
    request.setCharacterEncoding("utf-8");
    String sId=request.getParameter("id");
    String sName = request.getParameter("name");
    String sCategory = request.getParameter("categoryId");
    String sPrice = request.getParameter("price");
    String sShopPrice = request.getParameter("shopPrice");
    String sQuantity = request.getParameter("quantity");
    String sProductStatus = request.getParameter("productStatus");
    String sHot = request.getParameter("hot");
    String sGeneralExplain = request.getParameter("generalExplain");

    //2.表单数据验证
    if (sName==null   || !sName.matches("^.{1,100}$")){
        request.getRequestDispatcher("productedit.jsp").forward(request,response);
        return;
    }
    if (sCategory==null   || !sCategory.matches("^\\d{1,7}$")){
        request.getRequestDispatcher("productedit.jsp").forward(request,response);
        return;
    }
    if (sPrice==null   || !sPrice.matches("^\\d{1,7}(\\.\\d{1,2})?$")){
        request.getRequestDispatcher("productedit.jsp").forward(request,response);
        return;
    }
    if (sShopPrice==null   || !sShopPrice.matches("^\\d{1,7}(\\.\\d{1,2})?$")){
        request.getRequestDispatcher("productedit.jsp").forward(request,response);
        return;
    }
    if (sQuantity==null   || !sQuantity.matches("^\\d{1,7}$")){
        request.getRequestDispatcher("productedit.jsp").forward(request,response);
        return;
    }
    if (sProductStatus==null   || !sProductStatus.matches("^[01]$")){
        request.getRequestDispatcher("productedit.jsp").forward(request,response);
        return;
    }
    if (sHot==null   || !sHot.matches("^[01]$")){
        request.getRequestDispatcher("productedit.jsp").forward(request,response);
        return;
    }
    int price=(int)Double.parseDouble(sPrice)*100;
    int shopPrice=(int)Double.parseDouble(sShopPrice)*100;

    //3.插入数据库
    Connection c=null;
    try{
        java.util.Date date = new java.util.Date();          // 获取一个Date对象
        Timestamp timeStamp = new Timestamp(date.getTime());     //   讲日期时间转换为数据库中的timestamp类型
        Class.forName("com.mysql.jdbc.Driver");
        c = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/shop", "root",
                "000723");
        String sql = "update product set name=?,category_id=?,price=?,shop_price=?,quantity=?,product_status=?,hot=?,general_explain=?,update_time=?,update_user_id=?  " +
                "where id=?";

        PreparedStatement pst = c.prepareStatement(sql);
        pst.setString(1, sName);
        pst.setString(2, sCategory);
        pst.setInt(3, price);
        pst.setInt(4,shopPrice);
        pst.setString(5, sQuantity);
        pst.setString(6, sProductStatus);
        pst.setString(7, sHot);
        pst.setString(8, sGeneralExplain);
        pst.setTimestamp(9,timeStamp);
        pst.setString(10, session.getAttribute("userid").toString());
        pst.setString(11,sId);
        pst.execute();
        response.sendRedirect("productlist.jsp");
        out.print("!");
    } catch (Exception ex) {
        ex.printStackTrace();
        //request.getRequestDispatcher(request.getContextPath()+"/admin/product/productedit.jsp").forward(request,response);
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

