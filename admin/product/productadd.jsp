<%--
  Created by IntelliJ IDEA.
  User: 23888
  Date: 2020/4/19
  Time: 16:48
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
    .div{
        width:660px;
        border:25px;
        padding:100px;
        margin: 0 auto;
    }
</style>
<script src="../../layui/layui.js"></script>
<script>
    layui.use(['element','layer','form'], function(){
        var element = layui.element;
        var layer = layui.layer;
        var form = layui.form;
    });
    form.render();
</script>

<body class="layui-layout layui-layout-admin">
<jsp:include page="../main/top.jsp" />
<div class="layui-body">
    <!-- 内容主体区域 -->
    <link rel="stylesheet" href="layui/css/layui.css">
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
    <script src="layui/layui.js"></script>
    <script>
        layui.use(['element','layer','form'], function(){
            var element = layui.element;
            var layer = layui.layer;
            var form = layui.form;
        });
        form.render();
    </script>


    <body class="layui-layout layui-layout-admin">
    <canvas id="Mycanvas"></canvas>
    <script>
        //定义画布宽高和生成点的个数
        var WIDTH = window.innerWidth, HEIGHT = window.innerHeight, POINT = 35;
        var canvas = document.getElementById('Mycanvas');
        canvas.width = WIDTH,
            canvas.height = HEIGHT;
        var context = canvas.getContext('2d');
        context.strokeStyle = 'rgba(0,0,0,0.2)',
            context.strokeWidth = 1,
            context.fillStyle = 'rgba(0,0,0,0.1)';
        var circleArr = [];
        //线条：开始xy坐标，结束xy坐标，线条透明度
        function Line (x, y, _x, _y, o) {
            this.beginX = x,
                this.beginY = y,
                this.closeX = _x,
                this.closeY = _y,
                this.o = o;
        }
        //点：圆心xy坐标，半径，每帧移动xy的距离
        function Circle (x, y, r, moveX, moveY) {
            this.x = x,
                this.y = y,
                this.r = r,
                this.moveX = moveX,
                this.moveY = moveY;
        }
        //生成max和min之间的随机数
        function num (max, _min) {
            var min = arguments[1] || 0;
            return Math.floor(Math.random()*(max-min+1)+min);
        }
        // 绘制原点
        function drawCricle (cxt, x, y, r, moveX, moveY) {
            var circle = new Circle(x, y, r, moveX, moveY)
            cxt.beginPath()
            cxt.arc(circle.x, circle.y, circle.r, 0, 2*Math.PI)
            cxt.closePath()
            cxt.fill();
            return circle;
        }
        //绘制线条
        function drawLine (cxt, x, y, _x, _y, o) {
            var line = new Line(x, y, _x, _y, o)
            cxt.beginPath()
            cxt.strokeStyle = 'rgba(0,0,0,'+ o +')'
            cxt.moveTo(line.beginX, line.beginY)
            cxt.lineTo(line.closeX, line.closeY)
            cxt.closePath()
            cxt.stroke();
        }
        //初始化生成原点
        function init () {
            circleArr = [];
            for (var i = 0; i < POINT; i++) {
                circleArr.push(drawCricle(context, num(WIDTH), num(HEIGHT), num(15, 2), num(10, -10)/40, num(10, -10)/40));
            }
            draw();
        }
        //每帧绘制
        function draw () {
            context.clearRect(0,0,canvas.width, canvas.height);
            for (var i = 0; i < POINT; i++) {
                drawCricle(context, circleArr[i].x, circleArr[i].y, circleArr[i].r);
            }
            for (var i = 0; i < POINT; i++) {
                for (var j = 0; j < POINT; j++) {
                    if (i + j < POINT) {
                        var A = Math.abs(circleArr[i+j].x - circleArr[i].x),
                            B = Math.abs(circleArr[i+j].y - circleArr[i].y);
                        var lineLength = Math.sqrt(A*A + B*B);
                        var C = 1/lineLength*7-0.009;
                        var lineOpacity = C > 0.03 ? 0.03 : C;
                        if (lineOpacity > 0) {
                            drawLine(context, circleArr[i].x, circleArr[i].y, circleArr[i+j].x, circleArr[i+j].y, lineOpacity);
                        }
                    }
                }
            }
        }
        //调用执行
        window.onload = function () {
            init();
            setInterval(function () {
                for (var i = 0; i < POINT; i++) {
                    var cir = circleArr[i];
                    cir.x += cir.moveX;
                    cir.y += cir.moveY;
                    if (cir.x > WIDTH) cir.x = 0;
                    else if (cir.x < 0) cir.x = WIDTH;
                    if (cir.y > HEIGHT) cir.y = 0;
                    else if (cir.y < 0) cir.y = HEIGHT;
                }
                draw();
            }, 16);
        }
    </script>
    <canvas id="Mycanvas" style="position:fixed;z-index:-1;"></canvas>
    <div class = "layui-body">
        <div>
            <ul>
                <li><a id="liProduct" data-toggle="tab" class="layui-icon layui-icon-face-smile" style="font-size: 30px; color: 	#3300CC;"
                       href="#tab-1">商品信息</a></li><br><br>
            </ul>
        </div>
        <div>
            <div id="tab-1">
                <form name="form_productInfo" action="productaddpost.jsp"
                      method="POST" onsubmit="return validate();" class = "layui-form">
                    <div class = "layui-row">
                        <div class="layui-form-item layui-col-md6" style="text-align: center">
                            <div class="layui-inline">
                                <label class="layui-icon layui-icon-cart" style="font-size: 20px; color: #1E9FFF;">商品名称</label>
                                <div class="layui-input-inline">
                                    <input type="tel" name="name" placeholder="商品名称" required autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class = "layui-col-md6">
                            <div class="layui-inline">
                                <label class="layui-form-label " style="font-size: 20px; color: #1E9FFF;">所属分类</label>
                                <div class="layui-input-block">
                                    <select class="interest" name="categoryId">
                                        <%
                                            Connection c = null;
                                            try {

                                                Class.forName("com.mysql.jdbc.Driver");
                                                c = DriverManager.getConnection("jdbc:mysql://localhost:3306/shop?serverTimezone=UTC", "root",
                                                        "000723");
                                                String sql = "select * from product_category";
                                                PreparedStatement st = c.prepareStatement(sql);
                                                ResultSet rs = st.executeQuery();
                                                while (rs.next()) {
                                        %>
                                        <option value="<%=rs.getInt("id")%>"><%=rs.getString("name")%></option>
                                        <%
                                                }
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
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class = "layui-row">
                        <div class="layui-form-item layui-col-md6" style="text-align: center">
                            <div class="layui-inline">
                                <label class="layui-icon layui-icon-cart" style="font-size: 20px; color: #1E9FFF;">市场价格</label>
                                <div class="layui-input-inline">
                                    <input type="tel" name="price" placeholder="市场价格" required autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class = "layui-col-md6">
                            <div class="layui-inline" style="text-align: center">
                                <label class="layui-icon layui-icon-cart" style="font-size: 20px; color: #1E9FFF;">店内价格</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="shopPrice" placeholder="店内价格" required autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class = "layui-row">
                        <div class="layui-form-item layui-col-md6" style="text-align: center">
                            <div class="layui-inline">
                                <label class="layui-icon layui-icon-cart" style="font-size: 20px; color: #1E9FFF;">商品库存</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="quantity" placeholder="商品库存" required autocomplete="off" class="layui-input">
                                </div>
                            </div>
                        </div>
                        <div class = "layui-col-md6">
                            <div class="layui-inline">
                                <label class="layui-icon layui-icon-cart" style="font-size: 20px; color: #1E9FFF;">商品状态</label>
                                <div class="layui-input-inline">
                                    <select name="productStatus"
                                            class="form-control">
                                        <option value="0" selected>上架</option>
                                        <option value="1">下架</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class = "layui-row">
                        <div class="layui-form-item layui-col-md6" style="text-align: center">
                            <div class="layui-inline" >
                                <label class="layui-icon layui-icon-survey" style="font-size: 20px; color: #1E9FFF;">是否热销</label>
                                <div class="layui-input-block">
                                    <input type="radio" name="hot" value="0" title="是" checked="">
                                    <input type="radio" name="hot" value="1" title="否">
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="layui-col-md6">
                            <div class="layui-form-item layui-form-text">
                                <div class="layui-inline" >
                                    <label class="layui-icon layui-icon-edit" style="font-size: 20px; color: #1E9FFF;">商品概要说明</label>
                                    <div class="layui-input-block">
                                        <textarea name="generalExplain" placeholder="商品概要说明" class="layui-textarea"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-form-row" style="text-align: center">
                        <div class="layui-inline">
                            <button class="layui-btn layui-btn-radius" lay-submit lay-filter="formDemo">立即提交</button>
                            <button type="reset" class="layui-btn layui-btn-radius">重置</button>
                            <button id="back" class="layui-btn layui-btn-radius" type="button"
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
</div>
</html>