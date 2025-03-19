
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
                url:'${pageContext.request.contextPath}/menber/query',
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
                            return "<a title='充值' href='javascript:xufei(" + row.memberId + "," + row.memberbalance + ")' class='btn btn-primary btn-sm'><i class='fa fa-plus'></i> 充值</a>";

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
            $('#ycy').val(i);
            $('#updateeModal').modal('show');
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
</div>
</body>
</html>
