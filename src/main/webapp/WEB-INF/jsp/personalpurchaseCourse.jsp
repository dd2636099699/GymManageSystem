
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
    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>



    <script>
        var globalCourseSale = null;
        $(function () {
            $("#subject").change(function () {
                var sid = $("#subject").val();
                $.post("${pageContext.request.contextPath}/private/cha",{"id":sid},function(e) {
                    $('#dj').val(e.sellingPrice);
                    var s = 1;
                    $('#sl').val(s);
                    $('#zje').val(e.sellingPrice*s);
                })
            })

            $(document).ready(function() {
                var memberId = $('#memberId').val(); // 从隐藏字段获取memberId
                // 构建请求的URL
                var requestUrl = "${pageContext.request.contextPath}" + "/CourseSale/findById?memberId=" + memberId;
                $.ajax({
                    url: requestUrl,
                    type: 'GET',
                    success: function(response) {
                        // 将响应赋值给全局变量
                        globalCourseSale = response;

                        console.log("CourseSale Details1:", globalCourseSale);
                        // 现在你可以在这里或者其他地方使用 globalCourseSale 变量
                    },
                    error: function(xhr, status, error) {
                        // 处理错误情况
                        console.error("Error fetching CourseSale:", xhr, status, error);
                    }
                });
            });



            $('#table').bootstrapTable({
                url: '${pageContext.request.contextPath}/courseSchedule/query7', // 更改为您的后端查询课程安排的URL
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
                        field: 'subject.sellingPrice', // 假设您的后端能够返回包含课程名称的对象
                        title: '价格'
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
                    {
                        field: 'xx',
                        title: '操作',
                        formatter: function(value, row, index) {
                            var memberId = $('#memberId').val();
                            var isPurchased = false;

                            // 检查globalCourseSale中是否存在匹配的scheduleId
                            if (globalCourseSale && globalCourseSale.length > 0) {
                                for (var i = 0; i < globalCourseSale.length; i++) {
                                    if (globalCourseSale[i].courseSchedule.scheduleId === row.scheduleId) {
                                        isPurchased = true;
                                        break;
                                    }
                                }
                            }

                            if (isPurchased) {
                                // 如果已购买，则使用按钮样式显示“已购买”提示，但不可点击
                                return "<button class='btn btn-success' disabled>已购买</button>";
                            } else {
                                // 如果未购买，则显示购买按钮
                                return "<button class='btn btn-primary' title='购买' onclick='purchase("
                                    + row.scheduleId + ", "
                                    + row.purchaseCount + ", \""
                                    + memberId + "\", "
                                    + row.subject.sellingPrice + ", "
                                    + row.classroom.capacity // 添加额外的参数
                                    + ")'><i class='glyphicon glyphicon-shopping-cart'></i> 购买</button>";
                            }
                        }
                    }




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
        function purchase(scheduleId, purchaseCount, memberId, sellingPrice,capacity) {
            // 首先检查是否还有足够的容量进行购买
            if (purchaseCount >= capacity) {
                // 如果购买数量大于或等于容量，显示容量不足的提示
                Swal.fire({
                    title: '容量不足',
                    text: "该课程的可购买容量不足，请选择其他课程。",
                    icon: 'error',
                    confirmButtonText: '好的'
                });
                return; // 结束函数执行
            }
            $.ajax({
                url: "${pageContext.request.contextPath}/menber/personalquery", // 更改为您的后端查询个人信息的URL
                method: 'POST',
                data: { memberId: memberId }, // 发送请求参数
                success: function(response) {
                    // 假设服务器返回的是JSON格式的数据，并且Memberbalance字段包含了会员余额
                    var memberBalance = response.memberbalance;

                    if (memberBalance >= sellingPrice) {
                        // 余额充足
                        Swal.fire({
                            title: '确认购买?',
                            text: "您的余额为：" + memberBalance + "，价格为：" + sellingPrice + "。余额充足。",
                            icon: 'warning',
                            showCancelButton: true,
                            confirmButtonColor: '#3085d6',
                            cancelButtonColor: '#d33',
                            confirmButtonText: '是的，购买！',
                            cancelButtonText: '取消' // 自定义取消按钮的文本
                        }).then((result) => {
                            if (result.isConfirmed) {
                                // 这里添加用户确认购买后的逻辑，例如发送购买请求等
                                $.ajax({
                                    url: "${pageContext.request.contextPath}/menber/personalpurchase", // 更改为您的后端处理购买请求的URL
                                    method: 'POST',
                                    data: {
                                        memberId: memberId, // 假设这是您要发送的会员ID
                                        scheduleId: scheduleId, // 假设这是您要购买的排课编号
                                        purchaseCount: purchaseCount+1, // 购买数量
                                        // 你可以添加更多需要发送的数据
                                    },
                                    success: function(response) {
                                        loadGlobalCourseSale();
                                        $('#table').bootstrapTable('refresh');
                                        // 购买成功的逻辑，例如弹出提示
                                        Swal.fire(
                                            '已购买!',
                                            '您的购买已成功。',
                                            'success'
                                        );
                                    },
                                    error: function(xhr, status, error) {
                                        // 处理错误情况
                                        Swal.fire({
                                            title: '购买失败!',
                                            text: '无法完成购买，请稍后再试。',
                                            icon: 'error',
                                            confirmButtonText: '好的'
                                        });
                                    }
                                });
                            } else if (result.dismiss === Swal.DismissReason.cancel) {
                                // 如果用户点击了取消按钮，可以在这里添加相应的逻辑
                                Swal.fire(
                                    '已取消',
                                    '您取消了购买操作。',
                                    'error'
                                );
                            }
                        });
                    } else {
                        // 余额不足
                        Swal.fire({
                            title: '余额不足',
                            text: "您的余额为：" + memberBalance + "，价格为：" + sellingPrice + "。请充值。",
                            icon: 'error',
                            confirmButtonColor: '#3085d6',
                            confirmButtonText: '好的'
                        });
                    }
                },
                error: function(xhr, status, error) {
                    // 处理错误情况
                    Swal.fire({
                        title: '出错了!',
                        text: '无法获取会员信息，请稍后再试。',
                        icon: 'error',
                        confirmButtonText: '好的'
                    });
                }
            });

        }

        function loadGlobalCourseSale() {
            var memberId = $('#memberId').val(); // 从隐藏字段获取memberId
            var requestUrl = "${pageContext.request.contextPath}" + "/CourseSale/findById?memberId=" + memberId;
            $.ajax({
                url: requestUrl,
                type: 'GET',
                success: function(response) {
                    globalCourseSale = response;
                    console.log("CourseSale Details2:", globalCourseSale);
                },
                error: function(xhr, status, error) {
                    console.error("Error fetching CourseSale:", xhr, status, error);
                }
            });
        }

        function kan1() {
            $("#myModal3").modal("show");
            $('#tb').bootstrapTable({
                url:'${pageContext.request.contextPath}/private/query2',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[{ radio:true
                }, {
                    field: 'memberId',
                    title: '编号'
                },{
                    field: 'memberName',
                    title: '会员名称'
                },{
                    field: 'membertypes.typeName',
                    title: '会员类型'
                }
                ],
                queryParamsType:'',
                queryParams:queryParams,
                height:360,
                pagination:true,
                onDblClickRow: function (row) {
                    $('#myModal3').modal("hide");
                    id = row.memberId;
                    $.post("${pageContext.request.contextPath}/private/cha2",{"id":id},function(e) {
                        $.post("${pageContext.request.contextPath}/privateinfo/count",{'memid':id},function(e) {
                            $('#cishu').text(e);
                        })
                        $('#kh').val(e.memberId);
                        $('#xm').text(e.memberName);
                        $('#type').text(e.membertypes.typeName);
                        $('#dqdate').text(e.memberxufei);
                        $('#hystatic').text(e.memberStatic);
                        if(e.memberStatic==1){
                            $('#hystatic').text("正常");
                        }else{
                            $('#hystatic').text("请续费");
                        }
                    })
                }
            })
        }
        function kan2() {
            $("#myModal3").modal("show");
            $('#tb').bootstrapTable({
                url:'${pageContext.request.contextPath}/private/query2',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[{ radio:true
                }, {
                    field: 'memberId',
                    title: '编号'
                },{
                    field: 'memberName',
                    title: '会员名称'
                },{
                    field: 'membertypes.typeName',
                    title: '会员类型'
                }
                ],
                queryParamsType:'',
                queryParams:queryParams,
                height:360,
                pagination:true,
                onDblClickRow: function (row) {
                    $('#myModal3').modal("hide");
                    id = row.memberId;
                    $.post("${pageContext.request.contextPath}/private/cha2",{"id":id},function(e) {
                        $('#memberid').val(e.memberId);
                    })
                }
            })
        }
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
                        var opt=$('#table').bootstrapTable('getOptions');
                        var coachid=$('#coachid').val();
                        var subjectid=$('#subjectid').val();
                        var memberid=$('#memberid').val();
                        $.post('${pageContext.request.contextPath}/privateinfo/del',{'id':id,"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"coachid":coachid,"subjectid":subjectid,"memberid":memberid},function(data){
                            //重新给table绑定数据
                            $("#table").bootstrapTable("load",data) ;
                        }) ;
                        swal("删除！", "删除成功",
                            "success");
                    } else {
                        swal("取消！", "您已取消删除)",
                            "error");
                    }
                });
        }
        //获取当前的条件个页面页数即使更新值
        function queryParams(afds){
            var i={
                "pageSize":afds.pageSize,
                "pageNumber":afds.pageNumber,
                "coach.coachid":$('#coachid').val(),
                "subject.subjectid":$('#subjectid').val(),
                "member.memberid":$('#memberid').val(),
            };
            return i;
        }
        //查询
        function search(){
            var opt=$('#table').bootstrapTable('getOptions');
            var coachid=$('#coachid').val();
            var subjectid=$('#subjectid').val();
            var memberid=$('#memberid').val();
            $.post("${pageContext.request.contextPath}/privateinfo/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"coachid":coachid,"subjectid":subjectid,"memberid":memberid},function (releset) {
                $("#table").bootstrapTable('load',releset) ;
            })
        }
        //下拉框赋值
        function totian() {
            event.preventDefault(); // 阻止事件的默认行为，如表单提交
            // 清空下拉列表
            $('#editClassroomSelect2, #coach, #subject').empty();
            // 添加默认选项到下拉列表，如果需要
            $('#editClassroomSelect2, #coach, #subject').append('<option value="">--请选择--</option>');

            // 清空表单字段
            $('#dj').val(""); // 单价
            $('#editStartTime2').val(""); // 开始时间
            $('#editEndTime2').val(""); // 结束时间

            // 发送请求获取教室列表，并填充到下拉列表中
            $.post("${pageContext.request.contextPath}/classRoom/query9", function(classrooms) {
                var classroomsOptions = "<option value='-1'>--请选择--</option>"; // 添加默认选项
                $(classrooms).each(function() {
                    classroomsOptions += "<option value='" + this.classroomId + "'>" + this.classroomName + "</option>";
                });
                $('#editClassroomSelect2').html(classroomsOptions); // 使用.html()替换下拉列表的内容
            });


            // 获取教练和主题信息
            $.post("${pageContext.request.contextPath}/private/topcoach", {}, function (releset) {
                var coaches = "<option value='-1'>--请选择--</option>";
                $(releset.coach).each(function () {
                    coaches += "<option value='" + this.coachId + "'>" + this.coachName + "</option>";
                });
                $('#coach').html(coaches);

                var subjects = "<option value='-1'>--请选择--</option>";
                $(releset.subject).each(function () {
                    subjects += "<option value='" + this.subId + "'>" + this.subname + "</option>";
                });
                $('#subject').html(subjects);
            });
            // 显示模态框
            $('#myModal').modal('show');
        }
        function validateTimes() {
            var startTimeInput = document.getElementById('editStartTime2');
            var endTimeInput = document.getElementById('editEndTime2');
            var startTimeError = document.getElementById('startTimeError');
            var endTimeError = document.getElementById('endTimeError');

            var startTime = new Date(startTimeInput.value);
            var endTime = new Date(endTimeInput.value);
            var now = new Date();
            now.setHours(0, 0, 0, 0); // 将当前时间的时分秒毫秒清零

            // 清除旧的错误消息
            startTimeError.textContent = '';
            endTimeError.textContent = '';

            var valid = true;

            if (startTime < now) {
                startTimeError.textContent = '开始时间不能早于当前日期。';
                valid = false;
            }

            if (startTime >= endTime) {
                endTimeError.textContent = '开始时间必须小于结束时间。';
                valid = false;
            }

            return valid;
        }

        function save() {
            if(!validateTimes()){
                return;
            }

            // 构建表单数据对象
            var formData = {
                classroomId: $('#editClassroomSelect2').val(), // 教室ID
                coachId: $('#coach').val(), // 教练ID
                subjectId: $('#subject').val(), // 课程ID
                startTime: $('#editStartTime2').val(), // 开始时间
                endTime: $('#editEndTime2').val() // 结束时间
            };
            console.log("data",formData);
            // 发送AJAX请求到服务器保存数据
            $.ajax({
                url: "${pageContext.request.contextPath}/courseSchedule/add", // 更改为您的保存课程安排的后端URL
                type: 'POST',
                contentType: 'application/json', // 如果后端需要JSON格式
                data: JSON.stringify(formData), // 将对象转换为JSON字符串
                success: function(response) {
                    // 处理成功响应
                    if(response.success) {
                        $('#myModal').modal('hide'); // 关闭模态框
                        swal("保存成功！", response.message, "success");
                        // 这里可以添加代码来刷新页面上的课程列表，例如重新加载表格数据
                        $('#table').bootstrapTable('refresh');
                    } else {
                        swal("保存失败", response.message, "error");
                    }
                },
                error: function(xhr, textStatus, errorThrown) {
                    // 尝试获取更详细的错误信息
                    var errorMessage = xhr.responseJSON && xhr.responseJSON.message ? xhr.responseJSON.message : textStatus;
                    swal("添加失败", errorMessage, "error");
                }

            });
        }


        function validateAdd() {
            $("#kh").parent().find("span").remove();
            $("#coach").parent().find("span").remove();
            $("#datett").parent().find("span").remove();
            $("#subject").parent().find("span").remove();
            $("#sl").parent().find("span").remove();
            $("#ssq").parent().find("span").remove();


            var kh = $("#kh").val().trim();
            if(kh == null || kh == ""){
                $("#kh").parent().append("<span style='color:red'>请选择会员卡号</span>");
                return false;
            }

            var coach = $("#coach").val().trim();
            if(coach==-1){
                $("#coach").parent().append("<span style='color:red'>请选择教练姓名</span>");
                return false;
            }

            var datett = $("#datett").val().trim();
            if(datett == null || datett == ""){
                $("#datett").parent().append("<span style='color:red'>请选择购买日期</span>");
                return false;
            }

            var subject = $("#subject").val().trim();
            if(subject==-1){
                $("#subject").parent().append("<span style='color:red'>请选择项目名称</span>");
                return false;
            }



            var sl = $("#sl").val().trim();
            if(sl == null || sl == ""){
                $("#sl").parent().append("<span style='color:red'>请填写数量</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(sl))){
                $("#sl").parent().append("<span style='color:red'>须为正整数</span>");
                return false;
            }

            var ssq = $("#ssq").val().trim();
            if(ssq == null || ssq == ""){
                $("#ssq").parent().append("<span style='color:red'>请填写实收钱</span>");
                return false;
            }

            if(!(/^[0-9,.]*$/.test(ssq))){
                $("#ssq").parent().append("<span style='color:red'>实收钱只能为正整数或小数</span>");
                return false;
            }


            return true;
        }
        //修改
        // 修改
        function upd2(scheduleId, classroomName, coachName, subjectName, startTime, endTime, courseStatus) {
            // 清空下拉列表
            $('#editClassroomSelect1').empty();
            $('#editCoachSelect2').empty();
            $('#editSubjectSelect3').empty();

            // 发送请求获取教室列表，并填充到下拉列表中
            $.post("${pageContext.request.contextPath}/classRoom/query9", function(classrooms) {
                classrooms.forEach(function(classroom) {
                    var selected = classroom.classroomName === classroomName ? 'selected' : '';
                    var optionHtml = '<option value="' + classroom.classroomId + '" ' + selected + '>' + classroom.classroomName + '</option>';
                    $('#editClassroomSelect1').append(optionHtml);
                });
            });

// 发送请求获取教练列表，并填充到下拉列表中
            $.post("${pageContext.request.contextPath}/coach/query9", function(coaches) {
                coaches.forEach(function(coach) {
                    var selected = coach.coachName === coachName ? 'selected' : '';
                    var optionHtml = '<option value="' + coach.coachId + '" ' + selected + '>' + coach.coachName + '</option>';
                    $('#editCoachSelect2').append(optionHtml);
                });
            });

// 发送请求获取课程列表，并填充到下拉列表中
            $.post("${pageContext.request.contextPath}/subject/query9", function(subjects) {
                subjects.forEach(function(subject) {
                    var selected = subject.subname === subjectName ? 'selected' : '';
                    var optionHtml = '<option value="' + subject.subId + '" ' + selected + '>' + subject.subname + '</option>'; // 确保这里是subId，而不是subnameId，除非你的数据确实有这个字段
                    $('#editSubjectSelect3').append(optionHtml);
                });
            });


            // 填充其他字段
            $('#editScheduleId').val(scheduleId);
            $('#editStartTime').val(startTime);
            $('#editEndTime').val(endTime);
            $('#editCourseStatus').val(courseStatus);

            // 显示模态框
            $('#editModal01').modal('show');
        }





        //删除
        function del2(id){
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
                        $.post('${pageContext.request.contextPath}/courseSchedule/delete', {'classroomId': id}, function(data) {
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
        //保存
        function saveChanges() {
            var formData = $('#editScheduleForm').serialize(); // 获取表单数据
            console.log("data",formData);
            // 发送AJAX请求到后端保存数据
            $.ajax({
                url: "${pageContext.request.contextPath}/courseSchedule/update", // 更改为您的更新课程安排的后端URL
                type: 'POST',
                data: formData,
                success: function(response) {
                    if(response.success) {
                        $('#editModal01').modal('hide'); // 关闭模态对话框
                        $('#table').bootstrapTable('refresh'); // 刷新表格
                        swal("更新成功！",response.message, "success");
                    } else {
                        swal("更新失败：" , response.message, "error");
                    }
                },
                error: function(xhr) {
                    var errorMsg = "更新失败：未知错误";
                    if(xhr.responseJSON && xhr.responseJSON.message) {
                        errorMsg =xhr.responseJSON.message;
                    }
                    swal("更新失败",errorMsg, "error");
                }
            });
        }




        //修改赋值
        function upd(id){
            $("#myModal2").modal("show");
            $('#id').val(id);
            $.post('${pageContext.request.contextPath}/privateinfo/cha',{'id':id},function(data){
                $("#table").bootstrapTable("load",data) ;
                $("#hykh").text(data.member.memberId);
                $("#hyxm").text(data.member.memberName);
                $("#yssj").text(data.coach.coachName);
                $.post("${pageContext.request.contextPath}/private/topcoach",{},function (releset) {
                    var e=releset;
                    var tt ="";
                    var tttt="";
                    var ttt="<option value='-1'>"+"--请选择--"+"</option>";
                    $(e.coach).each(function () {
                        tt += "<option value='"+this.coachId+"'>"+"❤"+this.coachName+"</option>";
                        tttt=ttt+tt;
                        $('#xgcoach').html(tttt);
                    })
                })
            }) ;
        }
        //修改
        function upd1() {
            if(!validateUpd()){
                return;
            }
            var opt=$('#table').bootstrapTable('getOptions');
            var coachid=$('#coachid').val();
            var subjectid=$('#subjectid').val();
            var memberid=$('#memberid').val();
            var id =  $('#id').val();
            var coachname = $("#xgcoach").val();
            $("#myModal2").modal("hide") ;
            $.post('${pageContext.request.contextPath}/privateinfo/upd',{'pid':id,'coach.coachId':coachname},function(data){
                $.post("${pageContext.request.contextPath}/privateinfo/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"coachid":coachid,"subjectid":subjectid,"memberid":memberid},function (releset) {
                    $("#table").bootstrapTable('load',releset) ;
                })
                $("#table").bootstrapTable("load",data) ;
                swal("修改！", "修改成功",
                    "success");
            }) ;
        }

        function validateUpd() {

            $("#xgcoach").parent().find("span").remove();

            var xgcoach = $("#xgcoach").val().trim();
            if(xgcoach==-1){
                $("#xgcoach").parent().append("<span style='color:red'>请选择变更私教</span>");
                return false;
            }

            return true;
        }


        function zql() {
            var jine=$('#zje').val();
            var ssjine=$('#ssq').val();
            var zhao=ssjine-jine;
            $('#zl').val(zhao);
        }

        function slChange() {
            var sl = $('#sl').val();
            var dj = $('#dj').val();
            var s = sl * dj;
            $('#zje').val(s);
        }

    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">
<%--    //查询--%>
<div class="panel panel-default">
    <div class="panel-body">
        <form class="form-inline">
            <%--                <div class="form-group">--%>
            <%--                    会员编号：<input id="memberid" type="text" class="form-control" placeholder="请输入会员编号">--%>
            <%--                    <a title='查询' onclick="kan2()" href="#"><span class='glyphicon glyphicon-search'></span></a>--%>
            <%--                  </div>--%>

            <%--                教练名称:--%>
            <%--                <select id="coachid" class="form-control">--%>
            <%--                    <option value="">请选择</option>--%>
            <%--                    <c:forEach items="${a.coach}" var="coachq">--%>
            <%--                        <option value="${coachq.coachId}">${coachq.coachName}</option>--%>
            <%--                    </c:forEach>--%>
            <%--                </select>--%>
            <%--                课程编号:--%>
            <%--                <select id="subjectid" class="form-control">--%>
            <%--                    <option value="">请选择</option>--%>
            <%--                    <c:forEach items="${a.subject}" var="s">--%>
            <%--                        <option value="${s.subId}">${s.subname}</option>--%>
            <%--                    </c:forEach>--%>
            <%--                </select>--%>
            <%--            <button onclick="search()" type="button" class="btn btn-default" >查询</button>--%>
            <button type="button" class="btn btn-default" style="float: right; display: none" onclick="totian(event)"><span class="glyphicon glyphicon-plus"></span>安排新课程</button>




        </form>
    </div>

</div>
<%--//页面数据展示--%>
<div>
    <table id="table"></table>
</div>
<div class="modal fade" id="myModal">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">安排新课程</h4>
            </div>
            <div class="modal-body">
                <!-- form开始 -->
                <form>
                    <table style="margin-top:10px;border:1px solid #ccc;padding:20px;margin-bottom:20px;">
                        <!-- 教室名称 -->
                        <tr style="margin: 20px; margin-left: 20px;padding: 20px;">
                            <td style="width:450px;padding-left: 20px">
                                <label style="float: left;margin-top: 10px">教室名称：</label>
                                <select style="margin-top: 10px;width: 300px" id="editClassroomSelect2" class="form-control">
                                    <!-- 动态生成的教室选项将在这里插入 -->
                                </select>
                            </td>
                        </tr>
                        <!-- 教练姓名 -->
                        <tr style="margin: 20px; margin-left: 20px;padding: 20px;">
                            <td style="width:450px;padding-left: 20px">
                                <label style="float: left;margin-top: 10px">教练姓名：</label>
                                <select style="margin-top: 10px;width: 300px" id="coach" class="form-control">
                                    <!-- 教练选项 -->
                                </select>
                            </td>
                        </tr>
                        <!-- 项目名称 -->
                        <tr style="margin: 20px; margin-left: 20px;padding: 20px;">
                            <td style="width:400px;padding-left: 20px">
                                <label style="float: left;margin-top: 10px">课程名称：</label>
                                <select style="margin-top: 10px;width: 300px" id="subject" class="form-control">
                                    <!-- 项目选项 -->
                                </select>
                            </td>
                            <td style="width:500px">
                                <label style="float: left;margin-top: 10px">单&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：</label>
                                <input type="text" id="dj" readonly style="float: left;margin-top: 10px;width: 125px" class="form-control">
                            </td>
                        </tr>
                        <!-- 开始时间 -->
                        <tr>
                            <td>
                                <label>开始时间：</label>
                                <input type="datetime-local" id="editStartTime2" class="form-control" name="startTime">
                                <span id="startTimeError" class="text-danger"></span> <!-- 错误消息展示 -->
                            </td>
                        </tr>
                        <!-- 结束时间 -->
                        <tr>
                            <td>
                                <label>结束时间：</label>
                                <input type="datetime-local" id="editEndTime2" class="form-control" name="endTime">
                                <span id="endTimeError" class="text-danger"></span> <!-- 错误消息展示 -->
                            </td>
                        </tr>

                    </table>
                </form>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button onclick="save()" id="add" type="button" class="btn btn-primary">提交</button>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="myModal3">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- form开始 -->
                <table id="tb"></table>
                &nbsp;
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal2">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">❤变更私教</h4>
            </div>
            <div class="modal-body">
                <!-- form开始 -->
                <form>
                    <input type="hidden" id="id" name="id">
                    <table  style="width: 90%;margin: 0px auto">
                        <tr style="width: 100%">
                            <td style="width: 280px;height: 35px;">会员卡号：<span id="hykh"></span></td>
                            <td style="width:280px;height: 35px;">会员姓名：<span id="hyxm"></span></td>
                        </tr>
                        <tr style="width: 100%">
                            <td style="width: 280px;height: 35px;">原始私教：<span id="yssj"></span></td>
                            <td style="width: 280px;height: 35px;">变更私教：
                                <select style="width: 140px;float: right;margin-right: 30px" id="xgcoach"  class="form-control">
                                    <option value="-1">--请选择--</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </form>
                &nbsp;
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button onclick="upd1()"  type="button" class="btn btn-primary">修改</button>
                </div>
            </div>
        </div>
    </div></div>
<%--"修改"--%>
<!-- Edit Schedule Modal -->
<div class="modal fade" id="editModal01" tabindex="-1" role="dialog" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">编辑课程安排</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editScheduleForm">
                    <div class="form-group">
                        <label for="editScheduleId">排课编号</label>
                        <input type="text" class="form-control" id="editScheduleId" name="scheduleId" readonly>
                    </div>
                    <div class="form-group">
                        <label for="editClassroomSelect1">教室</label>
                        <select class="form-control" id="editClassroomSelect1" name="classroomId">
                            <!-- 动态生成的教室选项将在这里插入 -->
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editCoachSelect2">教练名称</label>
                        <select class="form-control" id="editCoachSelect2" name="coachId">
                            <!-- 动态生成的教练选项将在这里插入 -->
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editSubjectSelect3">课程名称</label>
                        <select class="form-control" id="editSubjectSelect3" name="subjectId">
                            <!-- 动态生成的课程选项将在这里插入 -->
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="editStartTime">开始时间</label>
                        <input type="text" class="form-control" id="editStartTime" name="startTime">
                    </div>
                    <div class="form-group">
                        <label for="editEndTime">结束时间</label>
                        <input type="text" class="form-control" id="editEndTime" name="endTime">
                    </div>
                    <div class="form-group" style="display: none;">
                        <label for="editCourseStatus">课程状态</label>
                        <select class="form-control" id="editCourseStatus" name="courseStatus">
                            <option value="1">待进行</option>
                            <option value="2">进行中</option>
                            <option value="3">已完成</option>
                        </select>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="saveChanges()">保存更改</button>
            </div>
        </div>
    </div>

</div>
<input type="hidden" id="memberId" value="${sessionScope.user.memberId}">
<input type="hidden" id="memberbalance" value="${sessionScope.user.memberbalance}">

</body>
</html>
