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
<input type="hidden" id="templateCode" value="${templateCode!}"/>
<input type="hidden" id="tempId" />

<!--页面处理结果-->
<div id="active_result_banner" class="alert alert-danger" style="display:none"></div>


<div class="am-form-inline" id="search-box">
    <form id="r_searchForm" method="post">
            <span>ID：</span>
            <div class="am-form-group">
                <input type="text" name="bannerId" class="search-input am-form-field" id="bannerId"/>
            </div>
            <span>名称：</span>
            <div class="am-form-group">
                <input type="text" name="title" class="search-input am-form-field" id="info_title"/>
            </div>
            <#--<span>版本号：</span>
            <div class="am-form-group">
                <select class="search-input data-am-selected" id="versionSelect" name="versionSelect">
                </select>
            </div>-->
            <span>状态：</span>
            <div class="am-form-group">
                <select class="search-input data-am-selected" name="onlineFlag" id="statusSelect">
                    <option value="">全部</option>
                    <option value="1">开启</option>
                    <option value="0">关闭</option>
                </select>
            </div>
            <#--<span>上线时间：</span>
            <div class="am-form-group">
                <input id="beginTime" type="text" class="search-input am-form-field" name="beginTime"
                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,maxDate:'#F{$dp.$D(\'endTime\')}'});"/>
                -
                <input id="endTime" type="text" class="search-input am-form-field" name="endTime"
                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,minDate:'#F{$dp.$D(\'beginTime\')}'});"/>
            </div>-->

            <button type="button" class="am-btn am-btn-primary" id="search-button_banner">搜索</button>
            <button type="button" class="am-btn am-btn-primary" id="clear-btn_banner">清空</button>
            <button type="button" class="am-btn am-btn-primary" id="insertBanner">新增</button>


    </form>
</div>
<!-- 关闭/启用 -->
<div class="modal fade" id="changeBannerStatusModel">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <p id="bannerStatusMessage"></p>
            </div>
            <div class="modal-footer">
                <input type="hidden" id="bannerId"/>
                <input type="hidden" id="bannerStatusFlag"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="changeBannerStatus" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- 删除 -->
<div class="modal fade" id="delBannerModel">
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
                <input type="hidden" id="bannerId"/>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="deleteBanner" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!--复制数据弹出弹框-->
<div class="modal fade" id="copyFmModel">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>

            <form id="copyForm" class="form-horizontal" role="form" method="post" action="${base}/appInfo/copyInfoFlag">
            <#--<input type="hidden" name="id" value="${id!}">-->
                <div class="modal-body">
                    <div class="form-group">
                        <label for="versionCode" class="col-sm-3 control-label">版本编码</label>
                        <div class="col-sm-9">
                            <select id="versionCodeOfCopy" class="form-control" name="versionCode"><!--am-form-field-->
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <input type="hidden" id="infoId"/>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" id="copylimsuer" onclick="submitCommit()" class="btn btn-success"
                            data-dismiss="modal">确定
                    </button>
                </div>

            </form>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" id="viewcfmModel" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
            </div>
            <img id="imgurlId" src="" height="400" width="590"/>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div id="data-table">
</div>

<div id="listPaging">
</div>

<div class="modal fade" id="modifyRoleModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
</div><!-- /.modal -->

<!-- 用户角色管理 -->
<div class="modal fade" id="roleAuthModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
</div><!-- /.modal -->




<!-- 新增/编辑 设置的div -->
<div class="modal fade" id="editContentInitDiv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >

</div>


<!-- 自定义参数设置 -->
<div class="modal fade" id="param_data" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >

</div>

<!-- 文件上传参数设置 -->
<div class="modal fade" id="upload_data" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

</div>

<!-- 时间参数设置 -->
<div class="modal fade" id="date_data" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >

</div>
<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script src="${base}/static/bounced/js/jquery.form.js"></script>
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="${base}/static/js/date/WdatePicker.js"></script>
<script type="text/javascript" src="${base}/static/js/common.js"></script>
<script type="text/javascript" src="${base}/static/js/content/appinfo.js"></script>
</body>
</html>