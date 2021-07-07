/**
 * Created by Administrator on 2019/08/24.
 */
$(function () {
    var path = $("#path").val();

    /**
     * 页面上的分页
     */
    ruleListPaging = new PageView({
        pageContainer: $("#page-table"),
        pageListContainer: $("#data-table"),
        pageViewName: 'ruleListPaging',
        url: path + "/contentConfigRule/ruleListData",
        curPageName: 'currentPage',
        pageSize: 15,
        urlRequestData: {}
    });

    /**
     * 新增
     */
    $("#insertRule").bind("click", function ruleConfigAdd() {

        $('#ruleEditModel').load(path + "/contentConfigRule/editRuleInit");
        $('#ruleEditModel').modal({});

    });

    /**
     * 编辑
     */
    var table = $("#data-table");
    table.on('click', ".edit", function () {
        var ruleId = $(this).attr('ruleId');
        $('#ruleEditModel').load(path + "/contentConfigRule/editRuleInit?ruleId=" + ruleId);
        $('#ruleEditModel').modal();
    });

    /**
     * 清空搜索输入框
     */
    $("#clear-button_rule").click(function () {
        $("#name").val("");
        $("#typeName").val("");
        $("#name").focus();
    });

    /**
     * 搜索事件
     */
    $("#searchRule").click(function () {
        $('#active_result_rule').css('display', 'none');

        var name = $("#name").val();
        var typeName = $("#typeName").val();

        //pageSize标签存在于page.js中
        var pageSize = $("#selectPageForm").val();
        if (!pageSize) {
            pageSize = 15;
        }

        ruleListPaging = new PageView({
            pageContainer: $("#page-table"),
            pageListContainer: $("#data-table"),
            pageViewName: 'ruleListPaging',
            url: path + "/contentConfigRule/ruleListData",
            curPageName: 'currentPage',
            pageSize: pageSize,
            urlRequestData: {
                "name": name,
                "typeName": typeName
            }
        });
    });

    /**
     * 开关页面
     */
    $("#data-table").on('click', ".changeRuleStatus", function () {
        var id = $(this).attr('ruleId');
        var status = $(this).attr('ruleStatus');
        $('#changeRuleId').val(id);
        if (status == 0) {
            $('#ruleStatusFlag').val(1);
            $('#ruleStatusMessage').text("您确认要开启吗？");
        } else {
            $('#ruleStatusFlag').val(0);
            $('#ruleStatusMessage').text("您确认要关闭吗？");
        }
        $('#changeRuleStatusModel').modal();
    });

    /**
     * 确认开关
     */
    $("#changeRuleStatus").click(function () {
        var id = $("#changeRuleId").val();
        var status = $("#ruleStatusFlag").val();
        $.ajax({
            type: "post",
            url: path + "/contentConfigRule/changeRuleStatus?id=" + id + "&status=" + status,
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
                    ruleListPaging = new PageView({
                        pageContainer: $("#page-table"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'ruleListPaging',
                        url: path + "/contentConfigRule/ruleListData",
                        curPageName: 'currentPage',
                        curPage: curPage,
                        pageSize: pageSize,
                        urlRequestData: {}
                    });
                }
            }
        });
    });


});