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


<!--页面隐藏数据部分-->
<input type="hidden" id="path" value="${base}"/>
<input type="hidden" id="id"/>


<!--页面表单处理结果-->
<div id="active_result_rule" class="alert alert-danger" style="display:none"></div>

<!--查询条件-->
<div class="am-form-inline" id="search-box">
    <span>编码名称:</span>
    <div class="am-form-group">
        <input type="text" class="search-input am-form-field" id="name" name="name"/>
    </div>
    <span>编码类别名称:</span>
    <div class="am-form-group">
        <input type="text" class="search-input am-form-field" id="typeName" name="typeName"/>
    </div>

    <button class="am-btn  am-btn-primary" id="searchRule">搜索</button>
    <button class="am-btn  am-btn-primary" id="clear-button_rule">清空</button>
    <button class="am-btn  am-btn-primary" id="insertRule">新增</button>

</div>

<!-- 列表数据-->
<div id="data-table">
</div>

<!-- 分页数据 -->
<div id="page-table">
</div>



<!-- 新增/编辑 -->
<div class="modal fade" id="ruleEditModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
</div>


<!-- 删除选中模版 -->
<div class="modal fade" id="deleteTemplateModel">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">提示信息</h4>
            </div>
            <div class="modal-body">
                <p>您确认要删除吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-success" id = "deleteTemplate" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

<!-- 关闭/启用 -->
<div class="modal fade" id="changeRuleStatusModel">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <p id="ruleStatusMessage"></p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="changeRuleId"/>
                <input type="hidden" id="ruleStatusFlag"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="changeRuleStatus" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 引入的js文件-->
<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script src="${base}/static/js/date/WdatePicker.js"></script>
<script src="${base}/static/bounced/js/jquery.form.js"></script>
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${base}/static/js/ruleconfig/ruleList.js"></script>
</body>
</html>