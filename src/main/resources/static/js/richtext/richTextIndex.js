/**
 * Created by Administrator on 2019/8/15.
 */
$(function () {
    var path = $("#path").val();
    var menuId = $("#menuId").val();

    // 页面上内容初始化
    dictValueLoadSelectSort("firstChannel", "target_channel", path, "", "选择渠道");
    dictValueLoadSelectSort("location", "richtext_location", path, "", "选择位置");

    /**
     * 页面上的分页
     */
    richTextListPaging = new PageView({
        pageContainer: $("#page-table"),
        pageListContainer: $("#data-table"),
        pageViewName: 'richTextListPaging',
        url: path + "/backendRichText/richTextList",
        curPageName: 'currentPage',
        pageSize: 15,
        urlRequestData: {
            "menuId": menuId,
        }
    });

    /**
     * 新增
     */
    $("#insert-btn_richText").bind("click", function richTextAdd() {

        var menuId = $("#menuId").val();

        $('#richTextEditModel').load(path + "/backendRichText/editRichTextInit?menuId=" + menuId);
        $('#richTextEditModel').modal({});

    });


    /**
     * 编辑
     */
    var table = $("#data-table");
    table.on('click', ".edit", function () {
        var menuId = $("#menuId").val();
        var richTextId = $(this).attr('richTextId');
        $('#richTextEditModel').load(path + "/backendRichText/editRichTextInit?richTextId=" + richTextId + "&menuId=" + menuId);
        $('#richTextEditModel').modal();
    });

    /**
     * 删除页面
     */
    $("#data-table").on('click', ".deleteRichText", function () {
        var id = $(this).attr('richTextId');
        var uniqueCode = $(this).attr('uniqueCode');
        var menuId = $("#menuId").val();
        $('#deleteRichTextId').val(id);
        $('#deleteUniqueCode').val(uniqueCode);
        $('#deleteMenuId').val(menuId);
        $('#deleteRichTextModel').modal();
    });

    /**
     * 确认删除
     */
    $("#richTextDelete").click(function () {
        var id = $("#deleteRichTextId").val();
        var uniqueCode = $("#deleteUniqueCode").val();
        var menuId = $("#deleteMenuId").val();
        $.ajax({
            type: "post",
            url: path + "/backendRichText/deleteRichText?id=" + id + "&uniqueCode=" + uniqueCode + "&menuId=" + menuId,
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

                    richTextListPaging = new PageView({
                        pageContainer: $("#page-table"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'richTextListPaging',
                        url: path + "/backendRichText/richTextList",
                        curPageName: 'currentPage',
                        curPage: curPage,
                        pageSize: pageSize,
                        urlRequestData: {
                            "menuId": menuId,
                        }
                    });

                }
            }
        });
    });

    /**
     * 开关页面
     */
    $("#data-table").on('click', ".changeRichTextStatus", function () {
        var id = $(this).attr('richTextId');
        var status = $(this).attr('richTextStatus');
        var uniqueCode = $(this).attr('uniqueCode');
        var menuId = $("#menuId").val();
        $('#changeRichTextId').val(id);
        $('#uniqueCodeStatus').val(uniqueCode);
        $('#menuIdStatus').val(menuId);
        if (status == 0) {
            $('#richTextStatusFlag').val(1);
            $('#richTextStatusMessage').text("您确认要开启吗？");
        } else {
            $('#richTextStatusFlag').val(0);
            $('#richTextStatusMessage').text("您确认要关闭吗？");
        }
        $('#changeRichTextStatusModel').modal();
    });

    /**
     * 确认开关
     */
    $("#richTextStatusChange").click(function () {
        var id = $("#changeRichTextId").val();
        var status = $("#richTextStatusFlag").val();
        var uniqueCode = $("#uniqueCodeStatus").val();
        var menuId = $("#menuIdStatus").val();
        $.ajax({
            type: "post",
            url: path + "/backendRichText/changeRichTextStatus?id=" + id + "&status=" + status +
                "&uniqueCode=" + uniqueCode + "&menuId=" + menuId,
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
                    richTextListPaging = new PageView({
                        pageContainer: $("#page-table"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'richTextListPaging',
                        url: path + "/backendRichText/richTextList",
                        curPageName: 'currentPage',
                        curPage: curPage,
                        pageSize: pageSize,
                        urlRequestData: {
                            "menuId": menuId,
                        }
                    });
                }
            }
        });
    });

    /**
     * 清空搜索输入框
     */
    $("#clear-btn_richText").click(function () {
        $("#firstChannel").val("");
        $("#location").val("");
    });

    /**
     * 搜索事件
     */
    $("#search-btn_richText").click(function () {
        $('#active_result_richText').css('display', 'none');

        var firstChannel = $("#firstChannel").val();
        var code = $("#location").val();

        //pageSize标签存在于page.js中
        var pageSize = $("#selectPageForm").val();
        if (!pageSize) {
            pageSize = 15;
        }

        richTextListPaging = new PageView({
            pageContainer: $("#page-table"),
            pageListContainer: $("#data-table"),
            pageViewName: 'richTextListPaging',
            url: path + "/backendRichText/richTextList",
            curPageName: 'currentPage',
            pageSize: pageSize,
            urlRequestData: {
                "menuId": menuId,
                "code": code,
                "firstChannel": firstChannel
            }
        });
    });

});