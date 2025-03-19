<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>人脸识别系统</title>
    <script src="<c:url value='/static/jquery/jquery-3.3.1.min.js'/>"></script>
    <script src="<c:url value='/static/jquery/tracking-min.js'/>"></script>
    <script src="<c:url value='/static/jquery/face-min.js'/>"></script>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        .container {
            width: 100%;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        #canvasContainer {
            height: 400px;
            position: relative;
        }

        #video2 {
            width: 400px;
            height: 400px;
            z-index: 1;
        }

        #canvas2 {
            position: absolute;
            top: 0;
            left: 0;
            display: block;
            background-color: transparent;
            z-index: 2;
        }

        button {
            margin: 10px;
            padding: 10px;
            font-size: 16px;
        }
        table.hovertable {
            font-family: verdana,arial,sans-serif;
            font-size:11px;
            color:#333333;
            border-width: 1px;
            border-color: #999999;
            border-collapse: collapse;
        }
        table.hovertable th {
            background-color:#c3dde0;
            border-width: 1px;
            padding: 8px;
            border-style: solid;
            border-color: #a9c6c9;
        }
        table.hovertable tr {
            background-color:#d4e3e5;
        }
        table.hovertable td {
            border-width: 1px;
            padding: 8px;
            border-style: solid;
            border-color: #a9c6c9;
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            width: 100%;
            height: 100vh;
        }

        .content-container {
            display: flex;
            justify-content: start; /* 从容器的起始边缘开始排列子元素 */
            align-items: flex-start;
            padding: 20px;
        }


        .face-search-container, .data-display-container {
            margin: 10px; /* 添加一些外边距 */
            /* 如果需要，可以为这些容器设置具体的宽度 */
        }

        .button-container {
            text-align: center; /* 将按钮居中对齐 */
            margin-bottom: 10px; /* 在按钮和视频之间添加一些间距 */
        }

        #canvasContainer, #video2, #canvas2 {
            /* 保持原样式，确保视频和画布正确显示 */
        }

        .data-display-container {
            display: flex;
            justify-content: space-around; /* 两侧内容间隔均匀 */
            align-items: flex-start; /* 顶部对齐 */
        }

        #arrived, #absent {
            flex: 1; /* 让两个容器各占一半空间 */
            margin: 10px; /* 添加一些外边距 */
        }
    </style>


</head>
<body>

<div class="container">
    <div class="content-container">
        <div id="regcoDiv" class="face-search-container">
            <!-- 人脸识别部分内容：按钮、视频和画布 -->
            <!-- 开始和结束按钮 -->
            <div class="button-container">
                <button id="startButton" onclick="startTracking()">开始识别</button>
                <button id="stopButton" onclick="stopTracking()">结束识别</button>
            </div>
            <!-- 画布容器 -->
            <div id="canvasContainer">
                <video id="video2" width="400px" height="400px" autoplay="autoplay"></video>
                <canvas id="canvas2" width="400px" height="400px"></canvas>
            </div>
        </div>

        <div class="data-display-container">
            <div id="arrived">
<%--                <h3>已到人数</h3>--%>
                <table class="hovertable" id="arrivedTable">
                    <thead>
                    <tr>
                        <!-- 使用style属性调整字体大小和加粗 -->
                        <th colspan="2" style=" font-size: 20px; font-weight: bold;">已到人数表</th>
                    </tr>
                    <tr>
                        <th>用户姓名</th>
                        <th>签到时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- 动态添加的已到人员数据行将放在这里 -->
                    </tbody>
                </table>
            </div>
            <div id="absent">
<%--                <h3>未到人数11</h3>--%>
                <table class="hovertable" id="absentTable">
                    <thead>
                    <tr>
                        <th style="font-size: 20px; font-weight: bold;">
                            未到人数表
                        </th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- 动态添加的已到人员数据行将放在这里 -->
                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>

