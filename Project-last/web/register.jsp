<%@ page import="JavaBeans.Customer" %><%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/7/12
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<title>Register</title>
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

<body style="background-color: whitesmoke">
<c:if test="${sessionScope.message!=null}">

    <div class="alert alert-warning fade in" style="margin-left: 30%;margin-right:35%;float: inside" >
        <a href="#" class="close" data-dismiss="alert">
            &times;
        </a>
        <strong>警告: </strong>${sessionScope.message}
    </div>
</c:if>

<form role="form" action="register?method=register" method="post"   style="margin-left: 30%;margin-right:35%">
    <div class="form-group">
        <label for="username" class="col-sm-2 control-label" >Username</label>
        <input type="text" name="username" id="username" class="form-control" autocomplete="off"
                value="${sessionScope.wrong1.userName}">
    </div>
    <div class="form-group">
        <label for="password" class="col-sm-2 control-label"  >Password</label>
        <input type="password" name="password" id="password" class="form-control"
               value="${sessionScope.wrong1.password}">
    </div>
    <div class="form-group">
        <label for="rePassword" class="col-sm-2 control-label" >rePassword</label>
        <input type="password" name="rePassword" id="rePassword" class="form-control"
               value="${sessionScope.wrong1.password}">
    </div>
    <div class="form-group">
        <label for="email" class="col-sm-2 control-label" >Email</label>
        <input type="text" name="email" id="email" class="form-control"
            value="${sessionScope.wrong1.email}" >
    </div>

    <div class="form-group" >
        <label for="code" class="col-sm-2 control-label" >Code</label>
        <input type="text" name="code" id="code" class="form-control" value="" autocomplete="off">
        <canvas id="canvas" width="100" height="30"></canvas>
    </div>
    <button type="submit" class="btn btn-default" style="margin-left: 15%">提交</button>
    <!-- 实际上重复注册返回时此按钮也就没用了    -->
    <button onclick="retur()" class="btn btn-default" style="margin-left: 18%">返回</button>
</form>

<script>
    function retur(){
        window.location.href="home.jsp"
    }
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
                    message: '用户名验证失败',
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
                rePassword:{
                    validators:{
                        identical:{
                            field:"password",
                            message:"确认密码要和密码保持一致"
                        },
                        notEmpty:{
                           message:"确认密码不能为空"
                        }
                    }
                },
                email: {
                    validators: {
                        notEmpty: {
                            message: '邮箱地址不能为空'
                        },
                        emailAddress: {
                            message: '邮箱地址格式有误'
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


    window.onbeforeunload=function () {
        <% session.removeAttribute("wrong1");
        session.removeAttribute("message");
        %>
    }


</script>
</body>
</html>
