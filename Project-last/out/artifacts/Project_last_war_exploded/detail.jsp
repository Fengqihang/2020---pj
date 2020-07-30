<%@ page import="JavaBeans.TravelImage" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/7/19
  Time: 23:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Detail</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="static/pattern/detail.css" rel="stylesheet" type="text/css">
    <script src="static/pattern/detail.js"></script>

</head>



<body style="background-image: url('static/background/0-4.jpg');height: 80%;width: 100%;background-size: cover;background-repeat: no-repeat">

<%
    String path=request.getContextPath()+"detail?id="+session.getAttribute("imageID");
    session.setAttribute("path",path);%>
<jsp:include page="nav.jsp"></jsp:include>


<c:if test="${requestScope.detail!=null}">
    <table style="margin-top: 5%">
        <tr >
            <td > <table id="table">
                <tr id="painting">
                    <td><h2>${requestScope.detail.title}</h2></td>
                </tr>
                <tr><td>By    <span style="color: red">${requestScope.detail.author}</span></td></tr>
                <tr><td>
                    <div id="demo" style="margin-top: 0">
                        <div id="container">
                            <div id="smallBox">
                                <div id="markBox"></div>
                                <div id="floatBox"></div>
                                <img  src="<%=request.getContextPath()%>static/image/${requestScope.detail.imageFileName}"  alt="">
                            </div>
                            <div id="bigBox">
                                <img src="<%=request.getContextPath()%>static/image/${requestScope.detail.imageFileName}" alt="">
                            </div>
                        </div>
                    </div>
                </td>
                </tr>


            </table></td>
            <td style="text-align: center">
                <p style="font-family: 'Segoe Print';margin-left: 5%;margin-right: 10%">${requestScope.detail.description}</p>


                <c:if test="${sessionScope.user!=null}">
                    <div  style="margin-left: -15%">
                        <button type="button" class="btn btn-default btn-sm" onclick="add()"  id="bt">
                            添加到收藏<span class="glyphicon glyphicon-star-empty" id="g"></span>
                        </button>
                        <button type="button" class="btn btn-default btn-sm"   id="bt1" style="display: none">
                            已收藏<span class="glyphicon glyphicon-star" ></span>
                        </button>
                    </div>
                </c:if>


                <table id="table1" class="table table-hover" style="text-align: center;margin-left: 25%;margin-top: 2%" >
                    <tr>
                        <th colspan="2" id="title1" style="text-align: center;">Details</th>
                    </tr>

                    <tr>
                        <td>Subject:</td>
                        <td>${requestScope.detail.subject}</td>
                    </tr>

                    <tr>
                        <td>Country:</td>
                        <td>${requestScope.detail.country}</td>
                    </tr>
                    <tr>
                        <td>City:</td>
                        <td>${requestScope.detail.city}</td>
                    </tr>
                    <tr>
                        <td>Heat:</td>
                        <td>${requestScope.detail.heat}</td>
                    </tr>
                    <tr>
                        <td>TimeReleased:</td>
                        <td>${requestScope.detail.timeReleased.toLocaleString()}</td>
                    </tr>
                </table></td>
        </tr>
    </table>
</c:if>

<c:if test="${sessionScope.user!=null}">
    <%
          TravelImage detail=(TravelImage)request.getAttribute("detail");
         String IT=detail.getImageID()+","+detail.getTitle();
          Cookie[] cookies=request.getCookies();
        List<Cookie> bc=new ArrayList<Cookie>();
        Cookie tmp=null;

        if (cookies!=null&&cookies.length>0){
            for (Cookie cookie:cookies){
                String cn=cookie.getName();
                if (cn.startsWith("R_")){
                    bc.add(cookie);
                    if (cookie.getValue().equals(IT)){
                        tmp=cookie;
                    }
                }
            }
        }
        if (bc.size()>10&&tmp==null){
            tmp=bc.get(0);
        }
        if (tmp!=null){
            tmp.setMaxAge(0);
            response.addCookie(tmp);
        }

        Cookie cookie=new Cookie("R_"+detail.getImageID(),IT);
        response.addCookie(cookie);

    %>
</c:if>



<script>
function add() {
    $.ajax({
        url:<%=request.getContextPath()%>"/detail",
        data:{
          method:"store",
          add:  ${requestScope.detail.imageID}
        },
        success:function (data) {
            alert(data);
            window.location.reload();
        }
    })
}

$(function () {
    $.ajax({
        url:<%=request.getContextPath()%>"/detail",
        data:{
            method:"checkStore",
            add:  ${requestScope.detail.imageID}
        },
        success:function (data) {
            //显示已收藏

            if (data=="true"){
                document.getElementById("bt").style.display="none";
                document.getElementById("bt1").style.display="inline-block";
            }

        }
    })
})

</script>

</body>




</html>
