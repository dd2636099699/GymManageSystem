
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("jin"))
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
            $('#dg').bootstrapTable({
                url: '${pageContext.request.contextPath}/CourseSale/query', // 更改为您的后端查询课程售卖情况的URL
                method: 'post',
                contentType: "application/x-www-form-urlencoded",
                columns: [
                    { field: 'scheduleId', title: '课程安排号' },
                    { field: 'courseName', title: '课程名' },
                    { field: 'memberName', title: '购买人' },
                    { field: 'purchaseDate', title: '购买时间' },
                    { field: 'cost', title: '费用' }
                ],
                queryParamsType: '',
                height: 360,
                pageList: [6, 10, 15],
                pageNumber: 1,
                pageSize: 6,
                pagination: true,
                sidePagination: 'server', // 分页方式：server服务端分页，client客户端分页
            });
        });

        function search() {
            var opt = $('#dg').bootstrapTable('getOptions');
            var xdate = $('#xdate').val();
            var ddate = $('#ddate').val();
            var memberName = $('#memberName').val(); // 获取会员名字输入框的值

            $.post("${pageContext.request.contextPath}/cz/query", {
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
        <form class="form-inline" >
            <div class="input-group">
                <label for="memberName" class="control-label"></label>
                <input id="memberName" type="text" class="form-control">
            </div>
            <div class="input-group input-daterange">
                <label for="xdate" class="control-label"></label>
                <input id="xdate" type="text" class="form-control datetimepicker">
            </div>
            <div class="input-group input-daterange">
                <label for="ddate" class="control-label"></label>
                <input id="ddate" type="text" class="form-control datetimepicker">
            </div>


        </form>

    </div>

</div>
    <%--//页面数据展示--%>
    <div>
        <table id="dg"></table>
    </div>
</body>
</html>
