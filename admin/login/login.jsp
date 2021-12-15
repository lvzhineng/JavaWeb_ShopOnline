<%--
  Created by IntelliJ IDEA.
  User: 23888
  Date: 2020/4/6
  Time: 21:38
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>后台登录</title>
  <link rel="stylesheet" href="../../layui/css/layui.css">
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
</body>
</head>

<body>
<form class="layui-form" action="LoginPost.jsp" method="post">
  <div class="container">
    <button class="close" title="关闭">X</button>
    <div class="layui-form-mid layui-word-aux">
    </div>
        <%
            Object error = session.getAttribute("error");
            if(error != null)
            {
        %>
              <span style="color: red;align-content: center"> <%=error%>,请重新输入</span>
        <%
          }
        %>
    <div style="font-size: 30px;text-align:center;padding: 10px 15px;font-family: STSong">
      <i class="layui-icon";style="font-size: 30px">&#xe642;</i>后台管理</div>
    <div class="layui-form-item">
      <label class="layui-form-label">用户名</label>
      <div class="layui-input-block">
        <input type="text" name="username" required  lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">密 &nbsp;&nbsp;码</label>
      <div class="layui-input-inline">
        <input type="password" name="password" required lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
      </div>
    </div>
    <div class="layui-form-item">
      <label class="layui-form-label">验证码</label>
      <div class="layui-input-inline">
        <input type="text" name="title" required  lay-verify="required" placeholder="请输入验证码" autocomplete="off" class="layui-input verity">
      </div>
      <canvas id="canvas" width="100" height="40"></canvas>
    </div>
    <div class="layui-form-item">
      <div class="layui-input-block">
        <button class="layui-btn" lay-submit lay-filter="formDemo">登陆</button>
      </div>
    </div>
  </div>
</form>
<script type="text/javascript" src="../../layui/layui.js"></script>
<script>
  layui.use(['form', 'layedit', 'laydate'], function(){
    var form = layui.form
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;
    form.on('submit(demo1)', function(data){
      layer.alert(JSON.stringify(data.field), {
        title: '最终的提交信息'
      })
      return false;
    });

  });
  $(function(){
    var show_num = [];
    draw(show_num);

    $("#canvas").on('click',function(){
      draw(show_num);
    })
    $(".btn").on('click',function(){
      var val = $(".input-val").val().toLowerCase();
      var num = show_num.join("");
      if(val==''){
        alert('请输入验证码！');
      }else if(val == num){
        alert('提交成功！');
        $(".input-val").val('');
        draw(show_num);

      }else{
        alert('验证码错误！请重新输入！');
        $(".input-val").val('');
        draw(show_num);
      }
    })
  })

  function draw(show_num) {
    var canvas_width=$('#canvas').width();
    var canvas_height=$('#canvas').height();
    var canvas = document.getElementById("canvas");//获取到canvas的对象，演员
    var context = canvas.getContext("2d");//获取到canvas画图的环境，演员表演的舞台
    canvas.width = canvas_width;
    canvas.height = canvas_height;
    var sCode = "A,B,C,E,F,G,H,J,K,L,M,N,P,Q,R,S,T,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0";
    var aCode = sCode.split(",");
    var aLength = aCode.length;//获取到数组的长度

    for (var i = 0; i <= 3; i++) {
      var j = Math.floor(Math.random() * aLength);//获取到随机的索引值
      var deg = Math.random() * 30 * Math.PI / 180;//产生0~30之间的随机弧度
      var txt = aCode[j];//得到随机的一个内容
      show_num[i] = txt.toLowerCase();
      var x = 10 + i * 20;//文字在canvas上的x坐标
      var y = 20 + Math.random() * 8;//文字在canvas上的y坐标
      context.font = "bold 23px 微软雅黑";

      context.translate(x, y);
      context.rotate(deg);

      context.fillStyle = randomColor();
      context.fillText(txt, 0, 0);

      context.rotate(-deg);
      context.translate(-x, -y);
    }
    for (var i = 0; i <= 5; i++) { //验证码上显示线条
      context.strokeStyle = randomColor();
      context.beginPath();
      context.moveTo(Math.random() * canvas_width, Math.random() * canvas_height);
      context.lineTo(Math.random() * canvas_width, Math.random() * canvas_height);
      context.stroke();
    }
    for (var i = 0; i <= 30; i++) { //验证码上显示小点
      context.strokeStyle = randomColor();
      context.beginPath();
      var x = Math.random() * canvas_width;
      var y = Math.random() * canvas_height;
      context.moveTo(x, y);
      context.lineTo(x + 1, y + 1);
      context.stroke();
    }
  }

  function randomColor() {//得到随机的颜色值
    var r = Math.floor(Math.random() * 256);
    var g = Math.floor(Math.random() * 256);
    var b = Math.floor(Math.random() * 256);
    return "rgb(" + r + "," + g + "," + b + ")";
  }
  form.render();
</script>
</body>
<style type="text/css">
  #canvas {
    float: left;
    display: inline-block;
    border: 1px solid #ccc;
    border-radius: 5px;
    cursor: pointer;
  }
  .container{
    width: 420px;
    height: 220px;
    min-height: 320px;
    max-height: 320px;
    position: absolute;
    top: 0;
    left: 0;
    bottom: 0;
    right: 0;
    margin: auto;
    padding: 20px;
    z-index: 130;
    border-radius: 8px;
    background-color: #fff;
    box-shadow: 0 3px 18px rgba(100, 0, 0, .5);
    font-size: 16px;
  }
  .close{
    background-color: white;
    border: none;
    font-size: 18px;
    margin-left: 410px;
    margin-top: -10px;
  }

  .layui-input{
    border-radius: 5px;
    width: 300px;
    height: 40px;
    font-size: 15px;
  }
  .layui-form-item{
    margin-left: -20px;
  }
  #logoid{
    margin-top: -16px;
    padding-left:150px;
    padding-bottom: 15px;
  }
  .layui-btn{
    margin-left: -50px;
    border-radius: 5px;
    width: 350px;
    height: 40px;
    font-size: 15px;
  }
  .verity{
    width: 120px;
  }
  .font-set{
    font-size: 13px;
    text-decoration: none;
    margin-left: 120px;
  }
  a:hover{
    text-decoration: underline;
  }

</style>
</html>