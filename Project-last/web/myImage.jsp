<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/7/23
  Time: 16:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>myImage</title>
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
                <thead>
                <tr>
                    <th>picture</th>
                    <th>title</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="t">

                </tbody>
            </table>


            <div style="margin-top: 3%;margin-left: 40%" >
                <ul class="pagination"  id="pageTable"></ul>
            </div>

        </div>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel" style="font-size: 25px;font-family:'Segoe Print'">Tip</h4>
                    </div>
                    <div class="modal-body" style="text-align: center;font-family: 方正舒体;font-size:50px">确认删除图片及相应的信息么</div>
                    <div class="modal-footer" id="s">
                        <button type="button" class="btn btn-default" data-dismiss="modal" style="font-family: 方正舒体;">取消</button>
                        <button type="button" class="btn btn-primary" id="del" style="font-family: 方正舒体;">确认</button>
                    </div>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <script>window.location.href="home.jsp"</script>
    </c:otherwise>
</c:choose>

<script>
    var totalPage,currentPage;
    function getTotalPage() {
        $.ajax({
            url:<%=request.getContextPath()%>"/upload",
            type:"post",
            async:false,//同步
            data:{
                method:"pageCount"
            },
            success:function (date) {
                totalPage=Number(date);
            }
        })
    }

    function load(currentPage,totalPage) {
        if (currentPage<=totalPage){
            $.ajax({
                url:<%=request.getContextPath()%>"/upload",
                type:"post",
                data:{
                    method:"load",
                    currentPage:currentPage
                },
                success:function (msg) {
                    var list=eval("("+msg+")");
                    $("#t").empty();
                    for (var i=0;i<list.length;i++){
                        console.log(list[i].imageFileName);
                        $("#t").append("<tr class='tr'>" +
                            "<td>"+ "<a href='<%=request.getContextPath()%>/detail?id="+list[i].imageID+"'><img src=\"static/image/"+
                            list[i].imageFileName+"\" width=\"120px\" height=\"100px\"></a>\n"+
                            "</td>" +
                            "<td>"+list[i].title+"</td>" +
                            "<td id='cancel'><a  style='text-decoration: none;\n" +
                            " cursor: pointer;' href='upload?method=change1&imageID="+list[i].imageID+
                            "'>修改</a>" +
                            "&nbsp" +
                            "<a style='text-decoration: none;cursor: pointer' onclick='delet("+list[i].imageID+")'>删除" +
                            "</a></td>" +
                            "</tr>");
                    }
                },
                error:function () {
                    alert("错误")
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

    function l() {
        totalPage=0;
        getTotalPage();
        load(1,totalPage);
        currentPage=1;
        addButton(totalPage);
    }

    $(function () {
        l();
    });

    function delet(imageID) {
        $("#myModal").modal("show");
        $("#del").on("click",function () {
            $("#myModal").modal("hide");
            del(imageID)
        })
    }

    function del(imageID) {
        $.ajax({
            url:<%=request.getContextPath()%>"/upload",
            data:{
                method:"delete",
                imageID:imageID
            },
            success:function (data) {
                alert("删除成功");
                l()
            }
        })
    }




</script>

</body>
</html>
