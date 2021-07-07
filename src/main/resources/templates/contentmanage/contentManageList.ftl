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
<div id="active_result_content" class="alert alert-danger" style="display:none"></div>


<div class="am-form-inline" id="search-box">
    <form id="r_searchForm" method="post">

        <span>类别：</span>
        <div class="am-form-group">
            <select class="search-input data-am-selected" name="contentType" id="contentType">
            </select>
        </div>
        <span>位置：</span>
        <div class="am-form-group">
            <select class="search-input data-am-selected" name="location" id="location">
            </select>
        </div>

        <button type="button" class="am-btn am-btn-primary" id="searchContent">搜索</button>
        <button type="button" class="am-btn am-btn-primary" id="clear-btn_content">清空</button>
        <button type="button" class="am-btn am-btn-primary" id="insertContent">新增</button>

    </form>
</div>
<!-- 关闭/启用 -->
<div class="modal fade" id="changeContentStatusModel">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <p id="contentStatusMessage"></p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="changeContentId"/>
                <input type="hidden" id="contentStatusFlag"/>
                <input type="hidden" id="uniqueCodeStatus"/>
                <input type="hidden" id="menuIdStatus"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="changeContentStatus" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 删除 -->
<div class="modal fade" id="delContentModel">
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
                <input type="hidden" id="deleteContentId"/>
                <input type="hidden" id="deleteUniqueCode"/>
                <input type="hidden" id="deleteMenuId"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="deleteContent" class="btn btn-success" data-dismiss="modal">确定</button>
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
<div class="modal fade" id="contentManageEditModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >

</div>


<!-- 文案编辑 -->
<div class="modal fade" id="param_data" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >

</div>

<!-- 图片上传 -->
<div class="modal fade" id="upload_data" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

</div>

<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script src="${base}/static/bounced/js/jquery.form.js"></script>
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="${base}/static/js/date/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript" src="${base}/static/js/contentmanage/contentManageList.js"></script>
</body>
</html>