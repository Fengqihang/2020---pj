<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/7/12
  Time: 21:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>

    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>
    <link href="https://cdn.bootcdn.net/ajax/libs/bootstrap-validator/0.5.3/css/bootstrapValidator.min.css" rel="stylesheet">
    <script src="static/pattern/code.js"></script>

    <style>

      #canvas {
          vertical-align: middle;
          box-sizing: border-box;
          border: 1px solid #ddd;
          cursor: pointer;
      }
    </style>
</head>
<body style="background-color: whitesmoke">

<c:if test="${sessionScope.fail!=null}">

    <div class="alert alert-warning fade in" style="margin-left: 30%;margin-right:35%;float: inside" >
        <a href="#" class="close" data-dismiss="alert">
            &times;
        </a>
        <strong>警告: </strong>${sessionScope.fail}
    </div>
</c:if>

<form role="form" action="register?method=login" method="post" style="margin-left: 30%;margin-right:35%">
     <div class="form-group">
         <label for="username" class="col-sm-2 control-label">Username</label><br>
         <input type="text" name="username" id="username" class="form-control"
         value="${sessionScope.wrong.userName}"
         >
     </div>
    <div class="form-group">
        <label for="password" class="col-sm-2 control-label" >Password</label>
        <input type="password" name="password" id="password" class="form-control"
       value="${sessionScope.wrong.password}"
        >
    </div>

    <div class="form-group" >
        <label for="code" class="col-sm-2 control-label" >Code</label>
        <input type="text" name="code" id="code" class="form-control" value="" autocomplete="off">
        <canvas id="canvas" width="100" height="30"></canvas>
    </div>
    <button type="submit" class="btn btn-primary" style="margin-left: 15%">提交</button>
    <button onclick="retur()" class="btn btn-primary" style="margin-left: 15%">返回</button>
</form>




<script>
    window.setTimeout(function(){
        $('[data-dismiss="alert"]').alert('close');
    },2000);

    $(function () {
        var show_num = [];
        draw(show_num);
        $("#canvas").on('click',function(){
            draw(show_num);
        });

        $('form').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空'
                        },
                        stringLength: {
                            min: 4,
                            max: 15,
                            message: '用户名长度必须在4到15位之间'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '用户名只能包含大写、小写、数字和下划线'
                        }
                    }
                },
                password: {
                    message: '密码验证失败',
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 12,
                            message: '密码长度必须在6到12位之间'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '密码只能包含大写、小写、数字和下划线'
                        }
                    }
                },
                code:{
                    message:"验证码验证失败",
                    validators:{
                        notEmpty:{
                            message:"验证码不能为空"
                        },
                        callback:{
                            message:"验证码错误",
                            callback:function (value,validator) {
                                var val = $("#code").val().toLowerCase();
                                var num = show_num.join("");
                                return val===num;
                            }
                        }
                    }
                }
            }
        });

    });

    function retur(){
        window.location.href="home.jsp"
    }

   window.onbeforeunload=function (ev) {
    <% session.removeAttribute("wrong");
    session.removeAttribute("fail");
    %>
}

</script>



</body>

</html>
