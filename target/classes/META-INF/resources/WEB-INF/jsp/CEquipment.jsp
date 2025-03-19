
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("yemian"))
</script>
<html>
<head>
    <title>器材管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/table/bootstrap-table.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/table/bootstrap-table.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/table/locale/bootstrap-table-zh-CN.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/sweetalert/sweetalert.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/sweetalert/sweetalert.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/Moment.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript">

        $(function () {
            $('#table').bootstrapTable({
                url:'${pageContext.request.contextPath}/qc/query',
                columns:[
                    {
                        field:'eqId',
                        title:'编号'
                    }, {
                        field:'eqName',
                        title:'器材名称'
                    },{
                        field:'count',
                        title:'数量'
                    },
                    {
                        field:'xx',title:'操作',
                        formatter : function(value, row, index) {
                            return "<a title='编辑' href='javascript:upd1(" + row.eqId + ",\"" + row.eqName.replace(/"/g, '\\"') + "\"," + row.count + ")'><i class='fa fa-edit'></i></a>" +
                                "<a title='删除' href='javascript:del(" + row.eqId + ")'><i class='fa fa-trash'></i></a>";

                        }

                    }
                ],
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                queryParamsType:'',
                queryParams:queryParams,
                height:360,
                pageList:[5,10,15],
                pageNumber:1,
                pageSize:5,
                pagination:true,
                sidePagination:'server',

            });
        })





        //获取当前的条件个页面页数即使更新值
        function queryParams(afds){
            var i={
                "pageSize":afds.pageSize,
                "pageNumber":afds.pageNumber,
                "id":$('#eqName').val(),
            };
            return i;
        }
        //查询
        function chaxun(){
            var opt=$('#table').bootstrapTable('getOptions');
            var eqname=$('#eqname').val();
            $.post("${pageContext.request.contextPath}/qc/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"hyname":eqname},function (data) {

                $("#table").bootstrapTable('load',data) ;
            })
        }

        function del(eqId) {
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
                        $.post("${pageContext.request.contextPath}/qc/delete",{"eqId":eqId},function (releset) {
                            if(releset != null){
                                $("#dg").bootstrapTable('load',releset) ;
                                swal(
                                    {
                                        title:"删除成功",
                                        type:"success",
                                        timer: 1500,
                                        showConfirmButton: false
                                    }
                                )
                                chaxun();
                            }else{
                                swal(
                                    {
                                        title:"删除失败",
                                        type:"warning",
                                        timer: 1500,
                                        showConfirmButton: false

                                    }
                                )
                            }
                        })
                    } else {
                        swal("取消！", "您已取消删除", "error");
                    }
                });

        }


        //添加
        function insert() {
            $("#upname").val("");
            $("#uptext").val("");
            $('#exampleModal').modal('show');

        }
        //编辑
        function upd1(eqId, eqName, eqQuantity) {

            // 清除之前的表单数据（如果有）
            $('#editEquipmentForm')[0].reset();

            // 回填表单数据
            $('#eqId').val(eqId);
            $('#eqName1').val(eqName);
            $('#eqQuantity').val(eqQuantity);

            // 显示模态对话框
            $('#editEquipmentModal').modal('show');
        }
        function saveEquipment() {
            // 获取表单数据
            var eqId = $('#eqId').val();
            var eqName = $('#eqName1').val();
            var eqQuantity = $('#eqQuantity').val();

            // 构造请求数据
            var requestData = {
                eqId: eqId,
                eqName: eqName,
                count: eqQuantity
            };

            // 发送AJAX请求到服务器
            $.ajax({
                url: "${pageContext.request.contextPath}/qc/edit", // 更改为您的API接口路径
                type: "POST",
                contentType: "application/json", // 假设后端期望接收JSON格式的数据
                data: JSON.stringify(requestData), // 将JavaScript对象转换为JSON字符串
                success: function(response) {
                    // 请求成功后的回调函数
                        // 关闭模态对话框
                        $('#editEquipmentModal').modal('hide');
                        // 可选：刷新页面或表格，显示最新的数据
                        // 例如，如果您使用Bootstrap表格，可以调用`$('#yourTableId').bootstrapTable('refresh');`
                        swal("更新成功！", "器材信息已成功更新。", "success");
                },
                error: function(xhr, status, error) {
                    // 请求失败的回调函数
                    swal("更新失败", "请求失败: " + error, "error");
                }
            });
        }


        function tianjia() {
            if(!validateAdd()){
                return;
            }
            var name=$('#upname').val();
            var text1 =$('#upquantity').val();
            $.post("${pageContext.request.contextPath}/qc/insert",{"eqName":name,"count":text1},function (releset) {
                if(releset != null){
                    $("#table").bootstrapTable('load',releset) ;
                    $('#exampleModal').modal('hide');
                    swal(
                        {
                            title:"添加成功",
                            type:"success",
                            timer: 1500,
                            showConfirmButton: false
                        }
                    )
                }else{
                    swal(
                        {
                            title:"添加失败",
                            type:"warning",
                            timer: 1500,
                            showConfirmButton: false
                        }
                    )
                }
            })
        }

        function validateAdd() {
            // 清除之前的验证消息
            $("#upname").parent().find("span").remove();
            $("#upquantity").parent().find("span").remove();

            var upname = $("#upname").val().trim();
            var upquantity = $("#upquantity").val().trim();

            var isValid = true;

            // 验证器材名称是否输入
            if(upname == null || upname == ""){
                $("#upname").parent().append("<span style='color:red'>请输入器材名称</span>");
                isValid = false;
            }

            // 验证器材数量是否输入，且必须为大于0的整数
            if(upquantity == null || upquantity == "" || !/^[1-9]\d*$/.test(upquantity)){
                $("#upquantity").parent().append("<span style='color:red'>请输入正确的器材数量（必须为大于0的整数）</span>");
                isValid = false;
            }

            return isValid;
        }



    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">

<%--    //查询--%>
<div class="panel panel-default">
    <div class="panel-body">
        <form class="form-inline">
            <div  class="input-group input-daterange">
                <label for="eqname" class="control-label">器材名称:</label>
                <input id="eqname" type="text" class="form-control">
            </div>
            <button onclick="chaxun()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
            <button type="button" class="btn btn-default" style="float: right; margin-top: 20px" data-toggle="modal" onclick="insert()"><span class="glyphicon glyphicon-plus"></span>添加器材</button>
        </form>
    </div>

</div>

<!--表格-->
<table id="table"></table>

<%--添加--%>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel">器材添加</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" id="upid">
                    <div class="form-group">
                        <label class="control-label">器材名称:</label>
                        <input type="text" class="form-control" id="upname">
                    </div>
                    <div class="form-group">
                        <label class="control-label">器材数量:</label>
                        <input type="number" class="form-control" id="upquantity"> <!-- 改变ID和类型为number -->
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="tianjia()">添加</button>
            </div>
        </div>
    </div>
</div>
<%--编辑--%>、
<!-- Edit Equipment Modal -->
<div id="editEquipmentModal" class="modal fade" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">编辑器材</h4>
            </div>
            <div class="modal-body">
                <form id="editEquipmentForm">
                    <input type="hidden" id="eqId">
                    <div class="form-group">
                        <label for="eqName">器材名称:</label>
                        <input type="text" class="form-control" id="eqName1">
                    </div>
                    <div class="form-group">
                        <label for="eqQuantity">器材数量:</label>
                        <input type="number" class="form-control" id="eqQuantity">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="saveEquipment()">保存更改</button>
            </div>
        </div>
    </div>
</div>


</body>
</html>
