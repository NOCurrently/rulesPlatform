/**
 * Created by Administrator on 2018/7/29.
 */
$(function () {
    var path = $("#path").val();
    
    var menuId= $("#menuId").val();

    listPaging = new PageView({
        pageContainer: $("#listPaging"),
        pageListContainer: $("#data-table"),
        pageViewName: 'listPaging',
        url: path + "/backendMenu/menuListData",
        curPageName: 'currentPage',
        pageSize: 15,
        urlRequestData: {
            "parentId": menuId
        }
    });
//搜索
    $("#search-button").click(function () {
        var title = $("#title").val();
        var code = $("#code").val();
        let searchPara = $('#r_searchForm').serialize();
        //form表单参数
        listPaging = new PageView({
            pageContainer: $("#listPaging"),
            pageListContainer: $("#data-table"),
            pageViewName: 'listPaging',
            url: path + "/backendMenu/menuListData?"+searchPara,
            curPageName: 'currentPage',
            pageSize: 15,
            urlRequestData: {
                "parentId": menuId
            }
        });
       
    })
    //清空
    $("#clear-btn").click(function () {
        $(".search-input").val("");
        $(".search-input").focus();
    });
    //增加页面
    $("#insert-button").click(function () {
        var menuId = $("#menuId").val();
        $('#updateMenu').load(path + "/page/content/auth/menuEdit");
        $('#updateMenu').modal({});
    
});
  //编辑页面
    $("#data-table").on('click', ".edit", function () {
    	 var id = $(this).attr('dataId');
         $('#updateMenu').load(path + "/backendMenu/menuData?id=" + id);
         $('#updateMenu').modal({});
    });
  //删除页面
    $("#data-table").on('click', ".deleteFlag", function () {
        var id = $(this).attr('dataId');
        $('#dataId').val(id);
        $('#delFmModel').modal();
    });
    //确认删除
    $("#delectData").click(function () {
        var id = $("#dataId").val();
        $.ajax({
            type: "post",
            url: path + "/backendMenu/deleteMenu?id=" + id,
            format: "json",
            success: function (data) {
                if (!data.success) {
                    alert(data.errorMessage);
                } else {
                	listPaging = new PageView({
                        pageContainer: $("#listPaging"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'listPaging',
                        url: path + "/backendMenu/menuListData",
                        curPageName: 'currentPage',
                        pageSize: 15,
                        urlRequestData: {
                            "parentId": menuId
                        }
                    });
                }
            }
        });
    });
//开关页面
    $("#data-table").on('click', ".changeFlag", function () {
        var id = $(this).attr('dataId');
        var status = $(this).attr('status');
        $('#dataId').val(id);
        if (status == 0) {
            $('#status').val(1);
            $('#message').text("您确认要开启吗？");
        } else {
            $('#status').val(0);
            $('#message').text("您确认要关闭吗？");
        }
        $('#changeStatus').modal();
    });
    
    //确认开关
    $("#changeStatuSuer").click(function () {
        var id = $("#dataId").val();
        var status = $("#status").val();
        $.ajax({
            type: "post",
            url: path + "/backendMenu/changeStatus?id=" + id+"&status="+status,
            format: "json",
            success: function (data) {
                if (!data.success) {
                    alert(data.errorMessage);
                } else {
                	listPaging = new PageView({
                        pageContainer: $("#listPaging"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'listPaging',
                        url: path + "/backendMenu/menuListData",
                        curPageName: 'currentPage',
                        pageSize: 15,
                        urlRequestData: {
                            "parentId": menuId
                        }
                    });
                }
            }
        });
    });
});



