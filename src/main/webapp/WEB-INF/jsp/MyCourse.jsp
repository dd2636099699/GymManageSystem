<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>课程购买信息</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/sweetalert/sweetalert.min.js"></script>
    <style>
        .status-pending {
            color: #d58512; /* 深橙色 */
        }
        .status-active {
            color: #337ab7; /* 深蓝色 */
        }
        .status-completed {
            color: #5cb85c; /* 深绿色 */
        }
        .status-unknown {
            color: #777; /* 灰色 */
        }
    </style>

</head>
<body>
<div class="container mt-4">
    <h2 class="mb-3">课程购买信息</h2>
    <div id="coursePurchaseInfo">
        <table class="table table-bordered">
            <thead class="thead-dark">
            <tr>
                <th>购买编号</th>
                <th>课程名称</th>
                <th>教室名称</th>
                <th>教练名称</th>
                <th>开始时间</th>
                <th>结束时间</th>
                <th>购买时间</th>
                <th>课程状态</th>
            </tr>
            </thead>
            <tbody>
            <!-- AJAX 动态填充 -->
            </tbody>
        </table>
    </div>
</div>

<script>
    $(document).ready(function() {
        var memberId = $('#memberId').val(); // 假定从隐藏的input标签获取
        // 构建请求URL
        var requestUrl = "${pageContext.request.contextPath}/CourseSale/findById?memberId=" + memberId;

        // 发送请求获取课程购买信息
        $.ajax({
            url: requestUrl,
            type: 'GET',
            success: function(response) {
                // 假设response是一个数组，包含了购买信息
                var rows = '';
                response.forEach(function(courseSale) {
                    rows += '<tr>' +
                        '<td>' + courseSale.id + '</td>' +
                        '<td>' + courseSale.courseSchedule.subject.subname+ '</td>' +
                        '<td>' + courseSale.courseSchedule.classroom.classroomName + '</td>' +
                        '<td>' + courseSale.courseSchedule.coach.coachName + '</td>' +
                        '<td>' + courseSale.courseSchedule.startTime + '</td>' +
                        '<td>' + courseSale.courseSchedule.endTime + '</td>' +
                        '<td>' + courseSale.purchaseDate + '</td>' +
                        '<td>' +  translateStatus(courseSale.courseSchedule.courseStatus)+ '</td>' +
                        '</tr>';
                });
                $('#coursePurchaseInfo tbody').html(rows);
            },
            error: function(xhr, status, error) {
                swal("加载失败", "无法获取课程购买信息", "error");
            }
        });
    });
    // 根据课程状态代码转换为带颜色的可读文本
    function translateStatus(statusCode) {
        switch(statusCode) {
            case 1:
                return "<span class='status-pending'>待进行</span>";
            case 2:
                return "<span class='status-active'>上课中</span>";
            case 3:
                return "<span class='status-completed'>已完成</span>";
            default:
                return "<span class='status-unknown'>未知</span>";
        }
    }

</script>

<!-- 以下隐藏字段用于演示，实际使用中应根据实际情况获取 -->
<input type="hidden" id="memberId" value="${sessionScope.user.memberId}">
</body>
</html>
