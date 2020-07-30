<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Lenovo
  Date: 2020/7/19
  Time: 15:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Upload</title>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://cdn.bootcdn.net/ajax/libs/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>
    <link href="https://cdn.bootcdn.net/ajax/libs/bootstrap-validator/0.5.3/css/bootstrapValidator.min.css" rel="stylesheet">
</head>
<body>
<c:choose>
    <c:when test="${sessionScope.user!=null&&sessionScope.imageID1==null}">
        <jsp:include page="nav.jsp"></jsp:include>
        <img id="pre" height="150px" width="150px" alt="" style="margin-left: 18%;margin-top: 4%" >
        <div class="container" style="margin-top: -8%" >
            <form role="form" method="post"  class="form-horizontal" style="margin-left: 30%;margin-right:35%" >
                <div class="form-group">
                    <label class="sr-only" for="inputfile">文件输入</label>
                    <input type="file" id="inputfile" name="file">

                </div>
                <div class="form-group">
                    <label for="title" class="col-sm-2 control-label" >title:</label>
                    <input type="text" name="title" id="title" class="form-control" autocomplete="off">
                </div>
                <div class="form-group">
                <label for="author" class="col-sm-2 control-label" >author:</label>
                <input type="text" name="author" id="author" class="form-control" autocomplete="off">
            </div>
                <div class="form-group">
                <label for="subject" class="col-sm-2 control-label" >subject:</label>
                <input type="text"  name="subject" id="subject" class="form-control" autocomplete="off">
            </div>
                <div class="form-group">
                    <label for="country">country:</label>
                    <select class="form-control " name="country" id="country">
                        <option value="China" selected="selected">China</option>
                        <option value="England">England</option>
                        <option value="America">America</option>
                        <option value="Japan">Japan</option>
                        <option value="India">India</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="city">city:</label>
                    <select class="form-control " name="city" id="city">
                        <option value="Beijing" selected="selected">Beijing</option>
                        <option value="Landon">Landon</option>
                        <option value="New York">New York</option>
                        <option value="Tokyo">Tokyo</option>
                        <option value="New Delhi">New Delhi</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="description" class="col-sm-2 control-label" >description:</label>
                    <textarea  name="description" id="description" class="form-control" autocomplete="off" rows="3"></textarea>
                </div>
                <button  type="submit" class="btn btn-default" style="margin-left: 15%" onclick="upload()">提交</button>
                <button type="reset" class="btn btn-default" style="margin-left: 18%">重置</button>
        </form>

        </div>
    </c:when>




   <c:when test="${sessionScope.user!=null&&sessionScope.imageID1!=null}">
            <jsp:include page="nav.jsp"></jsp:include>
             <div class="container" style="margin-top: 5%" >

            <form role="form" method="post"  class="form-horizontal" style="margin-left: 30%;margin-right:35%">
                <div class="form-group">
                    <label for="title1" class="col-sm-2 control-label" >title:</label>
                    <input type="text" name="title" id="title1" class="form-control" autocomplete="off"
                           value="${sessionScope.myUpload.title}">
                </div>
                <div class="form-group">
                    <label for="author1" class="col-sm-2 control-label" >author:</label>
                    <input type="text" name="author" id="author1" class="form-control" autocomplete="off"
                           value="${sessionScope.myUpload.author}">
                </div>
                <div class="form-group">
                    <label for="subject1" class="col-sm-2 control-label" >subject:</label>
                    <input type="text"  name="subject" id="subject1" class="form-control" autocomplete="off"
                           value="${sessionScope.myUpload.subject}">
                </div>


                <div class="form-group">
                    <label for="country1">country:</label>
                    <select class="form-control " name="country" id="country1" >
                        <option value="China" selected="selected">China</option>
                        <option value="England">England</option>
                        <option value="America">America</option>
                        <option value="Japan">Japan</option>
                        <option value="India">India</option>
                    </select>
                </div>


                <div class="form-group">
                    <label for="city1">city:</label>
                    <select class="form-control " name="city" id="city1">
                        <option value="Beijing" selected="selected">Beijing</option>
                        <option value="Landon">Landon</option>
                        <option value="New York">New York</option>
                        <option value="Tokyo">Tokyo</option>
                        <option value="New Delhi">New Delhi</option>
                    </select>
                </div>


                <div class="form-group">
                    <div class="form-group">
                        <label for="description1" class="col-sm-2 control-label" >description:</label>
                        <textarea  name="description" id="description1" class="form-control" autocomplete="off"
                                   rows="3">${sessionScope.myUpload.description}</textarea>
                    </div>
                </div>
                <button  type="submit" class="btn btn-default" style="margin-left: 15%" onclick="reUpload()">确认更改</button>
                <!-- 实际上重复注册返回时此按钮也就没用了    -->
                <button onclick="back()" class="btn btn-default" style="margin-left: 18%" >返回</button>

            </form>
        </div>
    </c:when>

    <c:otherwise>
        <script>window.location.href="home.jsp"</script>
    </c:otherwise>

