/**
 * Created by Administrator on 2018/7/29.
 */
$(function() {
	var path = $("#path").val();

	logListPaging = new PageView({
		pageContainer : $("#logListPaging"),
		pageListContainer : $("#data-table"),
		pageViewName : 'logListPaging',
		url : path + "/operationLog/logListData",
		curPageName : 'currentPage',
		pageSize : 15,
		urlRequestData : {
		}
	});

    /**
	 * 弹出新增页面
     */
    $("#insert-button_log").click(function () {
        $('#log_result').css("display","none");
        $('#insertLogModel').load(path + "/page/log/logEdit");
        $('#insertLogModel').modal({});

    });

    /**
     * 清空搜索输入框
     */
    $("#clear-btn_log").click(function () {
        $("#username").val("");
        $("#url").val("");
        $("#username").focus();
    });

    /**
     * 搜索事件
     */
    $("#search-button_log").click(function () {
        $('#active_result_log').css('display', 'none');
        var username = $("#username").val();
        if (username.length > 100) {
            $('#active_result_log').html("操作者姓名长度不能超过100！").show();
            return;
        }
        var url = $("#url").val();
        if (url.length > 200) {
            $('#active_result_log').html("操作URL长度不能超过200！").show();
            return;
        }

        var curPage = $("#pageInput").val();
        if (!curPage) {
            curPage = 1;
        }
        //pageSize标签存在于page.js中
        var pageSize = $("#selectPageForm").val();
        if (!pageSize) {
            pageSize = 15;
        }

        logListPaging = new PageView({
            pageContainer: $("#logListPaging"),
            pageListContainer: $("#data-table"),
            pageViewName: 'logListPaging',
            url: path + "/operationLog/logListData",
            curPageName: 'currentPage',
            curPage:curPage,
            pageSize: pageSize,
            urlRequestData: {
                "username": username,
                "url": url
            }
        });
    });

});