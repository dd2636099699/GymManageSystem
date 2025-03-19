
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js">
    window.onunload(alert("jin"))
</script>
<html>
<head>
    <title>会员续卡</title>
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

    <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/">--%>
    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/bootstrap-select-1.12.4/js/bootstrap-select.js"></script>--%>

    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/bootstrap/bootstrap-select-1.12.4/js/i18n/defaults-*.min.js"></script>--%>
    <style>
        .disabled-button {
            cursor: not-allowed; /* 鼠标悬停时显示禁止图标 */
            opacity: 0.65; /* 降低按钮透明度，使其看起来是禁用状态 */
            background-color: red; /* 背景色变红 */
            color: white; /* 文字颜色变为白色 */
        }
    </style>

    <script>
        var currentMemberBalance = 0; // 全局变量存储当前会员的余额
        var card = 0; // 全局变量存储当前卡费用
        var NewBalance = currentMemberBalance-card; // 全局变量存储当前卡费用
        $(document).ready(function () {
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
                url:'${pageContext.request.contextPath}/menber/query',
                method:'post',
                contentType:"application/x-www-form-urlencoded",
                columns:[
                    { field:'memberId',title:'会员编号',sortable: true},
                    { field:'memberName',title:'名称',sortable: true},
                    { field:'memberPhone',title:'电话',sortable: true},
                    { field:'membertypes.typeName',title:'卡类型'},
                    { field:'memberbalance',title:'余额/元',
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
                    { field:'memberxufei',title:'到期日期'},
                    { field:'xxx',title:'操作',
                        formatter:function (value,row,index) {
                            return "<a title='续卡' href='javascript:xufei(" + row.memberId + "," + row.memberbalance + ")' class='btn btn-success btn-sm'><i class='fa fa-repeat'></i> 续卡</a>";

                        }
                    },
                ],
                responseHandler: function (res) {
                    // 在这里，res 是从服务器返回的原始数据
                    console.log(res); // 使用 console.log 查看数据
                    return res; // 确保返回数据，以便表格可以正常使用它
                },
                queryParamsType:'',
                queryParams:queryParams,
                height:360,
                pageList:[5,10,15],
                pageNumber:1,
                pageSize:5,
                pagination:true,
                sidePagination:'server',
                onDblClickRow:function(row,$element,field) {

                }
            })


        });

        //获取当前的条件个页面页数即使更新值
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
        function xufei(id,balance) {
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
                    $('#xztype').html(tttt);
                })

            });
            $('#ycy').val(id);
            $('#updateeModal').modal('show');
        }
        function cz() {
            if(!validateAdd()){
                return;
            }
            var id=$('#ycy').val();
            var xztype=$('#xztype').val();
            var jine=$('#xzmoney').val();
            $.post("${pageContext.request.contextPath}/menber/cha",{"id":id},function (releset) {
                var memberxufei = releset.memberxufei;
                $.post("${pageContext.request.contextPath}/ktype/query2",{"xztype":xztype},function (releset) {
                    var typetian = releset.typeDay; // 卡的有效天数
                    card = releset.typemoney; // 卡的有效天数
                    var currentDate = new Date(); // 当前日期
                    var memberExpiryDate = new Date(memberxufei); // 会员当前的到期日期

                    // 确定基准日期：如果会员卡已过期，则从当前日期开始计算；否则，从会员卡的到期日期开始计算
                    var baseDate = currentDate >= memberExpiryDate ? currentDate : memberExpiryDate;

                    // 计算新的到期日期
                    baseDate.setDate(baseDate.getDate() + typetian);

                    // 格式化新的到期日期为 "年-月-日" 字符串
                    var newExpiryDateString = baseDate.getFullYear() + "-" + (baseDate.getMonth() + 1) + "-" + baseDate.getDate();
                    //续卡
                    $.post("${pageContext.request.contextPath}/menber/xuka",{"member.memberId":id,"membertype.typeId":xztype,"originalBalance":currentMemberBalance,"NewBalance":NewBalance,"daoqi":newExpiryDateString},function (releset) {
                        console.log("re",releset);
                        if(releset != null){
                            //
                            // $("#dg").bootstrapTable('load',releset) ;
                            // $('#updateeModal').modal('hide');
                            $('#dg').bootstrapTable('refresh');
                            $('#updateeModal').modal('hide');
                            swal(
                                {
                                    title:"续卡成功",
                                    type:"success",
                                    timer: 1500,
                                    showConfirmButton: false
                                }
                            )
                        }else{
                            swal(
                                {
                                    title:"续卡失败",
                                    type:"warning",
                                    timer: 1500,
                                    showConfirmButton: false
                                }
                            )
                        }
                    })
                })
            })
        }

        function validateAdd() {

            $("#xztype").parent().find("span").remove();

            var xztype = $("#xztype").val().trim();
            if(xztype==-1){
                $("#xztype").parent().append("<span style='color:red'>请选择会员卡型</span>");
                return false;
            }

            return true;
        }

        function sss() {
            var xztype = $('#xztype').val();
            if (xztype != 0) {
                $.post("${pageContext.request.contextPath}/ktype/query2", {xztype: xztype}, function (releset) {
                    $('#xzmoney').val(releset.typemoney); // 显示卡型金额
                    card = parseFloat(releset.typemoney); // 更新全局变量存储当前卡费用
                    NewBalance = currentMemberBalance - card; // 计算新余额
                    // 比较余额
                    if (currentMemberBalance < card) {
                        // 余额不足
                        $("#balanceInfo").html("<span style='color:red'>余额不足，请充值或重新选择！当前余额: " + currentMemberBalance + "</span>");
                        $('#czButton')
                            .prop('disabled', true) // 禁用按钮
                            .removeClass('btn-success') // 移除绿色样式
                            .addClass('btn-danger'); // 添加红色样式
                    } else {
                        // 余额充足
                        $("#balanceInfo").html("<span style='color:green'>余额充足,当前余额: " + currentMemberBalance + "</span>");
                        $('#czButton')
                            .prop('disabled', false) // 启用按钮
                            .removeClass('btn-danger') // 移除红色样式
                            .addClass('btn-success'); // 添加绿色样式
                    }
                });
            }
        }


    </script>
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
        </form>
    </div>

</div>
<%--//页面数据展示--%>
<div>
    <table id="dg"></table>
</div>
<%--续卡--%>
<div class="modal fade" id="updateeModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel">选择续卡类型</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div>
                        <label for="xztype" class="control-label">卡型:</label>
                        <select class="form-control" id="xztype" oninput="sss()">

                        </select>
                    </div>
                    <div>
                        <label for="xzmoney" class="control-label">金额:</label>
                        <input class="form-control" type="text" id="xzmoney" readonly="readonly" >
                    </div>
                    <div id="balanceInfo"></div> <!-- 用于显示余额信息的元素 -->
                    <input type="hidden" id="ycy">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary"  id="czButton" onclick="cz()">充值</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
