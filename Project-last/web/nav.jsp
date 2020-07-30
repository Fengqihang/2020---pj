<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/7/26
  Time: 17:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>
    <link href="https://cdn.bootcdn.net/ajax/libs/bootstrap-validator/0.5.3/css/bootstrapValidator.min.css" rel="stylesheet">
</head>
<body>

<c:choose>
    <c:when test="${sessionScope.user==null}">
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand"  style="font-family: 'Segoe Print'">TravelImage</a>
                </div>
                <div class="navbar-right">
                    <!--向右对齐-->
                    <ul class="nav nav-pills" style="font-size: larger">
                        <li><a href="home.jsp">首页</a> </li>
                        <li><a href="search.jsp">搜索</a></li>
                        <li><a href="login.jsp">登录</a></li>
                        <li><a href="register.jsp">注册</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </c:when>

   <c:when test="${sessionScope.user!=null}">
        <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand"  style="font-family: 'Segoe Print'">TravelImage</a>
                </div>
                <div class="navbar-right">
                    <!--向右对齐-->

                    <ul class="nav nav-pills navbar-nav" style="font-size: larger">
                        <li><a href="home.jsp">首页</a> </li>
                        <li><a href="search.jsp">搜索</a></li>
                        <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                ${sessionScope.user.userName}
                                <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu">
                                <li><a href="myCollection.jsp?userID=${sessionScope.user.UID}&userName=${sessionScope.user.userName}">我的收藏</a></li>
                                <li><a href="upload.jsp">上传</a></li>
                                <li><a href="myImage.jsp">我的图片</a></li>
                                <li><a href="myFriend.jsp">我的好友</a></li>
                                <li><a style="cursor: pointer"  onclick="logout()">登出</a></li>
                        </ul>
                    </li>

                    </ul>
                </div>
            </div>
        </nav>
        </c:when>




</c:choose>


<script>
    $(function () {
        $('.dropdown-toggle').dropdown();
    });
    function logout() {
       $.ajax({
           url:<%=request.getContextPath()%>"/register",
           data:{
               method:"logout"
           },
           success:function () {
               window.location.reload();
           }
       })
    }
</script>
</body>
</html>
