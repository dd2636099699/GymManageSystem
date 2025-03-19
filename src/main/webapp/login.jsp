<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>健身房管理系统</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!-- 导入 layui 的样式文件和 JavaScript 文件 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/HTmoban/lib/layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/static/HTmoban/lib/layui/layui.js" charset="utf-8"></script>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/HTmoban/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/HTmoban/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/HTmoban/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/HTmoban/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/HTmoban/js/xadmin.js"></script>
    <style>
        /* 自定义提示消息样式 */
        .custom-success-msg {
            font-size: 20px;
            font-weight: bold;
            line-height: 30px;
            text-align: center;
            color: green;
        }
        /* 自定义单选框及其标题的字体大小 */
        .layui-form-radio div, .layui-form-radio {
            font-size: 12px; /* 减小字体大小 */
        }

        /* 自定义单选按钮的样式以减小其大小 */
        .layui-form-radio>i {
            width: 18px; /* 调整宽度 */
            height: 18px; /* 调整高度 */
            line-height: 18px; /* 调整行高以垂直居中 */
            border-radius: 50%; /* 确保是圆形 */
            font-size: 14px; /* 减小单选按钮中圆点的大小 */
        }

        /* 调整单选框颜色为天蓝色 */
        .layui-form-radio>i {
            color: #87CEEB; /* 天蓝色 */
        }
        /* 鼠标悬停时的样式 */
        .layui-form-radio:hover>i {
            border-color: #87CEEB; /* 天蓝色 */
        }
        /* 单选框选中时的样式 */
        .layui-form-radioed>i {
            color: #87CEEB; /* 天蓝色 */
            border-color: #87CEEB; /* 保持边框也是天蓝色 */
        }
    </style>

</head>
<body class="login-bg">


    <div class="login layui-anim layui-anim-up">
        <div  class="message">健身房管理系统</div>
        <div id="darkbannerwrap"></div>


        <form method="post" class="layui-form" action="${pageContext.request.contextPath}/dl/yz">
            <span style="color: red;">${msg}</span>
            <input name="username" placeholder="用户名" type="text" lay-verify="required" class="layui-input">
            <hr class="hr15">
            <input name="password" lay-verify="required" placeholder="密码" type="password" class="layui-input">
            <hr class="hr15">


            <!-- 使用flex布局使单选按钮水平排列，并尝试重置边距和填充 -->
            <div class="layui-input-block" style="display: flex; justify-content: center; align-items: center; gap: 20px; margin: 0; padding: 0;">
                <input type="radio" name="role" value="admin" title="管理员" checked>
                <input type="radio" name="role" value="member" title="会员">
                <input type="radio" name="role" value="coach" title="教练">
            </div>

            <hr class="hr15">

            <input value="登录" lay-submit lay-filter="login" style="width:100%; background-color: #87CEEB; border-color: #87CEEB; color: white;" type="submit">
            <hr class="hr20">
        </form>



    </div>
    <script>
        layui.use('layer', function(){
            var layer = layui.layer;
            // 判断是否有成功消息，并且成功消息不为空
            <c:if test="${not empty param.successMsg}">
            layer.msg("${param.successMsg}", {
                icon: 1,
                time: 2000, // 消息显示时间
                shade: 0.5, // 遮罩透明度
                offset: 't', // 消息弹出位置：顶部
                anim: 5, // 动画类型：渐隐
                area: ['80%', '60px'], // 弹出框大小
                style: {
                    fontSize: '20px', // 设置字体大小为20px
                    fontWeight: 'bold', // 设置字体加粗
                    lineHeight: '30px' // 设置行高为30px
                }
            });
            </c:if>
        });
        if (window.top !== window.self) {
            window.top.location = window.location
        }

    </script>
    <div class="footer">
        <div align="center">
            <a target="_blank" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=xxxxxxxxxxxxxxxx" style="display:inline-block;text-decoration:none;color: #fff;"><img src="/static/HTmoban/images/备案图标.png">京公网安备 xxxxxxxxxxxxxxxx号</a>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <a style=" text-decoration: none; color: #fff;" href="http://www.beian.miit.gov.cn/" target="_blank">互联网ICP备案 京ICP备xxxxxxxxx号-1</a>
        </div>
    </div>
</body>
</html>
