
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("jin3"))
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
                url: '${pageContext.request.contextPath}/courseSchedule/query', // 更改为您的后端查询课程安排的URL
                method: 'post',
                contentType: "application/x-www-form-urlencoded",
                columns: [
                    {
                        field: 'scheduleId',
                        title: '排课编号'
                    },
                    {
                        field: 'classroom.classroomName', // 假设您的后端能够返回包含教室名称的对象
                        title: '教室'
                    },
                    {
                        field: 'coach.coachName', // 假设您的后端能够返回包含教练名称的对象
                        title: '教练名称'
                    },
                    {
                        field: 'subject.subname', // 假设您的后端能够返回包含课程名称的对象
                        title: '课程名称'
                    },
                    {
                        field: 'startTime',
                        title: '开始时间',
                        formatter: function(value, row, index) {
                            // 如果需要，可以在这里格式化日期时间
                            return value;
                        }
                    },
                    {
                        field: 'endTime',
                        title: '结束时间',
                        formatter: function(value, row, index) {
                            // 如果需要，可以在这里格式化日期时间
                            return value;
                        }
                    },
                    {
                        field: 'courseStatus',
                        title: '课程状态',
                        formatter: function(value, row, index) {
                            // 根据状态值显示对应的文本描述和颜色
                            var statusLabel = '';
                            switch (value) {
                                case 1:
                                    statusLabel = '<span class="label label-warning">待进行</span>';
                                    break;
                                case 2:
                                    statusLabel = '<span class="label label-primary">进行中</span>';
                                    break;
                                case 3:
                                    statusLabel = '<span class="label label-success">已完成</span>';
                                    break;
                                default:
                                    statusLabel = '<span class="label label-default">未知</span>';
                            }
                            return statusLabel;
                        }
                    },
                    {
                        title: '数量/已购买数', // 设置列的标题
                        formatter: function(value, row, index) {
                            // 使用row对象获取classroom.capacity和purchaseCount的值
                            // 假设classroom是一个嵌套的对象，你需要根据实际情况调整路径
                            var capacity = row.classroom.capacity;
                            var purchaseCount = row.purchaseCount;

                            // 返回自定义的显示内容，这里将两个值用斜杠分隔
                            return capacity + ' / ' + purchaseCount;
                        }
                    },

                ],
                queryParamsType: '',
                queryParams: queryParams, // 如果需要发送额外的请求参数
                height: 360,
                pageList: [5, 10, 15],
                pageNumber: 1,
                pageSize: 5,
                pagination: true,
                sidePagination: 'server', // 分页方式：server服务端分页，client客户端分页
                // 其他配置...
            });

        });
        // 构建要发送到后端的参数对象
       function queryParams(params) {
           var coachId = $('#coachId').val(); // 在函数内部获取最新的coachId值
           return {
               pageSize: params.pageSize, // Bootstrap Table参数名称可能是limit而不是pageSize，取决于queryParamsType的设置
               pageNumber: params.pageNumber, // 根据offset计算当前页码
               coachId: coachId // 将最新的coachId加入请求参数中
           };
       }
        //查询
    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">
    <%--//页面数据展示--%>
    <div>
        <table id="table"></table>
    </div>
    <input type="hidden" id="coachId" value="${sessionScope.user.coachId}">
</body>
</html>
