/**
 * Created by Administrator on 2019/8/15.
 */
$(function () {
    var path = $("#path").val();

    var menuId = $("#menuId").val();

    var type = "content_manage";

    // 页面上内容初始化
    dictValueLoadSelectSort("contentType", "content_type", path, "", "选择类别");
    //dictValueLoadSelectSort("location", "content_location", path, "", "选择位置");
    ruleValueLoadSelectSort("location", "content_manage", path, "", "选择位置");
    /**
     * 页面上的分页
     */
    contentListPaging = new PageView({
        pageContainer: $("#page-table"),
        pageListContainer: $("#data-table"),
        pageViewName: 'contentListPaging',
        url: path + "/contentManage/contentManageListData",
        curPageName: 'currentPage',
        pageSize: 15,
        urlRequestData: {
            "type": type,
            "menuId": menuId,
        }
    });

    /**
     * 新增
     */
    $("#insertContent").bind("click", function contentManageAdd() {

        var menuId = $("#menuId").val();

        $('#contentManageEditModel').load(path + "/contentManage/editContentManageInit?menuId=" + menuId + "&type=" + type);
        $('#contentManageEditModel').modal({});

    });


    /**
     * 编辑
     */
    var table = $("#data-table");
    table.on('click', ".edit", function () {
        var menuId = $("#menuId").val();
        var contentId = $(this).attr('contentId');
        $('#contentManageEditModel').load(path + "/contentManage/editContentManageInit?contentId=" + contentId + "&menuId=" + menuId + "&type=" + type);
        $('#contentManageEditModel').modal();
    });

    /**
     * 删除页面
     */
    $("#data-table").on('click', ".delete_content", function () {
        var id = $(this).attr('contentId');
        var uniqueCode = $(this).attr('uniqueCode');
        var menuId = $("#menuId").val();
        $('#deleteContentId').val(id);
        $('#deleteUniqueCode').val(uniqueCode);
        $('#deleteMenuId').val(menuId);
        $('#delContentModel').modal();
    });

    /**
     * 确认删除
     */
    $("#deleteContent").click(function () {
        var id = $("#deleteContentId").val();
        var uniqueCode = $("#deleteUniqueCode").val();
        var menuId = $("#deleteMenuId").val();
        $.ajax({
            type: "post",
            url: path + "/contentManage/deleteContentManage?id=" + id + "&uniqueCode=" + uniqueCode + "&menuId=" + menuId,
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

                    contentListPaging = new PageView({
                        pageContainer: $("#page-table"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'contentListPaging',
                        url: path + "/contentManage/contentManageListData",
                        curPageName: 'currentPage',
                        curPage: curPage,
                        pageSize: pageSize,
                        urlRequestData: {
                            "type": type,
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
    $("#data-table").on('click', ".changeContentStatus", function () {
        var id = $(this).attr('contentId');
        var status = $(this).attr('contentStatus');
        var uniqueCode = $(this).attr('uniqueCode');
        var menuId = $("#menuId").val();
        $('#changeContentId').val(id);
        $('#uniqueCodeStatus').val(uniqueCode);
        $('#menuIdStatus').val(menuId);
        if (status == 0) {
            $('#contentStatusFlag').val(1);
            $('#contentStatusMessage').text("您确认要开启吗？");
        } else {
            $('#contentStatusFlag').val(0);
            $('#contentStatusMessage').text("您确认要关闭吗？");
        }
        $('#changeContentStatusModel').modal();
    });

    /**
     * 确认开关
     */
    $("#changeContentStatus").click(function () {
        var id = $("#changeContentId").val();
        var status = $("#contentStatusFlag").val();
        var uniqueCode = $("#uniqueCodeStatus").val();
        var menuId = $("#menuIdStatus").val();
        $.ajax({
            type: "post",
            url: path + "/contentManage/changeStatus?id=" + id + "&status=" + status +
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
                    contentListPaging = new PageView({
                        pageContainer: $("#page-table"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'contentListPaging',
                        url: path + "/contentManage/contentManageListData",
                        curPageName: 'currentPage',
                        curPage: curPage,
                        pageSize: pageSize,
                        urlRequestData: {
                            "type": type,
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
    $("#clear-btn_content").click(function () {
        $("#contentType").val("");
        $("#location").val("");
    });

    /**
     * 搜索事件
     */
    $("#searchContent").click(function () {
        $('#active_result_content').css('display', 'none');

        var contentType = $("#contentType").val();
        var locationCode = $("#location").val();

        //pageSize标签存在于page.js中
        var pageSize = $("#selectPageForm").val();
        if (!pageSize) {
            pageSize = 15;
        }

        contentListPaging = new PageView({
            pageContainer: $("#page-table"),
            pageListContainer: $("#data-table"),
            pageViewName: 'contentListPaging',
            url: path + "/contentManage/contentManageListData",
            curPageName: 'currentPage',
            pageSize: pageSize,
            urlRequestData: {
                "menuId": menuId,
                "type": type,
                "contentType": contentType,
                "locationCode": locationCode
            }
        });
    });

});