</c:choose>

<script>
    var file = "";
    var fileName = "";
    var title="",author="",subject="",description="",country="",city="";

    $(function () {
        $('form').bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {

                file: {
                    validators: {
                        notEmpty: {
                            message: '上传图片不能为空'
                        },
                        file: {
                            extension: 'png,jpg,jpeg',
                            type: 'image/png,image/jpg,image/jpeg',
                            message: '只能是图片格式哦'
                        }
                    }
                },
                title:{
                    message:"title error",
                    validators:{
                        notEmpty:{
                            message:"不能为空"
                        }

                    }
                },
                author:{
                    message:" error",
                    validators:{
                        notEmpty:{
                            message:"不能为空"
                        }

                    }
                },
                subject:{
                    message:" error",
                    validators:{
                        notEmpty:{
                            message:"不能为空"
                        }

                    }
                },
                description: {
                    message:" error",
                    validators:{
                        notEmpty:{
                            message:"不能为空"
                        }

                    }
                }

            }
        });
        $("#inputfile").change(function () {
            file = $("#inputfile").val();
            fileName = file.split("\\").pop();
           document.getElementById("pre").src=<%=request.getContextPath()%>'/static/image/'+fileName;
        })

    });

    function upload() {
        file = $("#inputfile").val();
        //获取文件名+扩展名
        fileName = file.split("\\").pop();
        this.value=fileName;
        title=$("#title").val();
        author=$("#author").val();
        subject=$("#subject").val();
        description=$("#description").val();

        country=$("#country option:selected").val();
        city=$("#city option:selected").val();
        if(fileName.length==0||title.length==0||author.length==0||subject.length==0||description.length==0){
            return;
        }

        $.ajax({
            url:<%=request.getContextPath()%>"/upload",
            async:false,
            data:{
                method:"upload",
                inputfile:fileName,
                title:title,
                author:author,
                subject:subject,
                description:description,
                country:country,
                city:city
            },
            success:function (data) {
                alert("上传成功！");
            }
        })

    }

    function reUpload() {
        title=$("#title1").val();
        author=$("#author1").val();
        subject=$("#subject1").val();
        description=$("#description1").val();
        country=$("#country1 option:selected").val();
        city=$("#city1 option:selected").val();
        if(title.length==0||author.length==0||subject.length==0||description.length==0){
            return;
        }
        $.ajax({
            url:<%=request.getContextPath()%>"/upload",
            async:false,
            data:{
                method:"change",
                title:title,
                author:author,
                subject:subject,
                description:description,
                country:country,
                city:city
            },
            success:function (data) {
                alert("更改成功！");
                window.location.href="upload.jsp";
            },
            error:function () {
                alert("出错了")
            }
        })

    }


     function back() {
            window.location.href="myImage.jsp";
    }


</script>
</body>
</html>
