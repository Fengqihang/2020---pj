<%@ page import="ExtendTools.ImageDaoJdbc" %>
<%@ page import="java.util.List" %>
<%@ page import="JavaBeans.TravelImage" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/7/19
  Time: 23:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<html>
<head>
    <title>Search</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body style="background-color:whitesmoke">
<%
    String path=request.getContextPath()+"search.jsp";
    session.setAttribute("path",path);%>
         <jsp:include page="nav.jsp"></jsp:include>

      <div style="float: right;margin-top: 4%;margin-right: 5%" >
        <input type="text" name="key"><input type="button" value="search" onclick="search()">
        <div style="box-shadow: inset 1px -1px 1px #444, inset -1px 1px 1px #444;">
        <label class="radio-inline">
            <input type="radio" name="first"  value="title" checked onchange="search()"> title
        </label>
        <label class="radio-inline">
            <input type="radio" name="first"  value="subject" onchange="search()">subject
        </label>
    </div>
        <div style="box-shadow: inset 1px -1px 1px #444, inset -1px 1px 1px #444;">
            <label class="radio-inline">
                <input type="radio" name="second"  value="heat" checked onchange="search()">heat
            </label>
            <label class="radio-inline">
                <input type="radio" name="second"  value="timeReleased" onchange="search()">timeReleased
            </label>
        </div>
    </div>

         <div class="container" style="margin-top: 5%;"  >

        <div class="row" >
            <div class="col-md-9" style="background-image: url('static/background/0-10.jpg');width:70%;height:60%;background-color:gainsboro;box-shadow:inset 1px -1px 1px #444, inset -1px 1px 1px #444;text-align: center">
                <div class="row" id="1">
                </div>
            </div>

        </div>

             <div style="margin-top: 3%;margin-left: auto" >

                 <ul class="pagination"  id="pageTable"></ul>

             </div>

      </div>







    <script>

     var currentPage;
     var totalPage;
     function getPageCount() {
         $.ajax({
        url:<%=request.getContextPath()%>"/search",
        async:false,//同步
        data:{
            method:"pageCount",
            keyWord: $("input[name=key]").val(),
            first:$("input[name='first']:checked").val(),
            second:$("input[name='second']:checked").val()
        },
        type:"post",
        success:function (data) {
            totalPage=Number(data);
        }

    });
}

     function load(currentPage,totalPage) {
         if (currentPage<=totalPage){
             $.ajax({
                 url:<%=request.getContextPath()%>"/search",
                 data:{
                     method:"load",
                     currentPage:currentPage,
                     keyWord: $("input[name=key]").val(),
                     first:$("input[name='first']:checked").val(),
                     second:$("input[name='second']:checked").val()
                 },
                 type:"post",
                 success:function (msg) {
                     var list=eval("("+msg+")");
                     $("#1").empty();
                     for (var i=0;i<list.length;i++){
                         $("#1").append(" <div class=\"col-md-4\" style=\"background-image: url('static/background/0-5.jpg');box-shadow: inset 1px -1px 1px #444, inset -1px 1px 1px #444;\">\n" +
                             "<a href='<%=request.getContextPath()%>/detail?id="+list[i].imageID+"'><img src=\"static/image/"+list[i].imageFileName+"\" width=\"120px\" height=\"100px\"></a>\n" +
                             " <p style=\"text-align: center\">heat:"+list[i].heat+"</p>\n" +
                             " <p style=\"text-align: center\">timeReleased:"+list[i].timeReleased+"</p>"+
                             "<p style=\"text-align: center\">subject:"+list[i].subject+"</p>\n"+
                         " <p style=\"white-space:nowrap;text-overflow:ellipsis;overflow:hidden;\">title:"+list[i].title+"</p>\n");
                     }
                 },
                 error:function () {
                     alert("error")
                 }
             })
         }
     }

     function addButton(totalPage) {
         var bu;
         $("#pageTable").empty();
         for (var i=0;i<=(totalPage+1);i++){
             var l=document.createElement("li");
             bu=document.createElement("a");
             bu.style.cursor="pointer";
             if(i==0){
                 bu.value="<<";
                 bu.appendChild(document.createTextNode("<<"));
                 bu.id="page"+i;
                 bu.onclick=function () {
                     if (currentPage!=1){
                         load(currentPage-1,totalPage);
                         currentPage=Number(currentPage)-1;
                     }
                 };

             }else if (i==totalPage+1){
                 bu.value=">>";
                 bu.appendChild(document.createTextNode(">>"));
                 bu.id="page"+i;
                 bu.onclick=function () {
                     if (currentPage!=totalPage){
                         load(currentPage+1,totalPage);
                         currentPage=Number(currentPage)+1;
                     }
                 };
             }else{

                 bu.value=i;
                 bu.appendChild(document.createTextNode(i+""));
                 bu.id="page"+i;
                 bu.onclick=function () {
                     currentPage=$(this).val();
                     load(currentPage,totalPage);

                 };
             }
              l.appendChild(bu);
             document.getElementById("pageTable").appendChild(l);
         }

     }

     function search() {
              totalPage=0;
              getPageCount();
              load(1,totalPage);
              currentPage=1;
              addButton(totalPage);
     }


</script>
</body>
</html>
