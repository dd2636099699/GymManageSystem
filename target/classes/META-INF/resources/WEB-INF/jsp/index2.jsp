<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>健身房管理系统 会员页面</title>
	<meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/HTmoban/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/HTmoban/css/font.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/HTmoban/css/xadmin.css">
    <script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/HTmoban/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/HTmoban/js/xadmin.js"></script>
    <link rel="stylesheet" href="path/to/your/iconfont.css">
</head>
<body>
    <!-- 顶部开始 -->
    <div class="container">
        <div class="logo"><a>健身房管理系统 会员页面</a></div>
        <div class="left_open">
            <i title="展开左侧栏" class="iconfont">&#xe699;</i>
        </div>
        <ul class="layui-nav left fast-add" lay-filter="">

        </ul>
        <ul class="layui-nav right" lay-filte r="">
          <li class="layui-nav-item">
            <a href="javascript:;">欢迎会员${user.memberName}!</a>
            <dl class="layui-nav-child"> <!-- 二级菜单 -->
              <dd><a onclick="x_admin_show('修改密码','${pageContext.request.contextPath}/updPassword','800','600')">修改密码</a></dd>
              <dd><a href="${pageContext.request.contextPath}/logout">退出</a></dd>
            </dl>
          </li>
        </ul>

    </div>
    <!-- 顶部结束 -->
    <!-- 中部开始 -->
     <!-- 左侧菜单开始 -->
    <div class="left-nav">
        <div id="side-nav">
            <ul id="nav">
                <!-- 个人信息页 -->
                <li>
                    <a _href="${pageContext.request.contextPath}/menber/personalInfojin1">
                        <i class="iconfont">&#xe6a2;</i>
                        <cite>个人信息</cite>
                    </a>
                </li>
                <!-- 充值续卡页 -->
                <li>
                    <a _href="${pageContext.request.contextPath}/cz/chongzhiandxukajin">
                        <i class="iconfont">&#xe6a2;</i>
                        <cite>充值续卡</cite>
                    </a>
                </li>
                <li>

                    <a _href="${pageContext.request.contextPath}/cz/personaljin">
                        <i class="iconfont">&#xe6a2;</i>
                        <cite>充值记录</cite>

                    </a>
                </li>
                <li>

                    <a _href="${pageContext.request.contextPath}/cz/personalxuka">
                        <i class="iconfont">&#xe6a2;</i>
                        <cite>续卡记录</cite>

                    </a>
                </li>

                <!-- 购买课程页面 -->
                <li>
                    <a _href="${pageContext.request.contextPath}/courseSchedule/personalpurchaseCoursejin">
                        <i class="iconfont">&#xe6a2;</i>
                        <cite>购买课程</cite>
                    </a>
                </li>
                <!-- 查看购买课程信息页面 -->
                <li>
                    <a _href="${pageContext.request.contextPath}/CourseSale/MyCoursejin">
                        <i class="iconfont">&#xe6e8;</i>
                        <cite>我的课程</cite>
                    </a>
                </li>
                <!-- 失物招领页面 -->
                <li>
                    <a _href="${pageContext.request.contextPath}/loos/jin09">
                        <i class="iconfont">&#xe6fc;</i>
                        <cite>失物招领</cite>
                    </a>
                </li>

                <!-- 设备预约 -->
                <li>
                    <a _href="${pageContext.request.contextPath}/qc/reservejin2">
                        <i class="iconfont">&#xe6b7;</i>
                        <cite>设备预约</cite>
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <!-- <div class="x-slide_left"></div> -->
    <!-- 左侧菜单结束 -->
    <!-- 右侧主体开始 -->
    <div class="page-content">
        <div class="layui-tab tab" lay-filter="xbs_tab" lay-allowclose="false">
            <ul class="layui-tab-title">
                <li class="home"><i class="layui-icon">&#xe68e;</i>我的桌面</li>
            </ul>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <iframe src='${pageContext.request.contextPath}/menber/personalInfojin1' frameborder="0" scrolling="yes" class="x-iframe"></iframe>
                </div>
            </div>
        </div>
    </div>

    <div class="page-content-bg"></div>
    <!-- 右侧主体结束 -->
    <!-- 中部结束 -->
    <!-- 底部开始 -->
    <div class="footer">
        <div align="center" class="copyright">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;
            <a target="_blank" href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=xxxxxxxxxxxxxxxx" style="display:inline-block;text-decoration:none;color: #fff;"><img src="/static/HTmoban/images/备案图标.png">京公网安备 xxxxxxxxxxxxxxxx号</a>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <a style=" text-decoration: none; color: #fff;" href="http://www.beian.miit.gov.cn/" target="_blank">互联网ICP备案 京ICP备xxxxxxxxx号-1</a>
        </div>
    </div>
    <!-- 底部结束 -->

</body>
</html>
