
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

    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.css" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/Moment.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/date/bootstrap-datetimepicker.min.js"></script>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/css/bootstrap-select.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.4/js/bootstrap-select.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/">--%>
    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/bootstrap-select-1.12.4/js/bootstrap-select.js"></script>--%>

    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/bootstrap-select-1.12.4/js/i18n/defaults-*.min.js"></script>--%>

    <script>
        var id1=0;
        var OriginalMoney1=0;
        var newMoney1=0;
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
            $('#dg').bootstrapTable({
                url:'${pageContext.request.contextPath}/menber/query8',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[
                    { field:'memberId',title:'会员编号',sortable: true},
                    { field:'memberName',title:'名称',sortable: true},
                    { field:'memberPhone',title:'电话',sortable: true},
                    { field:'membertypes.typeName',title:'卡类型'},
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
                    { field:'xxx',title:'余额/元',sortable: true,
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
                    { field:'xxx',title:'操作',
                        formatter:function (value,row,index) {
                            return "<a title='充值' href='javascript:xufei(" + row.memberId +","+row.memberbalance + ")' class='btn btn-primary btn-sm m-1'><i class='fa fa-plus'></i> 充值</a>" +
                                "<a title='续卡' href='javascript:chongzhi(" + row.memberId +","+row.memberbalance+ ")' class='btn btn-info btn-sm m-1'><i class='fa fa-refresh'></i> 续卡</a>";

                        }
                    },
                ],
                queryParamsType:'',
                queryParams:queryParams,
                height:360,
                pageList:[5,10,15],
                pageNumber:1,
                pageSize:5,
                pagination:true,
                sidePagination:'server',

                onClickRow:function(row,$element,field) {

                },
                // 指定初始排序字段和排序顺序
                sortName: 'memberbalance', // 按余额字段排序
                sortOrder: 'asc', // 升序排序，使余额小的在前面
            })
        });
        function chongzhi(id,balance) {
            currentMemberBalance = balance; // 更新全局余额变量
            //$('#xztype').empty();
            $.post("${pageContext.request.contextPath}/ktype/query",{},function (releset) {
                var e=releset;
                var tt ="";
                var tttt="";
                var ttt="<option value='-1'>"+"--请选择--"+"</option>";
                $(e).each(function () {
                    tt += "<option value='"+this.typeId+"'>"+""+this.typeName+"</option>";
                    tttt=ttt+tt;
                    $('#xztype8').html(tttt);
                })

            });
            $('#ycy').val(id);
            $('#updateeModal8').modal('show');
        }
        //获取当前的条件个页面页数即使更新值
        function queryParams(afds){
            var memberId = $('#memberId').val(); // 读取隐藏的input中的会员ID
            var i={
                "pageSize":afds.pageSize,
                "pageNumber":afds.pageNumber,
                "id":$('#hyid').val(),
                "ktype":$('#ktype').val(),
                memberId: memberId,// 将会员ID作为查询参数
                sortById:0,

            };
            return i;
        }
        //查询
        function search(){
            var opt=$('#dg').bootstrapTable('getOptions');
            var hyid=$('#hyid').val();
            var ktype=$('#ktype').val();
            $.post("${pageContext.request.contextPath}/menber/query",{"pageSize":opt.pageSize,"pageNumber":opt.pageNumber,"hyname":hyid,"ktype":ktype},function (releset) {
                $("#dg").bootstrapTable('load',releset) ;
            })
        }
        function xufei(i,memberBalance) {
            id1=i;
            OriginalMoney1=memberBalance;
            //$('#xztype').empty();
            $.post("${pageContext.request.contextPath}/ktype/query",{},function (releset) {
                var e=releset;
                $(e).each(function () {
                    $('#xztype').append('<option value='+this.typeId+' >'+this.typeName+'</option>');
                })
            });
            // $('#ycy').val(i);
            $('#updateeModal').modal('show');
        }
        function validateAdd8() {

            $("#xztype8").parent().find("span").remove();

            var xztype = $("#xztype8").val().trim();
            if(xztype==-1){
                $("#xztype8").parent().append("<span style='color:red'>请选择会员卡型</span>");
                return false;
            }

            return true;
        }
        function cz8() {
            if (!validateAdd8()) {
                return;
            }
            var id = $('#ycy').val();
            var xztype = $('#xztype8').val();
            var jine = $('#xzmoney8').val();

            Swal.fire({
                title: '确认续卡?',
                text: "是否确定续卡，扣余额" + jine + "元？",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '确认续卡',
                cancelButtonText: '取消'
            }).then((result) => {
                if (result.isConfirmed) {
                    // 用户点击"确认"
                    $.post("${pageContext.request.contextPath}/menber/cha", {"id": id}, function (releset) {
                        var memberxufei = releset.memberxufei;
                        $.post("${pageContext.request.contextPath}/ktype/query2", {"xztype": xztype}, function (releset) {
                            var typetian = releset.typeDay; // 卡的有效天数
                            var card = releset.typemoney; // 卡的价格
                            var currentDate = new Date(); // 当前日期
                            var memberExpiryDate = new Date(memberxufei); // 会员当前的到期日期

                            var baseDate = currentDate >= memberExpiryDate ? currentDate : memberExpiryDate;
                            baseDate.setDate(baseDate.getDate() + typetian);
                            var newExpiryDateString = baseDate.getFullYear() + "-" + (baseDate.getMonth() + 1) + "-" + baseDate.getDate();

                            // 执行续卡操作
                            $.post("${pageContext.request.contextPath}/menber/xuka", {"member.memberId": id, "membertype.typeId": xztype, "originalBalance": currentMemberBalance, "NewBalance": NewBalance, "daoqi": newExpiryDateString}, function (releset) {
                                if (releset != null) {
                                    $('#dg').bootstrapTable('refresh');
                                    $('#updateeModal8').modal('hide');
                                    Swal.fire({
                                        title: "续卡成功！",
                                        icon: "success",
                                        timer: 1500,
                                        showConfirmButton: false
                                    });
                                } else {
                                    Swal.fire({
                                        title: "续卡失败！",
                                        icon: "error",
                                        timer: 1500,
                                        showConfirmButton: false
                                    });
                                }
                            });
                        });
                    });
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    // 用户点击了"取消"或者关闭了弹窗
                    Swal.fire({
                        title: "续卡操作已取消！",
                        icon: "info",
                        timer: 1500,
                        showConfirmButton: false
                    });
                }
            });
        }

        function sss() {
            var xztype = $('#xztype8').val();
            if (xztype != 0) {
                $.post("${pageContext.request.contextPath}/ktype/query2", {xztype: xztype}, function (releset) {
                    $('#xzmoney8').val(releset.typemoney); // 显示卡型金额
                    card = parseFloat(releset.typemoney); // 更新全局变量存储当前卡费用
                    NewBalance = currentMemberBalance - card; // 计算新余额
                    // 比较余额
                    if (currentMemberBalance < card) {
                        // 余额不足
                        $("#balanceInfo").html("<span style='color:red'>余额不足，请充值或重新选择！当前余额: " + currentMemberBalance + "</span>");
                        $('#czButton8')
                            .prop('disabled', true) // 禁用按钮
                            .removeClass('btn-success') // 移除绿色样式
                            .addClass('btn-danger'); // 添加红色样式
                    } else {
                        // 余额充足
                        $("#balanceInfo").html("<span style='color:green'>余额充足,当前余额: " + currentMemberBalance + "</span>");
                        $('#czButton8')
                            .prop('disabled', false) // 启用按钮
                            .removeClass('btn-danger') // 移除红色样式
                            .addClass('btn-success'); // 添加绿色样式
                    }
                });
            }
        }
        function cz() {
            if (!validateAdd()) {
                return;
            }
            var jine = $('#xzmoney').val();
          newMoney1 = parseFloat(OriginalMoney1) + parseFloat(jine);
            Swal.fire({
                title: '确认充值',
                text: "是否确定充值" + jine + "元？",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '确认充值',
                cancelButtonText: '取消'
            }).then((result) => {
                if (result.isConfirmed) {
                    // 用户点击"确认"
                    $.post("${pageContext.request.contextPath}/cz/xin", {"member.memberId": id1, "czjine": jine,"newMoney":newMoney1,"OriginalMoney":OriginalMoney1}, function (response) {
                        if (response != null) {
                            $('#dg').bootstrapTable('refresh');
                            $('#updateeModal').modal('hide');
                            Swal.fire({
                                title: "充值成功！",
                                icon: "success",
                            });
                        } else {
                            Swal.fire({
                                title: "充值失败！",
                                icon: "error",
                            });
                        }
                    });
                } else {
                    // 用户点击了"取消"或者关闭了弹窗
                    Swal.fire({
                        title: "充值操作已取消！",
                        icon: "info",
                    });
                }
            });
        }
        function validateAdd() {
            $("#xzmoney").parent().find("span").remove();
            var xzmoney = $("#xzmoney").val().trim();
            if(xzmoney == null || xzmoney == ""){
                $("#xzmoney").parent().append("<span style='color:red'>请填写金额</span>");
                return false;
            }

            if(!(/^[1-9]\d*$/.test(xzmoney))){
                $("#xzmoney").parent().append("<span style='color:red'>金额只能为正整数</span>");
                return false;
            }
            return true;
        }
    </script>
</head>
<body background="${pageContext.request.contextPath}/static/HTmoban/images/tongji4.jpg">

<%--//页面数据展示--%>
<div>
    <table id="dg"></table>
</div>
<%--修改--%>
<div class="modal fade" id="updateeModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel">充值金额</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div>
                        <label for="xzmoney" class="control-label">金额:</label>
                        <input class="form-control" type="text" id="xzmoney">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="cz()">充值</button>
            </div>
        </div>
    </div>

    <input type="hidden" id="memberId" value="${sessionScope.user.memberId}">
</div>
<div class="modal fade" id="updateeModal8" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel8">选择续卡类型</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div>
                        <label for="xztype8" class="control-label">卡型:</label>
                        <select class="form-control" id="xztype8" oninput="sss()">

                        </select>
                    </div>
                    <div>
                        <label for="xzmoney8" class="control-label">金额:</label>
                        <input class="form-control" type="text" id="xzmoney8" readonly="readonly" >
                    </div>
                    <div id="balanceInfo"></div> <!-- 用于显示余额信息的元素 -->
                    <input type="hidden" id="ycy">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary"  id="czButton8" onclick="cz8()">续卡</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
