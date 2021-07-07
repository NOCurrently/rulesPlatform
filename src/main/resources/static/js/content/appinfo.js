/**
 * Created by Administrator on 2018/7/29.
 */
$(function () {
    var path = $("#path").val();

    var menuId = $("#menuId").val();

    // 初始化版本号查询条件
    //dictValueLoadSelectSort("versionSelect", "target_version", path, "", "选择版本号");

    listPaging = new PageView({
        pageContainer: $("#listPaging"),
        pageListContainer: $("#data-table"),
        pageViewName: 'listPaging',
        url: path + "/backendContent/infoListData",
        curPageName: 'currentPage',
        pageSize: 15,
        urlRequestData: {
            "menuId": menuId,
        }
    });


    /**
     * 清空搜索输入框
     */
    $("#clear-btn_banner").click(function () {
        $("#bannerId").val("");
        $("#info_title").val("");
        $("#statusSelect").val("");
        //$("#versionSelect").val("");
        $("#bannerId").focus();
    });

    /**
     * 搜索事件
     */
    $("#search-button_banner").click(function () {
        $('#active_result_banner').css('display', 'none');
        var id = $("#bannerId").val();
        if (id.length > 100) {
            $('#active_result_banner').html("id长度不能超过100！").show();
            return;
        }
        if(!isInteger(id)){
            $('#active_result_banner').html("请输入数字！").show();
            return;
        }
        var title = $("#info_title").val();
        if (title.length > 100) {
            $('#active_result_banner').html("名称长度不能超过100！").show();
            return;
        }
        var status = $("#statusSelect").val();
        //var version = $("#versionSelect").val();

        //pageSize标签存在于page.js中
        var pageSize = $("#selectPageForm").val();
        if (!pageSize) {
            pageSize = 15;
        }

        listPaging = new PageView({
            pageContainer: $("#listPaging"),
            pageListContainer: $("#data-table"),
            pageViewName: 'listPaging',
            url: path + "/backendContent/infoListData",
            curPageName: 'currentPage',
            pageSize: pageSize,
            urlRequestData: {
                "menuId": menuId,
                "id": id,
                "title":title,
                //"version":version,
                "status":status
            }
        });
    });

    /**
     * 删除页面
     */
    $("#data-table").on('click', ".deleteFlag_banner", function () {
        var id = $(this).attr('roleId');
        $('#tempId').val(id);
        $('#delBannerModel').modal();
    });

    /**
     * 确认删除
     */
    $("#deleteBanner").click(function () {
        var id = $("#tempId").val();
        $.ajax({
            type: "post",
            url: path + "/backendContent/deleteBanner?id=" + id,
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
                    listPaging = new PageView({
                        pageContainer: $("#listPaging"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'listPaging',
                        url: path + "/backendContent/infoListData",
                        curPageName: 'currentPage',
                        curPage:curPage,
                        pageSize: pageSize,
                        urlRequestData: {
                            "menuId": menuId
                        }
                    });
                }
            }
        });
    });

    /**
     * 开关页面
     */
    $("#data-table").on('click', ".changeFlag_banner", function () {
        var id = $(this).attr('roleId');
        var status = $(this).attr('bannerStatusFlag');
        $('#tempId').val(id);
        if (status == 0) {
            $('#bannerStatusFlag').val(1);
            $('#bannerStatusMessage').text("您确认要开启吗？");
        } else {
            $('#bannerStatusFlag').val(0);
            $('#bannerStatusMessage').text("您确认要关闭吗？");
        }
        $('#changeBannerStatusModel').modal();
    });

    /**
     * 确认开关
     */
    $("#changeBannerStatus").click(function () {
        var id = $("#tempId").val();
        var status = $("#bannerStatusFlag").val();
        $.ajax({
            type: "post",
            url: path + "/backendContent/changeBannerStatus?id=" + id+"&status="+status,
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
                    listPaging = new PageView({
                        pageContainer: $("#listPaging"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'listPaging',
                        url: path + "/backendContent/infoListData",
                        curPageName: 'currentPage',
                        curPage:curPage,
                        pageSize: pageSize,
                        urlRequestData: {
                            "menuId": menuId
                        }
                    });
                }
            }
        });
    });

    // banner新增界面
    $("#insertBanner").bind("click", function bannerAdd(){
       // 1.需要根据menuId弹出不同的新建页面
        var menuId = $("#menuId").val();

        $('#editContentInitDiv').load(path + "/backendContent/editContentInit?menuId=" + menuId);
        $('#editContentInitDiv').modal({});

    });



    /**
     * 右侧树列表中的编辑
     */
    var table = $("#data-table");
    table.on('click', ".edit", function () {
        var infoId = $(this).attr('infoId');
        var menuId = $("#menuId").val();

        $('#editContentInitDiv').load(path + "/backendContent/editContentInit?menuId=" + menuId+"&infoId="+infoId);
        $('#editContentInitDiv').modal();
    });

});




