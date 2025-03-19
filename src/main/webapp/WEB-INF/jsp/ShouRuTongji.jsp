<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>会员与收入统计</title>
    <script src="${pageContext.request.contextPath}/static/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/echarts.min.js"></script>
    <style>
        .chart-container {
            width: 48%;
            height: 400px;
            float: left;
        }
        #yearSelectContainer {
            position: absolute;
            right: 10px;
            top: 10px;
            z-index: 1000;
        }
        #yearSelect {
            width: 200px;
            display: inline-block;
        }
    </style>
</head>
<body>
<div id="memberStatistics" class="chart-container"></div>
<div id="incomeStatistics" class="chart-container"></div>

<div id="yearSelectContainer">
    <select id="yearSelect" class="form-control">
        <!-- 年份选项将通过JavaScript动态加载 -->
    </select>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        loadYears();
        loadMemberStatistics();
    });


    function loadMemberStatistics() {

        $.get('${pageContext.request.contextPath}/menber/count', function(data) {
            var memberChart = echarts.init(document.getElementById('memberStatistics'));
            var totalMembers = data.totalMembers;
            var expiredMembers = data.expiredMembers;
            var activeMembers = totalMembers - expiredMembers;
            var option = {
                title: {
                    text: '会员总数: ' + totalMembers + ' 人',
                    subtext: '有效会员 ' + activeMembers + ' 人，到期会员 ' + expiredMembers + ' 人',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: '{a} <br/>{b}: {c} ({d}%)'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                    data: ['有效会员数', '到期会员数']
                },
                series: [
                    {
                        name: '会员统计',
                        type: 'pie',
                        radius: ['40%', '60%'],
                        center: ['50%', '60%'],
                        data: [
                            {value: activeMembers, name: '有效会员数'},
                            {value: expiredMembers, name: '到期会员数'}
                        ],
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        },
                        label: {
                            normal: {
                                formatter: '{b}\n{d}%'
                            }
                        },
                        labelLine: {
                            normal: {
                                show: true
                            }
                        }
                    }
                ]
            };
            memberChart.setOption(option);
        });
    }

    function loadYears() {
        $.get('${pageContext.request.contextPath}/cz/years', function(years) {
            var $yearSelect = $('#yearSelect');
            $yearSelect.empty();
            $.each(years, function(index, year) {
                $yearSelect.append($('<option>').val(year).text(year));
            });
            // 默认选中第一个年份
            if (years.length > 0) {
                $yearSelect.val(years[0]);
                updateIncomeChart(); // 用第一个年份更新收入图表
            }
            // 当年份选择器的选项改变时更新收入图表
            $yearSelect.change(updateIncomeChart);
        });
    }


    function updateIncomeChart() {
        var year = $('#yearSelect').val();
        if (!year) return; // Skip if "请选择" is selected
        $.post('${pageContext.request.contextPath}/cz/tongjiByYear', {year: year}, function(data) {
            var incomeChart = echarts.init(document.getElementById('incomeStatistics'));
            var option = {
                title: {
                    text: year + '年收入统计', // 在标题中显示所选年份
                    left: 'left'
                },
                tooltip: {},
                legend: { data:['收入'] },
                xAxis: { data: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"] },
                yAxis: {},
                series: [{
                    name: '收入',
                    type: 'bar',
                    data: data.monthlyNetIncome
                }]
            };
            incomeChart.setOption(option);
        });
    }
</script>
</body>
</html>
