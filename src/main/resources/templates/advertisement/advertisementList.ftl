<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${base}/static/amazeui/css/amazeui.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/user/user-list.css">
    <link type="text/css" rel="stylesheet" href="${base}/static/css/page.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css?v=111111">
</head>
<body>
<input type="hidden" id="path" value="${base}"/>
<div id="active_result" class="alert alert-danger" style="display:none"></div>
<div class="am-form-inline" id="search-box">
    <div class="am-form-inline">
        <span>区域:</span>
        <div class="am-form-group">
            <select class="search-input data-am-selected" id="provinceSearchSelect" name="stateId">
                <option value="">请选择省份</option>
            </select>
            <select class="search-input data-am-selected" id="citySearchSelect" name="cityId">
                <option value="">请选择城市</option>
            </select>
            <select class="search-input data-am-selected" id="areaSearchSelect" name="clusterId">
                <option value="">请选择区县</option>
            </select>
        </div>
        <span>&nbsp;&nbsp;酒店状态:</span>
        <div class="am-form-group">
            <select class="search-input data-am-selected" id="hotelStatusSelect" name="status">
                <option value=""> 选择酒店状态</option>
            </select>
        </div>
        <span>&nbsp;&nbsp;酒店类型:</span>
        <div class="am-form-group">
            <select class="search-input data-am-selected" id="hotelTypeSelect" name="type">
                <option value=""> 选择酒店类型</option>
            </select>
        </div>
        <span>&nbsp;&nbsp;广告类型:</span>
        <div class="am-form-group">
            <select class="search-input data-am-selected" id="adTypeSelect" name="adType">
                <option value=""> 选择广告类型</option>
            </select>
        </div>
        <span>&nbsp;&nbsp;使用状态:</span>
        <div class="am-form-group">
            <select class="search-input data-am-selected" id="adStatusSelect" name="adStatus">
                <option value=""> 选择使用状态</option>
            </select>
        </div>
    </div>
    </br>
    <div class="am-form-inline">
        <span>酒店名称:</span>
        <div class="am-form-group">
            <input type="text" class="search-input am-form-field" id="hotelName" name="hotelName"/>
        </div>
        <span>&nbsp;&nbsp;酒店ID:</span>
        <div class="am-form-group">
            <input type="text" class="search-input am-form-field" id="hotelId" name="hotelId"/>
        </div>
        <span>广告位置:</span>
        <div class="am-form-group">
            <select class="search-input data-am-selected" id="adLocationSelect" name="adLocation">
                <option value=""> 选择广告位置</option>
            </select>
        </div>
        <button class="am-btn am-btn-primary" id="search-button">搜索</button>
        <button class="am-btn  am-btn-primary" id="clear-btn">清空</button>
        <button class="am-btn am-btn-primary" id="upload-button">导出数据</button>
    </div>
</div>
<div id="data-table">
</div>

<div id="adListPaging">
</div>

<div class="modal fade" id="detailModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

</div>


<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script type="text/javascript" src="${base}/static/js/advertisement/advertisement-list.js"></script>
<script src="${base}/static/bounced/js/jquery.form.js"></script>
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</body>
</html>