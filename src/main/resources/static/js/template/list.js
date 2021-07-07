/**
 * Created by Administrator on 2018/7/29.
 */
$(function () {
    var path = $("#path").val();

    /**
     * 页面上的分页
     */
    templateListPaging = new PageView({
        pageContainer: $("#page-table"),
        pageListContainer: $("#data-table"),
        pageViewName: 'templateListPaging',
        url: path + "/backendTemplate/page",
        curPageName: 'currentPage',
        pageSize: 15,
        urlRequestData: {
        }
    });

    /**
     * 列表中的查看
     */
    var table = $("#data-table");
    table.on('click', ".edit", function () {
        var templateCode = $(this).attr('templateCode');
        $('#detail-table_template').load(path + "/backendTemplate/view?templateCode=" + templateCode);
        $('#detail-table_template').modal();
    });

    /**
     * 编辑模版内容
     */
    table.on('click', ".edit_template", function () {
        var templateCode = $(this).attr('templateCode');
        $('#modifyTemplateModel').load(path + "/backendTemplate/editTemplate?templateCode="+templateCode);
        $('#modifyTemplateModel').modal({});
    });

    /**
     * 删除选中模版
     */
    table.on('click', ".delete_template", function () {
        var id = $(this).attr('id');
        $('#id').val(id);
        $('#deleteTemplateModel').modal();
    });

    /**
     * 确认删除后
     */
    $("#deleteTemplate").click(function () {
        var templateId = $("#id").val();
        $.ajax({
            type: "post",
            url: path + "/backendTemplate/deleteTemplate?id=" + templateId,
            format: "json",
            success: function (data) {
                if(data.code=="200"){
                    //window.location.href = path + "/backendTemplate/list";

                    //pageSize标签存在于page.js中
                    var pageSize = $("#selectPageForm").val();
                    if (!pageSize) {
                        pageSize = 15;
                    }
                    templateListPaging = new PageView({
                        pageContainer: $("#page-table"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'templateListPaging',
                        url: path + "/backendTemplate/page",
                        curPageName: 'currentPage',
                        pageSize: pageSize,
                        urlRequestData: {
                        }
                    });
                }else{
                    alert(data.message);
                }
            }
        });
    });

    /**
     * 开关页面
     */
    table.on('click', ".changeStatus_template", function () {
        var id = $(this).attr('templateId');
        var status = $(this).attr('templateStatusFlag');
        $('#templateId').val(id);
        if (status == 0) {
            $('#templateStatusFlag').val(1);
            $('#templateStatusMessage').text("您确认要开启吗？");
        } else {
            $('#templateStatusFlag').val(0);
            $('#templateStatusMessage').text("您确认要关闭吗？");
        }
        $('#changeTemplateStatusModel').modal();
    });

    /**
     * 确认开关
     */
    $("#changeTemplateStatus").click(function () {
        var id = $("#templateId").val();
        var status = $("#templateStatusFlag").val();
        $.ajax({
            type: "post",
            url: path + "/backendTemplate/changeTemplateStatus?id=" + id+"&status="+status,
            format: "json",
            success: function (data) {
                if (!data.success) {
                    alert(data.errorMessage);
                } else {
                    var curPage = $("#pageInput").val();
                    if (!curPage) {
                        curPage = 1;
                    }
                    //pageSize标签存在于page.js中
                    var pageSize = $("#selectPageForm").val();
                    if (!pageSize) {
                        pageSize = 15;
                    }
                    templateListPaging = new PageView({
                        pageContainer: $("#page-table"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'templateListPaging',
                        url: path + "/backendTemplate/page",
                        curPageName: 'currentPage',
                        curPage:curPage,
                        pageSize: pageSize,
                        urlRequestData: {
                        }
                    });
                }
            }
        });
    });

    /**
     * 搜索框点击事件
     */
    $("#search-button_template").click(function () {
        $('#active_result_template').css('display', 'none');
        var templateCode = $("#templateCode").val();
        if ($("#templateCode").val().length > 100) {
            $('#active_result_template').html("表单code长度不能超过100").show();
            return;
        }

        //pageSize标签存在于page.js中
        var pageSize = $("#selectPageForm").val();
        if (!pageSize) {
            pageSize = 15;
        }

        templateListPaging = new PageView({
            pageContainer: $("#page-table"),
            pageListContainer: $("#data-table"),
            pageViewName: 'templateListPaging',
            url: path + "/backendTemplate/page",
            curPageName: 'currentPage',
            pageSize: pageSize,
            urlRequestData: {
                "templateCode": templateCode,
            }
        });
    });

    /**
     * 清空输入框
     */
    $("#clear-button_template").click(function () {
        $("#templateCode").val("");
        $("#templateCode").focus();
    });

    /**
     * 新增内容模版弹出框
     */
    $("#insert-button_template").click(function () {
        $("#formCode").val("");
        $("#title").val("");
        $("#remarks").val("");
        $("#priority").val("");
        $("#templateUrl").val("");
        $("#code").val("");
        $('#contentTemplate_result').css("display","none");
        $('#createContentTemplateModel').modal({});

    });

    /**
     * 提交新增内容模版数据
     */
    $("#contentTemplateSaveBtn").bind("click",function(){
        if(!$("#formCode").val()) {
            $('#contentTemplate_result').html("表单code不能为空！").show();
            return;
        }
        if ($("#formCode").val().length > 100) {
            $('#contentTemplate_result').html("表单code长度不能超过100").show();
            return;
        }

        if(!$("#title").val()) {
            $('#contentTemplate_result').html("标题不能为空！").show();
            return;
        }
        if ($("#title").val().length > 100) {
            $('#contentTemplate_result').html("标题长度不能超过100").show();
            return;
        }
        if(!$("#priority").val()) {
            $("#priority").val(1)
        }
        if(!(/(^[1-9]\d*$)/.test($("#priority").val()))) {
            $('#contentTemplate_result').html("优先级为正整数！").show();
            return;
        }
        if(!$("#templateUrl").val()) {
            $('#contentTemplate_result').html("模版路径不能为空！").show();
            return;
        }
        if ($("#templateUrl").val().length > 200) {
            $('#contentTemplate_result').html("模版路径长度不能超过200").show();
            return;
        }
        if ($("#remarks").val().length > 200) {
            $('#contentTemplate_result').html("备注长度不能超过200").show();
            return;
        }

        // 2.按钮置灰
        var thatButton = $(this);
        thatButton.attr('disabled', 'disabled');

        $('#contentTemplate_form').ajaxForm({
            success: contentTemplateComplete,
            dataType: 'json'
        }).submit();
        return true;
    });

    /**
     * 提交成功后
     * @param data
     */
    function contentTemplateComplete(data){
        if (data.code=='200'){
            //关闭当前窗口
            $("#createContentTemplateModel").modal('hide');

            //pageSize标签存在于page.js中
            var pageSize = $("#selectPageForm").val();
            if (!pageSize) {
                pageSize = 15;
            }

            templateListPaging = new PageView({
                pageContainer: $("#page-table"),
                pageListContainer: $("#data-table"),
                pageViewName: 'templateListPaging',
                url: path + "/backendTemplate/page",
                curPageName: 'currentPage',
                pageSize: pageSize,
                urlRequestData: {
                }
            });
        } else {
            $('#contentTemplate_result').html(data.errorMessage).show();

        }
        $("#contentTemplateSaveBtn").removeAttr('disabled');

    }


});