<script>
    let isAllowedToCallF = true; // 设置一个标记变量，初始允许调用f()
    let lastTrackedRectangles = [];
    let tracker;
    let trackingTask;
    let lastProcessTime = 0; // 添加控制变量
    function redrawRectangles(data) {
        let canvas = document.getElementById("canvas2");
        let ctx = canvas.getContext('2d');
        // 延迟1秒后再次清除画布
        setTimeout(function() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
        }, 1000);


        // 绘制方框和文本
        lastTrackedRectangles.forEach(function (rect) {
            ctx.strokeStyle = '#ff0000';
            ctx.lineWidth = 2;
            ctx.strokeRect(rect.x, rect.y, rect.width, rect.height);
            if (data) {
                ctx.fillStyle = '#ffffff';
                ctx.font = '14px Arial';
                ctx.fillText("欢迎您：" + data.name, rect.x + 5, rect.y + 20);
            } else {
                ctx.fillStyle = '#ff0000';
                ctx.font = '14px Arial';
                ctx.fillText("查无此人！", rect.x + 5, rect.y + 20);
            }
        });

        // 延迟1秒后再次清除画布
        setTimeout(function() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
        }, 1000);
    }
    function fThrottled() {
        if (isAllowedToCallF) { // 如果当前允许调用f()
            f(); // 调用f函数
            isAllowedToCallF = false; // 设置标记为不允许，避免在30秒内再次调用

            setTimeout(() => {
                isAllowedToCallF = true; // 30秒后重置标记，允许再次调用f()
            }, 5000); // 设置5秒的延迟
        }
    }
    function chooseFileChangeComp() {
        let video = document.getElementById("video2");
        let canvas = document.getElementById("canvas2");
        let ctx = canvas.getContext('2d');
        ctx.drawImage(video, 0, 0, 400, 400);
        var base64File = canvas.toDataURL();
        var formData = new FormData();
        formData.append("groupId", "101")
        formData.append("file", base64File);

        $.ajax({
            type: "post",
            url: "/faceSearch",
            data: formData,
            contentType: false,
            processData: false,
            async: true,
            success: function (text) {
                if (text.code == 0) {
                    var data = text.data;
                    redrawRectangles(data);
                    fThrottled();
                } else {
                    redrawRectangles();  // 如果没有数据，传递null
                }
            },
            error: function (error) {
                redrawRectangles();  // 错误情况下传递null
            }
        });
    }


    function startTracking() {
        let video = document.getElementById("video2");
        tracker = new tracking.ObjectTracker('face');
        tracker.setInitialScale(4);
        tracker.setStepSize(2);
        tracker.setEdgesDensity(0.1);

        tracker.on('track', function (event) {
            let now = Date.now();
            if (now - lastProcessTime > 500) { // 检查上次处理的时间
                lastTrackedRectangles = event.data;
                chooseFileChangeComp();
                lastProcessTime = now; // 更新处理时间
            }
        });

        trackingTask = tracking.track('#video2', tracker, { camera: true });

        let constraints = {
            video: { width: 400, height: 400 },
            audio: false
        };

        navigator.mediaDevices.getUserMedia(constraints).then(function (stream) {
            window.stream = stream; // 保存流以便后续停止
            video.srcObject = stream;
            video.onloadedmetadata = function () {
                video.play();
            };
        }).catch(function (error) {
            console.log("Error with accessing the camera: ", error);
        });
    }

    function stopTracking() {
        if (trackingTask) {
            trackingTask.stop(); // 停止跟踪
        }
        if (window.stream) {
            window.stream.getTracks().forEach(track => track.stop()); // 停止视频流
        }
        let video = document.getElementById("video2");
        video.srcObject = null;
    }

    $('#startButton').click(function() {
        startTracking();
    });

    $('#stopButton').click(function() {
        stopTracking();
    });

    // Optional: Disable stop button initially
    $('#stopButton').prop('disabled', true);

    // Optional: Enable stop button when tracking starts
    $('#startButton').click(function() {
        $('#stopButton').prop('disabled', false);
        $('#startButton').prop('disabled', true);
    });

    // Optional: Enable start button when tracking stops
    $('#stopButton').click(function() {
        $('#startButton').prop('disabled', false);
        $('#stopButton').prop('disabled', true);
    });
    // layui.use('element', function(){
    //     var element = layui.element;
    // });


    // 定义 formatDateTime 函数，用于格式化日期时间字符串
    function formatDateTime(dateTimeStr) {
        return dateTimeStr.replace('T', ' ').slice(0, 19);
    }

    // 使用Ajax调用服务器端获取数据，并更新UI
    function f() {
        $.ajax({
            type: "get",
            url: "<c:url value='/userInfo'/>", // 使用JSP标签库动态生成URL
            success: function (data) {
                console.log("data",data);
                // 假设data对象包含两个数组：arrivedList和absentList
                const { arrivedList, absentList } = data;
                console.log("arr",arrivedList);
                console.log("abs",absentList);
                // 更新已到人员表格
                updateArrivedList(arrivedList);

                // 更新未到人员列表
                updateAbsentList(absentList);
            },
            dataType: "json",
            error: function (error) {
                alert(JSON.stringify(error));
            }
        });
    }

    // 更新已到人员表格
    function updateArrivedList(arrivedList) {
        $("#arrivedTable tbody").empty(); // 清空现有内容
        arrivedList.forEach(item => {
            console.log("name", item.memberName);
            console.log("time", item.signInTime);
            // 使用字符串拼接的方式创建行
            let rowHtml = '<tr><td>' + item.memberName + '</td><td>' + item.signInTime + '</td></tr>';
            // 直接添加到表格的tbody中
            let $row = $(rowHtml).hide();
            $("#arrivedTable tbody").append($row );
            $row.fadeIn(1000);
            // 如果你想要使用淡入效果显示，可以给新增的行添加一个类名，并在CSS中定义该类的动画效果
            // 或者使用jQuery的fadeIn效果，但这需要先隐藏新增的行，再进行fadeIn，可能需要调整逻辑
        });

    }

    // 更新未到人员列表
    function updateAbsentList(absentList) {
        $("#absentTable tbody").empty(); // 清空现有内容
        absentList.forEach(memberName => {
            let rowHTML = '<tr><td>' + memberName + '</td></tr>';
            let $row = $(rowHTML).hide();
            $("#absentTable tbody").append($row);
            $row.fadeIn(1000); // 使用淡入效果显示
        })
    }

    // 页面加载完成时调用f函数
    $(document).ready(function() {
        f();
    });
</script>
</body>
</html>
