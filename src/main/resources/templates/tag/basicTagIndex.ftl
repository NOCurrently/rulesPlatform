<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${base}/static/amazeui/css/amazeui.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/dictType-list.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/user/user-list.css">
    <link type="text/css" rel="stylesheet" href="${base}/static/css/page.css">

    <link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css?v=111111">
</head>
<body>
<input type="hidden" id="path" value="${base}"/>
<div class="am-form-inline" id="search-box">
    <span>标签名称：</span>
    <div class="am-form-group">
        <input type="text" class="search-input am-form-field" id="customTagName"/>
    </div>
    <button class="am-btn am-btn-primary" id="search-button">搜索</button>
    <button class="am-btn  am-btn-primary" id="clear-btn">清空</button>
    <button class="am-btn  am-btn-primary" id="insert-button_tag">新增</button>
</div>

<div id="basicTagData-table">
</div>
<div id="basicTagData-paging">
</div>

<!-- 新增标签 -->
<div class="modal fade" id="editTagInitDiv" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >

</div>

<!-- 删除 -->
<div class="modal fade" id="delTagDiv">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">×</span></button>
                <h4 class="modal-title">提示信息</h4>
            </div>
            <div class="modal-body">
                <input type="hidden" id="tagPoolId">
                <p>您确认要删除吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="deleteTagButton" class="btn btn-success" data-dismiss="modal">确定</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script src="${base}/static/bounced/js/jquery.form.js"></script>
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script>
    /**
     * lizp
     */
    $(function () {
        var path = $("#path").val();
        var keyword = $("#customTagName").val();

        if ('' == keyword) {
            keyword = "";
        }

        basicTagListPaging = new PageView({
            pageContainer: $("#basicTagData-paging"),
            pageListContainer: $("#basicTagData-table"),
            pageViewName: 'basicTagListPaging',
            url: path + "/backendTag/basicTagList",
            curPageName: 'currentPage',
            pageSize: 15,
            urlRequestData: {"tagName": keyword}
        });


        /**
         * 搜索框点击事件
         */
        $("#search-button").click(function () {
            var tagName = $("#customTagName").val();

            //pageSize标签存在于page.js中
            var pageSize = $("#selectPageForm").val();
            if (!pageSize) {
                pageSize = 15;
            }

            basicTagListPaging = new PageView({
                pageContainer: $("#basicTagData-paging"),
                pageListContainer: $("#basicTagData-table"),
                pageViewName: 'basicTagListPaging',
                url: path + "/backendTag/basicTagList",
                curPageName: 'currentPage',
                pageSize: pageSize,
                urlRequestData: {"tagName": tagName}
            });
        });

        /**
         * 清空输入框
         */
        $("#clear-btn").click(function () {
            $("#customTagName").val("");
            $("#customTagName").focus();
        });

        $("#insert-button_tag").bind("click", function tagAdd(){

            $('#editTagInitDiv').load(path + "/backendTag/editCustomTagInit");
            $('#editTagInitDiv').modal({});

        });

        var table = $("#basicTagData-table");
        /**
         * 编辑标签
         */
        table.on('click', ".edit_tag", function () {
            var tagPoolId = $(this).attr('tagPoolId');
            $('#editTagInitDiv').load(path + "/backendTag/editCustomTagInit?id="+tagPoolId);
            $('#editTagInitDiv').modal({});
        });

        /**
         * 删除标签
         */
        table.on('click', ".delete_tag", function () {
            var tagPoolId = $(this).attr('tagPoolId');
            $('#tagPoolId').val(tagPoolId);
            $('#delTagDiv').modal();
        });

        /**
         * 确认删除后
         */
        $("#deleteTagButton").click(function () {
            var tagPoolId = $("#tagPoolId").val();
            $.ajax({
                type: "post",
                url: path + "/backendTag/delTagPool?id=" + tagPoolId,
                format: "json",
                success: function (data) {
                    if(data.code=="200"){
                        alert("操作成功！");
                        $("#search-button").click();
                    }else{
                        alert(data.displayMessage);
                    }
                }
            });
        });

    });

</script>
</body>
</html>