<%--
  Created by IntelliJ IDEA.
  User: 111
  Date: 2024/3/1
  Time: 17:10
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("jin7"))
</script>
<html>
<head>
    <title>会员卡列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/table/bootstrap-table.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/table/bootstrap-table.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/table/locale/bootstrap-table-zh-CN.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/sweetalert/sweetalert.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/sweetalert/sweetalert.min.js"></script>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/Moment.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <script>
        $(function () {
            $('#table').bootstrapTable({
                url:'${pageContext.request.contextPath}/classRoom/query',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[
                    { field:'classroomId',title:'课程编号',sortable: true},
                    { field:'classroomName',title:'教室名称',sortable: true},
                    { field:'capacity',title:'教室容量/人',sortable: true},
                    {
                        field:'xx',title:'操作',
                        formatter : function(value, row, index) {
                            return "<a title='编辑' href='javascript:upd1(" + row.classroomName +","+row.capacity+","+row.classroomId+")'><i class='fa fa-edit'></i></a>" +
                                "<a title='删除' href='javascript:del1(" + row.classroomId + ")'><i class='fa fa-trash'></i></a>  ";
                        }

                    }
                ],
                queryParamsType:'',
                queryParams:queryParams,
                height:360,
                pageList:[5,10,15],
                pageNumber:1,
                pageSize:5,
                pagination:true,
                sidePagination:'server',

            })
        });
        //删除
        function del1(id){
            swal({
                    title: "确定删除吗？",
                    text: "您将无法恢复！",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确定删除！",
                    cancelButtonText: "取消删除！",
                    closeOnConfirm: false,
                    closeOnCancel: false
                },
                function (isConfirm) {
                    if (isConfirm) {
                        // 发送POST请求到服务器端的删除接口
                        $.post('${pageContext.request.contextPath}/classRoom/delete', {'classroomId': id}, function(data) {
                            // 判断返回结果，根据结果显示相应的提示信息
                            if(data.success) {
                                swal("删除！", "删除成功", "success");
                                // 刷新表格数据
                                $('#table').bootstrapTable('refresh');
                            } else {
                                swal("删除失败！", data.message, "error");
                            }
                        });
                    } else {
                        swal("取消！", "您已取消删除", "error");
                    }
                });
        }


        //获取当前的条件个页面页数即使更新值
        function queryParams(afds){
            var i={
                "pageSize":afds.pageSize,
                "pageNumber":afds.pageNumber,
                "id":$('#cardid').val(),
            };
            return i;
        }
        //查询
        function search(){
            var opt=$('#table').bootstrapTable('getOptions');
            var subjectid=$('#cardid').val();

            $.post("${pageContext.request.contextPath}/classRoom/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"subname":subjectid},function (releset) {
                $("#table").bootstrapTable('load',releset) ;
            })
        }

        function save(){

            if(!validateAdd()){
                return;
            }

            //接收数据
            var opt = $('#table').bootstrapTable('getOptions');
            var classroomName = $("#classroomName").val(); // 教室名称
            var capacity = $("#capacity").val(); // 教室容量
            $("#myModal").modal("hide");
            $.post("${pageContext.request.contextPath}/classRoom/checkName", {"classroomName": classroomName}, function(response) {
                if(response.available){
                    $.post('${pageContext.request.contextPath}/classRoom/add', {'classroomName': classroomName, 'capacity': capacity, 'location':1}, function(data){
                        // 重新加载表格数据
                        $('#table').bootstrapTable('refresh');
                        swal("添加成功！", "您已经成功添加了新的教室。", "success");
                    });
                } else {
                    swal("添加失败！", "该教室名称已存在，请重新输入！", "error");
                }
            });
        }

        function validateAdd() {
            // 移除之前的验证提示信息
            $("#classroomName").parent().find("span").remove();
            $("#capacity").parent().find("span").remove();


            // 获取输入的值
            var classroomName = $("#classroomName").val().trim();
            var capacity = $("#capacity").val().trim();

            // 验证教室名称
            if(classroomName == ""){
                $("#classroomName").parent().append("<span style='color:red'>请输入教室名称</span>");
                return false;
            }

            // 验证容量
            if(capacity == ""){
                $("#capacity").parent().append("<span style='color:red'>请输入容量</span>");
                return false;
            }
            if(!(/^[0-9]*$/.test(capacity))){
                $("#capacity").parent().append("<span style='color:red'>容量只能为正整数</span>");
                return false;
            }


            // 所有验证通过
            return true;
        }

        function upd1(name,capacity,id){
            $("#myModal2").modal("show");
            $('#id').val(id);
            $("#classroomName1").val(name);
            $("#capacity1").val(capacity);


        }
        function kong() {
            $("#classroomName").val("");  // 清空教室名称
            $("#capacity").val("");  // 清空容量
            // 清空其他可能的字段...
        }
        function upd(){

            if(!validateUpd()){
                return;
            }

            var id = $('#id').val(); // 获取教室的唯一标识符
            var classroomName = $("#classroomName1").val(); // 获取修改后的教室名称
            var capacity = $("#capacity1").val(); // 获取修改后的容量
            $("#myModal2").modal("hide");
            // 发送POST请求到服务器端的更新接口
            $.post('${pageContext.request.contextPath}/classRoom/update', {
                'id': id,
                'classroomName': classroomName,
                'capacity': capacity,
                'location': 1
            }, function(data){
                // 根据服务器返回的数据刷新表格或进行其他操作
                $('#table').bootstrapTable('refresh'); // 推荐使用refresh方法刷新表格
                // 使用data.message来获取后端返回的消息
                swal("修改成功！", data.message, "success");
            });
        }


        function validateUpd() {
            // 移除之前的验证提示信息
            $("#classroomName1").parent().find("span").remove();
            $("#capacity1").parent().find("span").remove();
            // 获取输入的值
            var classroomName = $("#classroomName1").val().trim();
            var capacity = $("#capacity1").val().trim();


            // 验证教室名称
            if(classroomName == ""){
                $("#classroomName1").parent().append("<span style='color:red'>请输入教室名称</span>");
                return false;
            }

            // 验证容量
            if(capacity == ""){
                $("#capacity1").parent().append("<span style='color:red'>请输入容量</span>");
                return false;
            }
            if(!(/^[0-9]*$/.test(capacity))){
                $("#capacity1").parent().append("<span style='color:red'>容量只能为正整数</span>");
                return false;
            }


            // 所有验证通过
            return true;
        }



    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">
