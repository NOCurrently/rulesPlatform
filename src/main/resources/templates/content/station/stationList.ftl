<html>
<head>
    <meta charset="UTF-8">
    <title>站点数据</title>
    <link rel="stylesheet" type="text/css" href="${base}/static/amazeui/css/amazeui.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/user/user-list.css">
    <link type="text/css" rel="stylesheet" href="${base}/static/css/page.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css?v=111111">
</head>
<body>
<input type="hidden" id="path" value="${base!}"/>
<input type="hidden" id="stationId" value="${stationId!}"/>
<div class="am-form-inline" id="search-box">
    <form id="r_searchForm" method="post">
        <span>名称：</span>
        <div class="am-form-group">
            <input type="text" name="title" class="search-input am-form-field"/>
        </div>
        <button type="button" class="am-btn am-btn-primary" id="search-button">搜索</button>
        <button type="button" class="am-btn  am-btn-primary" id="clear-btn">清空</button>
        <button type="button" class="am-btn  am-btn-primary" id='insert-button'>新增</button>

        
    </form>
</div>

<div id="data-table">
</div>

<div id="listPaging">
</div>

<div class="modal fade" id="updateMenu" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
</div><!-- /.modal -->

<!-- 删除 -->
<div class="modal fade" id="delFmModel">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <p>您确认要删除吗？</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="dataId"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="delectData" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 关闭/启用 -->
<div class="modal fade" id="changeStatus">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <p id="message"></p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="dataId"/>
                <input type="hidden" id="status"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="changeStatuSuer" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript" src="${base}/static/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script src="${base}/static/bounced/js/jquery.form.js"></script>
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="${base}/static/js/date/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript" src="${base}/static/js/content/station/stationinfo.js"></script>
</body>
</html>