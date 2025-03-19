
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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

    <script>
        var isCameraStarted = false;
        $(function () {
            $.post("${pageContext.request.contextPath}/ktype/query",{},function (releset) {
                var e=releset;
                $(e).each(function () {
                    $('#ktype').append('<option value='+this.typeId+' >'+this.typeName+'</option>');
                })
            });
            $('#srdata').datetimepicker({
                //viewMode: 'day',
                format: 'MM-DD'
            });
            $('#upsrdata').datetimepicker({
                //viewMode: 'day',
                format: 'MM-DD'
            });
            $('#dg').bootstrapTable({
                url:'${pageContext.request.contextPath}/menber/query',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                sortOrder: 'desc', // 设置排序方式为降序
                sortName: 'memberId', // 设置初始排序的列名为'memberId'
                columns:[
                    { field:'memberId',title:'会员编号'},
                    { field:'memberName',title:'名称'},
                    { field:'memberPhone',title:'电话'},
                    { field:'memberSex',title:'性别',
                        formatter:function (value,row,index) {
                            if(row.memberSex==0){
                                return "女";
                            }else{
                                return "男";
                            }
                        }
                    },
                    // { field:'memberAge',title:'年龄'},
                    { field:'birthday',title:'生日'},
                    { field:'membertypes.typeName',title:'卡类型'},
                    { field:'nenberDate',title:'录入日期'},
                    {
                        field: 'xxx', title: '会员状态',
                        formatter: function (value, row, index) {
                            if (row.memberStatic == 1) {
                                return "<p style='color:darkgreen'>正常</p>";
                            } else if (row.memberbalance < 50) {
                                return "<p style='color:red'>已到期，待充值</p>";
                            } else {
                                return "<p style='color:red'>已到期，待续卡</p>";
                            }
                        }
                    },
                    { field:'xxx',title:'余额/元',
                        formatter:function (value, row, index) {
                            // 如果余额小于50，字体显示为红色
                            if(row.memberbalance < 50){
                                return '<p style="color:red">' + row.memberbalance + '</p>';
                            }
                            // 余额大于等于50，字体显示为darkgreen色
                            else {
                                return '<p style="color:darkgreen">' + row.memberbalance + '</p>';
                            }
                        }
                    },
                    { field:'memberxufei',title:'到期日期'},
                    {
                        field: 'xx',
                        title: '操作',
                        formatter: function(value, row, index) {
                            return "<a title='编辑' href='javascript:upd1(" + row.memberId + ")'><i class='fa fa-edit'></i></a>" +
                                "<a title='删除' href='javascript:del(" + row.memberId + ")'><i class='fa fa-trash'></i></a>  ";

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
                onDblClickRow:function(row,$element,field) {
                    $('#updateeModal').modal('show');
                    $.post("${pageContext.request.contextPath}/ktype/query", {}, function (releset) {
                        var optionsHtml = "<option value='-1'>--请选择--</option>"; // 初始化选项字符串
                        var selectedTypeName = row.membertypes.typeName; // 从row对象中获取需要默认选中的类型名称
                        console.log("typeName",selectedTypeName);
                        $(releset).each(function () {
                            // 对每个选项进行遍历，并判断是否为需要默认选中的选项
                            var isSelected = this.typeName === selectedTypeName ? "selected" : "";
                            // 根据是否需要默认选中，动态添加selected属性
                            optionsHtml += "<option value='" + this.typeId + "' " + isSelected + ">" + this.typeName + "</option>";
                        });

                        // 将含有默认选中项的选项字符串设置到下拉列表中
                        $('#upoptype').html(optionsHtml);
                    });

                    $('#upname').val(row.memberName);
                    $('#upphone').val(row.memberPhone);
                    $('#upsex').val(row.memberSex);
                    $('#upsrdata').val(row.birthday);
                    $('#upoptype').val(row.membertypes.typeId);
                    $('#updata').val(row.nenberDate);
                    $('#upage').val(row.memberAge);
                    $('#upid').val(row.memberId);

                }
            })
        });

        //获取当前的条件个页面页数即使更新值f
        function queryParams(afds){
            var i={
                "pageSize":afds.pageSize,
                "pageNumber":afds.pageNumber,
                "id":$('#hyid').val(),
                "ktype":$('#ktype').val(),
                sortById:1,

            };
            return i;
        }
        //查询
        function search(){
            var opt=$('#dg').bootstrapTable('getOptions');
            var hyid=$('#hyid').val();
            var ktype=$('#ktype').val();


            $.post("${pageContext.request.contextPath}/menber/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"hyname":hyid,"ktype":ktype,"sortById":1},function (releset) {
                $("#dg").bootstrapTable('load',releset) ;
            })
        }
        function insert() {
            $('#exampleModal').modal('show');
            $.post("${pageContext.request.contextPath}/ktype/query",{},function (releset) {
                var e=releset;
                var tt ="";
                var tttt="";
                var ttt="<option value='-1'>"+"--请选择--"+"</option>";
                $(e).each(function () {
                    tt += "<option value='"+this.typeId+"'>"+""+this.typeName+"</option>";
                    tttt=ttt+tt;
                    $('#optype').html(tttt);
                })


            })
            var mydate = new Date();
            var str = "" + mydate.getFullYear() + "-";
            str += (mydate.getMonth()+1) + "-";
            str += mydate.getDate();

            $('#data').val(str)
        }
        function del(memid) {
            // 使用SweetAlert弹出确认对话框
            swal({
                title: "确定删除?",
                text: "一旦删除，将无法恢复该记录!",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "是的，删除它!",
                cancelButtonText: "取消",
                closeOnConfirm: false,
                closeOnCancel: true
            }, function(isConfirm){
                if (isConfirm) {
                    // 如果用户确认删除
                    $.post("${pageContext.request.contextPath}/menber/delete",{"memid":memid},function (releset) {
                        if(releset != null){
                            $("#dg").bootstrapTable('refresh'); // 更推荐使用'refresh'方法来刷新表格，而不是重新加载数据
                            swal("删除成功!", "记录已被删除。", "success");
                        }else{
                            swal("删除失败!", "请稍后再试或联系管理员。", "error");
                        }
                    });
                }
            });
        }

        function tianjia() {
            if(!validateAdd()){
                return;
            }
            var name=$('#name').val();
            var phone =$('#phone').val();
            var sex=$('#sex').val();
            var srdata=$('#srdata').val();
            var optype=$('#optype').val();
            var data=$('#data').val();
            var age=$('#age').val();


            $.post("${pageContext.request.contextPath}/ktype/query2",{"xztype":optype},function (releset) {
                var typetian=releset.typeDay;

                var date1 = new Date();
                var date2 = new Date(date1);
                var qb=date2.setDate(date1.getDate() + typetian);
                var rq=date2.getFullYear() + "-" + (date2.getMonth() + 1) + "-" + date2.getDate();
                $.post("${pageContext.request.contextPath}/menber/insert",{"memberName":name,"memberPhone":phone,"memberSex":sex,"birthday":srdata,"Membertypes.typeId":optype,"nenberDate":data,"memberAge":age,"Memberxufei":rq},function (releset) {
                    if(releset != null){
                        $("#dg").bootstrapTable('load',releset) ;
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
            })
        }

        function validateAdd() {
            $("#name").parent().find("span").remove();
            $("#phone").parent().find("span").remove();
            $("#age").parent().find("span").remove();
            $("#srdata").parent().find("span").remove();
            $("#optype").parent().find("span").remove();

            var name = $("#name").val().trim();
            if(name == null || name == ""){
                $("#name").parent().append("<span style='color:red'>请填写姓名</span>");
                return false;
            }

            var phone = $("#phone").val().trim();
            if(phone == null || phone == ""){
                $("#phone").parent().append("<span style='color:red'>请填写手机号</span>");
                return false;
            }

            if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(phone))){
                $("#phone").parent().append("<span style='color:red'>手机号码格式不正确</span>");
                return false;
            }

            var age = $("#age").val().trim();
            if(age == null || age == ""){
                $("#age").parent().append("<span style='color:red'>请填写年龄</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(age))){
                $("#age").parent().append("<span style='color:red'>年龄只能为正整数</span>");
                return false;
            }


            var srdata = $("#srdata").val().trim();
            if(srdata == null || srdata == ""){
                $("#srdata").parent().append("<span style='color:red'>请选择生日</span>");
                return false;
            }

            var optype = $("#optype").val().trim();
            if(optype==-1){
                $("#optype").parent().append("<span style='color:red'>请选择会员卡型</span>");
                return false;
            }
            return true;
        }


        function upd() {
            if(!validateUpd()){
                return;
            }
            var id=$('#upid').val();
            var name=$('#upname').val();
            var phone =$('#upphone').val();
            var sex=$('#upsex').val();
            var srdata=$('#upsrdata').val();
            var optype=$('#upoptype').val();
            var data=$('#updata').val();
            var age=$('#upage').val();
            $.post("${pageContext.request.contextPath}/ktype/query2",{"xztype":optype},function (releset) {
                var typetian=releset.typeDay;

                var date1 = new Date();
                var date2 = new Date(date1);
                var qb=date2.setDate(date1.getDate() + typetian);
                var rq=date2.getFullYear() + "-" + (date2.getMonth() + 1) + "-" + date2.getDate();
                $.ajax({
                    url: "${pageContext.request.contextPath}/menber/update",
                    type: "POST",
                    contentType: "application/json", // 指定发送数据的格式为JSON
                    data: JSON.stringify({
                        "memberId": id,
                        "memberName": name,
                        "memberPhone": phone,
                        "memberSex": sex,
                        "birthday": srdata,
                        "memberAge": age
                    }),
                    success: function(releset) {
                        // 刷新表格数据
                        $('#dg').bootstrapTable('refresh');
                        // 关闭模态框
                        $('#updateeModal').modal('hide');
                        // 显示成功提示
                        swal({
                            title: "修改成功",
                            type: "success",
                            timer: 1500,
                            showConfirmButton: false
                        });
                    },
                    error: function() {
                        // 显示失败提示
                        swal({
                            title: "修改失败",
                            type: "warning",
                            timer: 1500,
                            showConfirmButton: false
                        });
                    }
                });
            })
        }

        function validateUpd() {
            $("#upname").parent().find("span").remove();
            $("#upphone").parent().find("span").remove();
            $("#upage").parent().find("span").remove();
            $("#upsrdata").parent().find("span").remove();
            $("#upoptype").parent().find("span").remove();

            var upname = $("#upname").val().trim();
            if(upname == null || upname == ""){
                $("#upname").parent().append("<span style='color:red'>请填写姓名</span>");
                return false;
            }

            var upphone = $("#upphone").val().trim();
            if(upphone == null || upphone == ""){
                $("#upphone").parent().append("<span style='color:red'>请填写手机号</span>");
                return false;
            }

            if(!(/^1(3|4|5|6|7|8|9)\d{9}$/.test(upphone))){
                $("#upphone").parent().append("<span style='color:red'>手机号码格式不正确</span>");
                return false;
            }

            var upage = $("#upage").val().trim();
            if(upage == null || upage == ""){
                $("#upage").parent().append("<span style='color:red'>请填写年龄</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(upage))){
                $("#upage").parent().append("<span style='color:red'>年龄只能为正整数</span>");
                return false;
            }


            var upsrdata = $("#upsrdata").val().trim();
            if(upsrdata == null || upsrdata == ""){
                $("#upsrdata").parent().append("<span style='color:red'>请选择生日</span>");
                return false;
            }

            var upoptype = $("#upoptype").val().trim();
            if(upoptype==-1){
                $("#upoptype").parent().append("<span style='color:red'>请选择会员卡型</span>");
                return false;
            }

            return true;
        }

        function getMedia() {
            let video = document.getElementById("video");
            video.style.display = 'block'; // 显示视频元素
            let canvas = document.getElementById("canvas");

            let constraints = {
                video: {width: 250, height: 250},
                audio: false
            };

            if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
                navigator.mediaDevices.getUserMedia(constraints)
                    .then(function (stream) {
                        video.srcObject = stream;
                        video.play();
                        // 隐藏启动摄像头的按钮
                        $("#startCameraBtn").hide(); // 假设按钮的id是startCameraBtn
                        isCameraStarted = true; // 修改标志变量的值
                    })
                    .catch(function (err) {
                        console.error("Error accessing camera: ", err);
                    });
            } else {
                console.log("getUserMedia not supported");
            }
        }

        function takePhoto() {
            if (!isCameraStarted) {
                alert("请先启动摄像头。");
                return;
            }

            // 收集表单数据
            var userName = $("#userName").val();
            var phone = $("#phone").val();
            var sex = $("#sex").val();
            var age = $("#age").val();
            var srdata = $("#srdata").val();
            var optype = $("#optype").val();
            var memberPassword = $("#password").val();
            // 简单的表单验证
            if (!userName || !phone || !sex  || !srdata || !optype) {
                alert("所有字段均为必填，请确保信息完整。");
                return false;
            }
            // 捕获人脸图像
            let video = document.getElementById("video");
            let canvas = document.getElementById("canvas");
            let ctx = canvas.getContext('2d');
            ctx.drawImage(video, 0, 0, 250,  250);
            var base64File = canvas.toDataURL();
            var formData = new FormData();
            formData.append("file", base64File); // 人脸图片数据
            formData.append("name", userName);
            formData.append("phone", phone);
            formData.append("sex", sex);
            formData.append("age", age);
            formData.append("srdata", srdata);
            formData.append("optype", optype);
            formData.append("groupId", "101");
            formData.append("memberPassword", memberPassword);
            $.ajax({
                type: "post",
                url: "/faceAdd", // 实际的处理URL
                data: formData,
                contentType: false,
                processData: false,
                success: function (response) {
                    if (response.code === 0) {
                        alert("会员注册成功");
                        location.reload(); // 或执行其他逻辑，比如清空表单，关闭模态框等
                    } else {
                        alert(response.message);
                    }
                },
                error: function (error) {
                    console.error("错误响应：", error);
                    alert(JSON.stringify(error));
                }
            });
        }
        function validatePasswords() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            // 用于显示警告信息的元素，假设其ID为passwordWarning
            var warningElement = document.getElementById("passwordWarning");

            if (password !== confirmPassword) {
                // 显示警告信息
                if (warningElement) {
                    warningElement.style.display = 'block';
                    warningElement.textContent = "两次输入的密码不一致！";
                }
            } else {
                // 隐藏警告信息
                if (warningElement) {
                    warningElement.style.display = 'none';
                    warningElement.textContent = "";
                }
            }
        }
    </script>
    <style>
        /* 自定义表单组的底部外边距 */
        .custom-form-group {
            margin-bottom: 1px; /* 或者其他你希望的数值 */
        }
        .custom-input-sm {
            padding: 2px 6px; /* 进一步减少上下填充至2px，左右填充至6px */
            height: 26px; /* 减小高度至26px */
            font-size: 12px; /* 根据需要调整字体大小 */
        }
    </style>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">
    <%--    //查询--%>
    <div class="panel panel-default">
    <div class="panel-body">
        <form class="form-inline">
            <div  class="input-group input-daterange">
                <label for="hyid" class="control-label">姓名:</label>
                <input id="hyid" type="text" class="form-control">
            </div>
            <div  class="input-group input-daterange">
                <label for="ktype" class="control-label">卡型:</label>
                <select class="form-control" id="ktype">
                    <option value="0">请选择</option>
                </select>
            </div>

            <button onclick="search()" type="button" class="btn btn-default" style="margin-top: 20px" >查询</button>
             <button type="button" class="btn btn-default" style="float: right; margin-top: 20px" data-toggle="modal" onclick="insert()"><span class="glyphicon glyphicon-plus"></span>添加会员</button>
            <button type="button" id="download" style="margin-left:20px;" id="btn_download" class="btn btn-primary" onClick ="$('#dg').tableExport({ type: 'excel', escape: 'false' })">数据导出</button>
        </form>
    </div>

</div>
    <%--//页面数据展示--%>
    <div>
        <table id="dg"></table>
    </div>
<%--添加--%>
    <!-- 添加会员模态框 -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="exampleModalLabel">会员添加</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="row">
                            <!-- 表单输入部分，使用col-md-4使其更窄 -->
                            <div class="col-md-6">
                                <div class="form-group custom-form-group">
                                    <label for="userName" class="control-label">用户名:</label>
                                    <input type="text" class="form-control form-control-sm custom-input-sm" id="userName">
                                </div>
                                <div class="form-group custom-form-group">
                                    <label for="password" class="control-label"></label>
                                    <input type="password"  style="display: none" class="form-control form-control-sm custom-input-sm" id="password" value="admin123">
                                </div>
                                <div class="form-group custom-form-group">
                                    <label for="phone" class="control-label">电话:</label>
                                    <input type="text" class="form-control form-control-sm custom-input-sm" id="phone">
                                </div>
                                <div class="form-group custom-form-group">
                                    <label for="sex" class="control-label">性别:</label>
                                    <select class="form-control form-control-sm custom-input-sm" id="sex">
                                        <option value="1">男</option>
                                        <option value="0">女</option>
                                    </select>
                                </div>
                                <div class="form-group custom-form-group">
                                    <label for="age" class="control-label" style="display:none;">年龄:</label>
                                    <input type="text" style="display:none;" class="form-control form-control-sm custom-input-sm" id="age" value="1" >
                                </div>
                                <div class="form-group custom-form-group">
                                    <label for="srdata" class="control-label">生日:</label>
                                    <input type="text" class="form-control form-control-sm custom-input-sm" id="srdata">
                                </div>
                                <div class="form-group custom-form-group">
                                    <label for="optype" class="control-label">卡型:</label>
                                    <select class="form-control form-control-sm custom-input-sm" id="optype">
                                        <!-- 卡型选项 -->
                                    </select>
                                </div>
                            </div>
                            <!-- 摄像头部分，使用col-md-8填充剩余空间 -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">现拍照片用于人脸识别:</label>
                                    <div id="camera">
                                        <video id='video' width='250px' height='250px' autoplay='autoplay' style='margin-top: 20px'></video>
                                        <canvas id='canvas' width='250px' height='250px' style='display: none'></canvas>
                                    </div>
                                    <button id='startCameraBtn' type="button" class="btn btn-primary btn-sm" onclick="getMedia()">启动摄像头</button>
                                </div>
                            </div>
                            <div id="mainDiv">
                            </div>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary btn-sm" onclick="takePhoto()">添加</button>
                </div>
            </div>
        </div>
    </div>


<%--修改--%>
    <div class="modal fade" id="updateeModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="updateModalLabel">会员修改</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <input type="hidden" id="upid">
                        <div class="form-group">
                            <label for="upname" class="control-label">用户名:</label>
                            <input type="text" class="form-control" id="upname">
                        </div>
                        <div class="form-group">
                            <label for="upphone" class="control-label">电话:</label>
                            <input type="text" class="form-control" id="upphone">
                        </div>
                        <div class="form-group">
                            <label for="upsex" class="control-label">性别:</label>
                            <select class="form-control" id="upsex">
                                <option value="1">男</option>
                                <option value="0">女</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="upage" class="control-label" style="display: none">年龄:</label>
                            <input type="text" class="form-control" id="upage" style="display: none">
                        </div>
                        <div class="form-group">
                            <label for="upsrdata" class="control-label">生日:</label>
                            <input type="text" class="form-control" id="upsrdata">
                        </div>
                        <div class="form-group" style="display: none">
                            <label for="upoptype" class="control-label">卡型:</label>
                            <select class="form-control" id="upoptype">

                            </select>
                        </div>
                        <div class="form-group" style="display: none">
                            <label for="updata" class="control-label">时间:</label>
                            <input type="text" class="form-control" id="updata" disabled="disabled" >
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="upd()">修改</button>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
