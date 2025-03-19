
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("xuka"))
</script>
<html>
<head>
    <title>会员列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/table/bootstrap-table.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/table/bootstrap-table.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/table/locale/bootstrap-table-zh-CN.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/sweetalert/sweetalert.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/sweetalert/sweetalert.min.js"></script>
    <script src="${pageContext.request.contextPath}/static//bootstrap/js/tableExport.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/Moment.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.js"></script>

    <script>
        $(function () {


            $('#xdate').datetimepicker({
                format: 'YYYY-MM-DD',
                useCurrent: false
            });
            $('#ddate').datetimepicker({
                format: 'YYYY-MM-DD',
                useCurrent: false //Important! See issue #1075
            });
            $("#xdate").on("dp.change", function (e) {
                // 这里假设您想设置结束日期的最小可选日期为开始日期选择的日期
                $('#ddate').data("DateTimePicker").minDate(e.date);
            });
            $("#ddate").on("dp.change", function (e) {
                // 这里假设您想设置开始日期的最大可选日期为结束日期选择的日期
                $('#xdate').data("DateTimePicker").maxDate(e.date);
            });

            $('#dg').bootstrapTable({
                url:'${pageContext.request.contextPath}/cz/personalxukaquery',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[
                    { field:'renewalTime',title:'续卡日期'},
                    { field:'member.memberName',title:'姓名'},
                    { field:'membertype.typeName',title:'卡型'},
                    { field:'membertype.typemoney',title:'费用'},
                    { field:'originalBalance',title:'原余额'},
                    { field:'newBalance',title:'剩余金额'},
                ],
                queryParamsType:'',
                height:360,
                pageList:[6,10,15],
                pageNumber:1,
                pageSize:6,
                pagination:true,
                sidePagination:'server',
            })
        });

        //
        // //获取当前的条件个页面页数即使更新值
        // function queryParams(afds){
        //     var i={
        //         "pageSize":afds.pageSize,
        //         "pageNumber":afds.pageNumber,
        //         "xdate":$('#xdate').val(),
        //         "ddate":$('#ddate').val(),
        //     };
        //     return i;
        // }
        //查询
        function search() {
            var opt = $('#dg').bootstrapTable('getOptions');
            var xdate = $('#xdate').val();
            var ddate = $('#ddate').val();
            var memberName = $('#memberName').val(); // 获取会员名字输入框的值

            $.post("${pageContext.request.contextPath}/cz/xukaquery", {
                "pageSize": opt.pageSize,
                "pageNumber": opt.pageNumber,
                "xdate": xdate,
                "ddate": ddate,
                "memberName": memberName // 发送会员名字作为参数
            }, function (response) {
                console.log("response",response);
                $("#dg").bootstrapTable('load', response);
            });
        }

    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">
    <%--    //查询--%>
    <div class="panel panel-default">
    <div class="panel-body">

    </div>

</div>
    <%--//页面数据展示--%>
    <div>
        <table id="dg"></table>
    </div>
</body>
</html>
