<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>oyo-cms</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="format-detection" content="telephone=no">
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css" />
	<link type="text/css" rel="stylesheet" href="${base}/static/treeview/css/bootstrap-treeview.css" />
    <style type="text/css">
        .node-stationTree {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
    </style>
</head>
<body>
<input type="hidden" id="path" value="${base}"/>
<div class="content_wrap">
    <div id="stationTree" style="width: 19%;float:left;"></div>
    <div id="datas" style="width: 80%;float:left;"></div>
</div>
<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${base}/static/treeview/js/bootstrap-treeview.js"></script>
<script type="text/javascript" src="${base}/static/js/content/infoIndex.js"></script>
</body>
</html>
