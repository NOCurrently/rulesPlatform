/**
 * dunn.deng
 */
$(function () {
    var path = $("#path").val();
    var keyword = $("#search-input").val();

    if ('' == keyword) {
        keyword = "";
    }

    dictTypeListPaging = new PageView({
        pageContainer: $("#dictTypeListPaging"),
        pageListContainer: $("#data-table"),
        pageViewName: 'dictTypeListPaging',
        url: path + "/sysDictType/listSysDictType",
        curPageName: 'currentPage',
        pageSize: 15,
        urlRequestData:{"keyword":keyword}
    });

    //新增数据字典类型弹出框
    $("#insert-button").click(function () {
        $("#name").val("");
        $("#code").val("");
        $("#type").val("");
        $("#remark").val("");
        document.getElementById("dictType_result").innerHTML = "";
        $('#result').css("display","none");
        $('#createDictTypeModel').modal({});

        //关闭popWindow 页面数据刷新
        var tagId = '#createDictTypeModel';
        main.methods.closePopupRefreshContainer(tagId);
    });

    //提交新增数据字典类型数据
    $("#dictTypeSaveBtn").bind("click",function(){
        if(!$("#name").val()) {
            $('#dictType_result').html("名称不能为空！").show();
            return;
        }
        if(!$("#code").val()) {
            $('#dictType_result').html("编码不能为空！").show();
            return;
        }
        if(!$("#type").val()) {
            $('#dictType_result').html("类型不能为空！").show();
            return;
        }
        $('#r_dictTypeForm').ajaxForm({
            success: dictTypeComplete,  	 // post-submit callback
            dataType: 'json'
        }).submit();
        return true;
    });

    //提交成功后
    function dictTypeComplete(data){
        if (data.code=='200'){
            //关闭当前窗口
            $("#createDictTypeModel").modal('hide');

            var keyword = $(".search-input").val();
            //curPage为当前页码，此$("#pageInput").val()取值为page.js中input框参数
            var curPage = $("#pageInput").val();
            if (!curPage) {
                curPage = 1;
            }
            //pageSize标签存在于page.js中
            var pageSize = $("#pageSize").val();
            if(!pageSize) {
                pageSize = 15;
            }
            dictTypeList = new PageView({
                pageContainer: $("#dictTypeListPaging"),
                pageListContainer: $("#data-table"),
                pageViewName: 'dictTypeList',
                url: path + "/sysDictType/listSysDictType",
                curPageName: 'currentPage',
                pageSize: pageSize,
                curPage: curPage,
                urlRequestData: {
                    "keyword": keyword
                }
            });
        } else {
            $('#dictType_result').html(data.errorMessage).show();
        }
    }

    $("#clear-btn").click(function () {
        $(".search-input").val("");
        $(".search-input").focus();
    });

    var table = $("#data-table");

    //数据字典类型值列表
    table.on('click', ".listvalue", function () {
        var id = $(this).attr('dictTypeId');
        $('#dictValueListPaging').load(path + "/sysDictValue/listSysDictValue?id="+id);
        $('#dictValueListPaging').modal({});
    });

    //编辑数据字典类型
    table.on('click', ".edit", function () {
        var id = $(this).attr('dictTypeId');
        $('#modifyDictTypeModel').load(path + "/sysDictType/editDictType?id="+id);

        $('#modifyDictTypeModel').modal({});
    });

    //删除数据字典类型
    table.on('click', ".delete", function () {
        var id = $(this).attr('dictTypeId');
        $('#dictTypeId').val(id);
        $('#delcfmModel').modal();
    });

    $("#imsuer").click(function () {
        var dictTypeId=$("#dictTypeId").val();
        $.ajax({
            type: "post",
            url: path + "/sysDictType/deleteSysDictType?id=" + dictTypeId,
            format: "json",
            success: function (data) {
                if ($.trim(data.code) != "200") {
                    alert(data.errorMessage);
                } else {
                    var keyword = $(".search-input").val();
                    //curPage为当前页码，此$("#pageInput").val()取值为page.js中input框参数
                    var curPage = $("#pageInput").val();
                    if (!curPage) {
                        curPage = 1;
                    }
                    //pageSize标签存在于page.js中
                    var pageSize = $("#pageSize").val();
                    if(!pageSize) {
                        pageSize = 15;
                    }
                    dictTypeList = new PageView({
                        pageContainer: $("#dictTypeListPaging"),
                        pageListContainer: $("#data-table"),
                        pageViewName: 'dictTypeList',
                        url: path + "/sysDictType/listSysDictType",
                        curPageName: 'currentPage',
                        pageSize: pageSize,
                        curPage: curPage,
                        urlRequestData: {
                            "keyword": keyword
                        }
                    });
                }
                //window.location.href= path + "/sysuser/userList";
            }
        });
    });

    var tablevalue = $("#dictValueListPaging");
    tablevalue.on('click', ".value_delete", function () {
        var id = $(this).attr('dictValueId');
        $('#dictValueId').val(id);
        $('#delvaluecfm').modal();
    });
    //编辑数据字典类型
    tablevalue.on('click', ".value_edit", function () {
        var id = $(this).attr('dictValueId');
        $('#modifyDictValueModel').load(path + "/sysDictValue/editDictValue?id="+id);

        $('#modifyDictValueModel').modal({});
    });

    //添加数据字典值
    table.on('click',".addvalue",function () {
        var id = $(this).attr('dictTypeId');
        $('#createDictValueModel').load(path + "/sysDictType/getDictType?id="+id);

        $('#createDictValueModel').modal({});
    });

    $("#imsdictvalue").click(function () {
        var dictValueId=$("#dictValueId").val();
        $.ajax({
            type: "post",
            url: path + "/sysDictValue/deleteSysDictValue?id=" + dictValueId,
            format: "json",
            success: function (data) {
                if ($.trim(data.code) != "200") {
                    alert(data.errorMessage);
                } else {

                    $('#dictValueListPaging').modal({show: true,
                        backdrop:'static'});
                    //$('#dictValueListPaging').css("display","block");
                    $(".dictValue_" + dictValueId).remove();
                }
            }
        });
    });


    $("#search-button").click(function () {
        var keyword = $(".search-input").val();

        if ('' == keyword) {
            keyword = "";
        }
        //pageSize标签存在于page.js中
        var pageSize = $("#pageSize").val();
        if(!pageSize) {
            pageSize = 15;
        }
        dictTypePage = new PageView({
            pageContainer: $("#dictTypeListPaging"),
            pageListContainer: $("#data-table"),
            pageViewName: 'dictTypePage',
            url: path + "/sysDictType/listSysDictType",
            curPageName: 'currentPage',
            pageSize: pageSize,
            urlRequestData: {
                "keyword": keyword
            }
        });
    })
});
function delcfm(url) {
    $('#url').val(url);//给会话中的隐藏属性URL赋值
    $('#delcfmModel').modal();
}
function delvaluecfm(url) {
    $('#dictValueListPaging').modal('hide');
    $('#url').val(url);//给会话中的隐藏属性URL赋值
    $('#delvaluecfm').modal();
}

