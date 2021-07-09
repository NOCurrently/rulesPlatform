<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/amazeui/js/amazeui.min.js"></script>
    <script type="text/javascript" src="/js/login.js?v=101"></script>
    <link rel="stylesheet" href="/amazeui/css/amazeui.css">
    <link rel="stylesheet" href="/css/login.css">

    <!-- Set render engine for 360 browser -->
    <meta name="renderer" content="webkit">

    <!-- No Baidu Siteapp-->
    <meta http-equiv="Cache-Control" content="no-siteapp"/>

</head>
<body class="" >
<input type="hidden" id="path" value="${base}"/>

<div class="main">
    <!--<header class="am-topbar">
        <h1 class="am-topbar-brand">
            <a href="#">OYO-CMS后台管理系统</a>
        </h1>
    </header>-->

    <form class="form-container" name="loginform" id="loginform" onkeydown="keyLogin();">
        <div class="form-title"><h2>后台管理系统</h2></div>
        <div class="form-input">
        	<span>用户名:</span>
        	<input class="" name="username" id="username" type="text" autocomplete="off">
        </div>

        <div class="form-input form-border">
        	<span>密&nbsp;&nbsp;码:</span>
        	<input class="" name="password" id="password" type="password" autocomplete="off">
        </div>
        

        <div class="submit-container">
            <input class="submit-button" name="denglu" type="button" id = "loginBtn" value="登录"/>
            <input class="reset-button" name="denglu" type="reset" value="重置"/>
            <div class="error"></div>
        </div>
    </form>

</div>

</body>

</html>