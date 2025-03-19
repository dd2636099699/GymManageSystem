<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>预约管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/table/bootstrap-table.min.css">
    <script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/table/bootstrap-table.min.js"></script>
    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>



    /* 表格样式 */
        #reservationsTable {
            border-collapse: collapse; /* 折叠边框 */
        }
        #reservationsTable th, #reservationsTable td {
            border: 1px solid #ddd; /* 单元格边框 */
            padding: 8px;
        }
        #reservationsTable tr:nth-child(even){background-color: #f2f2f2;}

        #reservationsTable tr:hover {background-color: #ddd;} /* 鼠标滑过效果 */

        #reservationsTable th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: snow;
            color: black; /* 设置字体颜色为黑色 */
            font-weight: bold; /* 字体加粗 */
        }

    /* 调整弹窗的宽度 */
    .swal2-container .swal2-popup {
        width: 600px; /* 或者更宽，取决于你需要的空间 */
    }

    /* 调整输入框和下拉菜单的样式 */
    .swal2-container .swal2-input, .swal2-container .swal2-select {
        width: 50%; /* 使输入框和下拉菜单宽度与弹窗匹配 */
        height: 45px; /* 增加高度以便更容易交互 */
        font-size: 16px; /* 增加字体大小以提高可读性 */
        margin: 8px 0; /* 增加上下边距 */
    }

    /* 调整标签的样式 */
    .swal2-container label {
        display: block; /* 使标签显示为块级元素 */
        margin-top: 20px; /* 在标签上方添加一些空间 */
        font-weight: bold; /* 加粗字体 */
    }


    </style>

</head>
<body>
<div class="container">
    <h2>预约管理</h2>
    <div class="text-right"> <!-- 使用 text-right 类对齐按钮到右侧 -->
        <button id="addReservationBtn" class="btn btn-primary" style="margin-bottom: 20px;">添加预约</button>
    </div>
    <table id="reservationsTable" class="table">
        <thead>
        <tr>
            <th>预约ID</th>
            <th>会员名</th>
            <th>器材名</th>
            <th>预约时间</th>
            <th>操作</th> <!-- 添加操作列标题 -->
        </tr>
        </thead>
        <tbody>
        <!-- 预约数据将在这里通过JavaScript动态填充 -->
        </tbody>
    </table>
</div>

