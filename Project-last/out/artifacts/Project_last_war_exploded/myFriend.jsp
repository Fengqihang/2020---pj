<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/7/28
  Time: 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>myFriend</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
<c:choose>
    <c:when test="${sessionScope.user!=null}">
        <jsp:include page="nav.jsp"></jsp:include>
        <div class="container" style="margin-top: 5%" >

            <table class="table table-striped">
                <caption>我的好友</caption>
                <thead>
                <tr>
                    <th>userName</th>
                    <th>email</th>
                    <th>timeRegistered</th>
                </tr>
                </thead>
                <tbody id="t">

                </tbody>
            </table>


            <div style="margin-top: 3%;margin-left: 40%" >
                <ul class="pagination"  id="pageTable"></ul>

            </div>

        </div>
    </c:when>
    <c:otherwise>
        <script>window.location.href="home.jsp"</script>
    </c:otherwise>
</c:choose>




<script>

    $(function () {
        $.ajax({
            url:<%=request.getContextPath()%>"/friend",
            data:{
                method:"show"
            },
            success:function (data) {
                var list=eval("("+data+")");
                    $("#t").empty();
                for (var i=0;i<list.length;i++){
                    $("#t").append("<tr class='tr'>" +
                        "<td>"+ "<a href='<%=request.getContextPath()%>/myCollection.jsp?userID="+list[i].UID+"" +
                        "&userName=" +list[i].userName+
                        "'>"+
                         list[i].userName+
                        "</a></td>" +
                        "<td>"+list[i].email+"</td>" +
                        "<td>" +list[i].date+
                        "</td>" +
                        "</tr>");

                }
            }
        })
    })
</script>



</body>
</html>
