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
    </style>
</head>
<body>

<div class="container">
    <div>
        <!-- 开始和结束按钮 -->
        <button id="startButton" onclick="startTracking()">开始识别</button>
        <button id="stopButton" onclick="stopTracking()">结束识别</button>
    </div>
    <div id="regcoDiv">
        <div id="canvasContainer">
            <video id="video2" width="400px" height="400px" autoplay="autoplay" style="margin-top: 20px;"></video>
            <canvas id="canvas2" width="400px" height="400px"></canvas>
        </div>
    </div>


</div>

<script>
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
</script>
</body>
</html>