<%--    //查询--%>
<div class="panel panel-default">
    <div class="panel-body">
        <form class="form-inline">
            <div  class="input-group input-daterange">
                <label for="cardid" class="control-label">教室名称:</label>
                <input id="cardid" type="text" class="form-control">
            </div>
            <button onclick="search()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
            <button type="button" class="btn btn-default" onclick="kong()" style="float: right; margin-top: 20px" data-toggle="modal" data-target="#myModal"><span class="glyphicon glyphicon-plus"></span>添加教室</button>
        </form>
    </div>

</div>
<%--//页面数据展示--%>
<div>
    <table id="table"></table>
</div>
<%--新增教室--%>
<div class="modal fade" id="myModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">增加新教室</h4>
            </div>
            <div class="modal-body">
                <!-- form开始 -->
                <form>
                    <div class="form-group">
                        <label for="classroomName" class="col-sm-4 control-label" style="margin-top: 10px">教室名称</label>
                        <div class="col-sm-8">
                            <input type="text" style="margin-top: 10px" class="form-control" id="classroomName" name="classroomName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="capacity" class="col-sm-4 control-label" style="margin-top: 10px">容量/人</label>
                        <div class="col-sm-8">
                            <input type="number" style="margin-top: 10px" class="form-control" id="capacity" name="capacity">
                        </div>
                    </div>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button onclick="save()" id = "add" type="button" class="btn btn-primary">提交</button>
                </div>
            </div>
        </div>
    </div>
</div>
<%--编辑--%>
<div class="modal fade" id="myModal2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改教室</h4>
            </div>
            <div class="modal-body">
                <!-- form开始 -->
                <form>
                    <input type="hidden" id="id" name="id">
                    <div class="form-group">
                        <label for="classroomName" class="col-sm-4 control-label" style="margin-top: 10px">教室名称</label>
                        <div class="col-sm-8">
                            <!-- 注意这里ID从xgname改为classroomName -->
                            <input type="text" style="margin-top: 10px" class="form-control" id="classroomName1" name="classroomName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="capacity" class="col-sm-4 control-label" style="margin-top: 10px">容量/人</label>
                        <div class="col-sm-8">
                            <!-- 添加了容量字段 -->
                            <input type="number" style="margin-top: 10px" class="form-control" id="capacity1" name="capacity">
                        </div>
                    </div>

                    <!-- 移除了原有的教室费用字段 -->
                </form>

                &nbsp;
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button onclick="upd()"  type="button" class="btn btn-primary">修改</button>
                </div>
            </div>
        </div>
    </div></div>
</body>
</html>
