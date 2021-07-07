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
<input type="hidden" id="menuId" value="${menuId!}"/>

<!--页面处理结果-->
<div id="active_result_richText" class="alert alert-danger" style="display:none"></div>


<div class="am-form-inline" id="search-box">
    <form id="searchForm_richText" method="post">
        <span>一级渠道：</span>
        <div class="am-form-group">
            <select class="search-input data-am-selected" name="firstChannel" id="firstChannel">
            </select>
        </div>
        <span>位置：</span>
        <div class="am-form-group">
            <select class="search-input data-am-selected" name="location" id="location">
            </select>
        </div>

        <button type="button" class="am-btn am-btn-primary" id="search-btn_richText">搜索</button>
        <button type="button" class="am-btn am-btn-primary" id="clear-btn_richText">清空</button>
        <button type="button" class="am-btn am-btn-primary" id="insert-btn_richText">新增</button>

    </form>
</div>

<!-- 关闭/启用 -->
<div class="modal fade" id="changeRichTextStatusModel">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <p id="richTextStatusMessage"></p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="changeRichTextId"/>
                <input type="hidden" id="richTextStatusFlag"/>
                <input type="hidden" id="uniqueCodeStatus"/>
                <input type="hidden" id="menuIdStatus"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="richTextStatusChange" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 删除 -->
<div class="modal fade" id="deleteRichTextModel">
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
                <input type="hidden" id="deleteRichTextId"/>
                <input type="hidden" id="deleteUniqueCode"/>
                <input type="hidden" id="deleteMenuId"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="richTextDelete" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



<!-- 列表数据-->
<div id="data-table">
</div>

<!-- 分页数据 -->
<div id="page-table">
</div>


<!-- 新增/编辑 设置的div -->
<div class="modal fade" id="richTextEditModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >

</div>

<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script src="${base}/static/bounced/js/jquery.form.js"></script>
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="${base}/static/js/date/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript" src="${base}/static/js/richtext/richTextIndex.js"></script>
</body>
</html>