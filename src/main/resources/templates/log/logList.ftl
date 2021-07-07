<html>
<head>
    <meta charset="UTF-8">
    <title>日志管理</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <link rel="stylesheet" type="text/css" href="${base}/static/amazeui/css/amazeui.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/user/user-list.css">
    <link type="text/css" rel="stylesheet" href="${base}/static/css/page.css" >
    <link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css?v=111111">
</head>
<body>
<input type="hidden" id="path" value="${base}"/>

<!--页面处理结果-->
<div id="active_result_log" class="alert alert-danger" style="display:none"></div>

<div class="am-form-inline" id="search-box">
    <span>操作者姓名：</span>
    <div class="am-form-group">
        <input type="text" class="search-input am-form-field" id = "username"/>
    </div>
    <span>操作对象URL：</span>
    <div class="am-form-group">
        <input type="text" class="search-input am-form-field" id = "url"/>
    </div>
    <button class="am-btn am-btn-primary" id="search-button_log">搜索</button>
    <button class="am-btn am-btn-primary" id="clear-btn_log">清空</button>
</div>

<div id = "data-table">
</div>

<!-- 信息删除确认 -->
<div class="modal fade" id="delcfmModel">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <p>您确认要删除吗？</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="confirm-model"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id = "imsuer" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" id="insertLogModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
</div><!-- /.modal -->

<div id="logListPaging">
</div>



<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script type="text/javascript" src="${base}/static/js/log/log_list.js"></script>
<script src="${base}/static/bounced/js/jquery.form.js"></script>
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>

</body>
</html>