<script>
    let selectedTimeSlot = null;
    $(function() {



        $.ajax({
            url: '${pageContext.request.contextPath}/reserve/query',
            method: 'POST',
            success: function(data) {
                let tbody = $('#reservationsTable tbody');
                data.rows.forEach(function(row) {
                    var dateString = new Date(row.date).toISOString().split('T')[0];
                    var currentDate = new Date().toISOString().split('T')[0]; // 获取当前日期的字符串表示
                    var actionButton;
                    if (currentDate <= dateString) {
                        // 如果当前日期小于或等于预约日期，显示取消预约按钮
                        actionButton = '<button class="btn btn-danger btn-xs cancel-reservation" data-id="' + row.reservationId + '">取消预约</button>';
                    } else {
                        // 如果当前日期大于预约日期，显示已完成提示
                        actionButton = '<span class="badge badge-success">已完成</span>';
                    }
                    var trHTML = '<tr>' +
                        '<td>' + row.reservationId + '</td>' +
                        '<td>' + row.member.memberName + '</td>' +
                        '<td>' + row.equipment.eqName + '</td>' +
                        '<td>' + dateString + ' ' + row.session + '</td>' +
                        '<td>' + actionButton + '</td>' +
                        '</tr>';
                    tbody.append(trHTML);
                });

                // 为所有取消预约按钮添加点击事件监听器
                tbody.on('click', '.cancel-reservation', function() {
                    var reservationId = $(this).data('id');
                    Swal.fire({
                        title: '确定要取消这个预约吗?',
                        text: '一旦取消，将无法恢复！',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: '是的，取消它！',
                        cancelButtonText: '不，留着吧'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            // 在这里发送 AJAX 请求来取消预约
                            $.post('${pageContext.request.contextPath}/reserve/cancel/' + reservationId, function(response) {
                                if (response.success) {
                                    Swal.fire({
                                        title: '已取消!',
                                        text: '您的预约已成功取消。',
                                        icon: 'success'
                                    }).then(() => {
                                        // 成功后的操作，例如重新加载页面或更新表格数据
                                        $('button[data-id="' + reservationId + '"]').closest('tr').remove();
                                    });
                                } else {
                                    Swal.fire('操作失败！', '无法取消预约，请稍后再试。', 'error');
                                }
                            });
                        }
                    });
                });

            },
            error: function(error) {
                console.log(error);
            }
        });


        // 添加预约按钮点击事件
        $('#addReservationBtn').click(function() {
            // 在页面加载完毕时获取设备名称和会员名称列表
            fetchEquipmentNames();
            fetchMemberNames();
            Swal.fire({
                title: '添加预约',
                // Swal配置...
                didOpen: () => {
                    // 动态填充<select>的代码...
                    // 现在绑定change事件
                    // 监听设备名称的选择变化
                    $('#swal-input1, #swal-input2').change(function() {
                        // 获取选中的会员ID和设备ID
                        const memberId = $('#swal-input1').val();
                        const equipmentId = $('#swal-input2').val();
                        // 确保会员ID和设备ID都已选中
                        if (memberId && equipmentId) {
                            // 发送 AJAX 请求查询预约情况
                            $.ajax({
                                url: `${pageContext.request.contextPath}/reserve/equipmentAvailability`, // 确保URL是正确的
                                method: 'GET',
                                data: {
                                    memberId: memberId,
                                    equipmentId: equipmentId
                                },
                                success: function(response) {
                                    // 处理响应数据
                                    // 假设后端返回的数据结构是 { availableSlots: ["9:00-11:40", "14:30-17:00", "19:00-23:00"], ... }
                                    updateDateSelector(response.dailyReservationsCount);
                                    console.log("可预约的时间段：", response);
                                    // 在这里你可以更新页面上的某个元素，展示可预约的时间段
                                    // 例如更新一个列表或下拉选择框，使用户可以从中选择一个时间段
                                },
                                error: function(error) {
                                    console.error("获取预约情况失败：", error);
                                }
                            });
                        }
                    });
                },
                html: `
                    <label for="swal-input1">会员名称</label>
                    <select id="swal-input1" class="swal2-input"></select>
                    <label for="swal-input2">设备名称</label>
                    <select id="swal-input2" class="swal2-input"></select>
                    <label for="swal-input3">日期</label>
                    <select id="swal-input3" class="swal2-input"></select>
                    <div id="time-slot-container"></div>`,
                focusConfirm: false,
                preConfirm: () => {
                    return [
                        document.getElementById('swal-input1').value,
                        document.getElementById('swal-input2').value,
                        document.getElementById('swal-input3').value,
                        selectedTimeSlot
                    ]
                }
            }).then((result) => {
                if (result.value) {
                    // 获取表单数据
                    const [memberId, eqId, date, session] = result.value;
                    $.ajax({
                        url: `${pageContext.request.contextPath}/reserve/save`, // 修改为您的保存预约的后端接口URL
                        method: 'POST',
                        contentType: 'application/json', // 发送数据类型为 JSON
                            data: JSON.stringify({
                                memberId: memberId, // 直接发送会员ID
                                eqId: eqId, // 直接发送设备ID
                                date: date,
                                session: session
                            }),
                        success: function(response) {

                            // 预约成功提示
                            Swal.fire({
                                icon: 'success',
                                title: '预约成功',
                                text: '您的预约已成功添加！',
                                confirmButtonText: '确定'
                            }).then((result) => {
                                if (result.value) {
                                    // 刷新页面
                                    location.reload();

                                }
                            });
                        },
                        error: function(xhr, status, error) {
                            // 预约失败提示
                            Swal.fire({
                                icon: 'error',
                                title: '预约失败',
                                text: '无法完成预约，请稍后再试。',
                                confirmButtonText: '确定'
                            });
                        }
                    });

                }
            });
        });
        // 在页面加载完毕时获取设备名称和会员名称列表
        function fetchMemberNames() {
            $.ajax({
                url: '${pageContext.request.contextPath}/reserve/memberquery',
                method: 'GET',
                success: function(response) {
                    var memberSelect = $('#swal-input1'); // 假设这是会员名称选择的 <select> 元素的 ID
                    memberSelect.empty().append('<option value="">请选择会员</option>');
                    response.forEach(function(member) {
                        memberSelect.append(new Option(member.memberName, member.memberId)); // 假设每个会员有 name 和 id 字段
                    });
                },
                error: function(error) {
                    console.error("Failed to fetch member names:", error);
                }
            });
        }

        function fetchEquipmentNames() {
            $.ajax({
                url: '${pageContext.request.contextPath}/reserve/eqquery',
                method: 'GET',
                success: function(response) {
                    var equipmentSelect = $('#swal-input2'); // 假设这是设备名称选择的 <select> 元素的 ID
                    equipmentSelect.empty().append('<option value="">请选择设备</option>');
                    response.forEach(function(equipment) {
                        equipmentSelect.append(new Option(equipment.eqName, equipment.eqId)); // 假设每个设备有 name 和 id 字段
                    });
                },
                error: function(error) {
                    console.error("Failed to fetch equipment names:", error);
                }
            });
        }
        // 更新日期选择器的函数
        function updateDateSelector(dailyReservationsCount) {
            let dateSelect = $('#swal-input3'); // 日期选择器
            dateSelect.empty(); // 清空现有选项

            // 遍历后端提供的日期，添加到日期选择器中
            Object.keys(dailyReservationsCount).forEach(date => {
                dateSelect.append('<option value="' + date + '">' + date + '</option>'); // 添加日期选项
            });

            // 选择默认第一个日期，触发更新时间段选择器
            let initialDate = Object.keys(dailyReservationsCount)[0];
            if (initialDate) {
                dateSelect.val(initialDate); // 设置默认选中的日期
                updateTimeSlotSelector(dailyReservationsCount[initialDate]); // 根据第一个日期更新时间段
            }

            // 监听日期选择变化，更新时间段选择器
            dateSelect.change(function() {
                let selectedDate = $(this).val();
                updateTimeSlotSelector(dailyReservationsCount[selectedDate]);
            });
        }

        // 根据选定日期更新时间段选择器的函数
        // 根据选定日期更新时间段选择器的函数
        function updateTimeSlotSelector(reservationsForDate) {
            let timeSlotContainer = $('#time-slot-container');
            timeSlotContainer.empty(); // 清空现有内容

            // 遍历所选日期的时间段及其可预约情况
            Object.entries(reservationsForDate).forEach(([timeSlot, info]) => {
                // 根据是否可预约和是否已预约设置按钮样式
                let btnClass = info.reserved ? 'btn-secondary' : info.available ? 'btn-success' : 'btn-danger';
                let buttonText = timeSlot + (info.reserved ? ' (已预约)' : (info.available ? ' (可预约)' : ' (已满)'));

                let button = $('<button type="button" class="btn ' + btnClass + '" style="margin: 5px;" ' + (!info.available || info.reserved ? 'disabled' : '') + '>' + buttonText + '</button>');
                button.click(function() {
                    selectedTimeSlot = timeSlot; // 更新选中的时间段
                });
                timeSlotContainer.append(button); // 添加按钮到容器中
            });
        }


    });


</script>

</body>
</html>
