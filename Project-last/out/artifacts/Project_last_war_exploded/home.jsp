<%@ page import="JavaBeans.TravelImage" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/7/18
  Time: 21:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>homePage</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body style="background-image: url('static/background/0-9.jpg');width: 95%">
<%
    String path=request.getContextPath()+"home.jsp";
    session.setAttribute("path",path);%>
<c:if test="${requestScope.img==null&&requestScope.ns==null}">
    <% request.getRequestDispatcher("query").forward(request,response); %>
</c:if>
<!--丑死了-->

<jsp:include page="nav.jsp"></jsp:include>

<div id="myCarousel" class="carousel slide" style="margin-top: 4%;margin-left: 20%;height: 50%;width: 60%">
    <!-- 轮播（Carousel）指标 -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0"
            class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
        <li data-target="#myCarousel" data-slide-to="3"></li>
        <li data-target="#myCarousel" data-slide-to="4"></li>
    </ol>
    <div class="carousel-inner">
        <c:if test="${requestScope.img!=null}">
        <c:forEach items="${requestScope.img}" var="heat" varStatus="status">
            <!-- 轮播（Carousel）项目 -->
            <c:choose>
                <c:when test="${status.first}">
                    <div class="item active" style="width: 100%;height: 100%">
                     <a href="detail?id=${heat.imageID}">   <img src=<%=request.getContextPath()%>"/static/image/${heat.imageFileName}" alt="First slide" style="width: 100%;height: 100%">
                        </a></div>
                </c:when>
                <c:otherwise>
                    <div class="item " style="width: 100%;height: 100%">
                        <a href="detail?id=${heat.imageID}">     <img src=<%=request.getContextPath()%>"/static/image/${heat.imageFileName}" alt="slide" style="width: 100%;height: 100%">
                        </a> </div>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
    </c:if>
    <!-- 轮播（Carousel）导航 -->
    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>

</div>

<c:if test="${requestScope.ns!=null}">
    <div class="row" style="margin-left:20%;margin-top: 3%">
        <c:forEach items="${requestScope.ns}" var="news">
            <div class="col-md-3" style="background-image: url('static/background/0-1.jpg');box-shadow: inset 1px -1px 1px #444, inset -1px 1px 1px #444;">
                <a href="detail?id=${news.imageID}"> <img src=<%=request.getContextPath()%>"static/image/${news.imageFileName}" width="120px" height="100px" style="float:top;margin-left: 25%"></a>

                <p style="text-align: center">author:${news.author} </p>
                <p style="text-align: center">subject: ${news.subject}</p>
                <p style="text-align: center">timeReleased:${news.timeReleased.toLocaleString()}</p>

            </div>
        </c:forEach>


    </div>

</c:if>



<script>

$(function () {

   $("#myCarousel").carousel({
        interval: 2500
    })
})
</script>
</body>
</html>
