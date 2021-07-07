/**
 * Created by Administrator on 2018/7/26.
 */
$(function () {
    var path = $("#path").val();
    var detailId = $("#detailId").val();

    adInfoListPaging = new PageView({
        pageContainer: $("#adInfoListPaging"),
        pageListContainer: $("#sub-data-table"),
        pageViewName: 'adInfoListPaging',
        url: path + "/web/advertise/adResourcelist",
        curPageName: 'subCurrentPage',
        pageSize: 15,
        urlRequestData: {
            "hotelId": detailId
        }
    });

    /**
     * 清除搜索框
     */
    $("#clear-btn2").click(function () {
        $(".search-input").val("");
    });

    /**
     * 查询广告位类型及位置
     */
    var loadAdDictionarySelect = function () {
        $.ajax({
            type: "get",
            url: path + "/web/dict/queryDictValuesByDictTypes",
            dataType: 'json',
            success: function (response) {
                var map = response.data;
                for (var k in map) {
                    var values = map[k];
                    if (k == "ad_location") {
                        $(values).each(function (i, data) {
                            $("#detailAdLocation").append("<option value='" + data.id + "'>" + data.name + "</option>");
                        });
                    }
                    if (k == "ad_type") {
                        $(values).each(function (i, data) {
                            $("#detailAdType").append("<option value='" + data.id + "'>" + data.name + "</option>");
                        });
                    }
                    if (k == "ad_status") {
                        $(values).each(function (i, data) {
                            $("#detailAdStatus").append("<option value='" + data.id + "'>" + data.name + "</option>");
                        });
                    }
                }
            }
        });
    }
    loadAdDictionarySelect();

    /**
     * 搜索框点击事件
     */
    $("#search-button2").click(function () {
        var adType = $("#detailAdType").val();
        var adStatus = $("#detailAdStatus").val();
        var adLocation = $("#detailAdLocation").val();
        //pageSize标签存在于page.js中
        var pageSize = $("#selectPageForm").val();
        if (!pageSize) {
            pageSize = 15;
        }
        adInfoListPaging = new PageView({
            pageContainer: $("#adInfoListPaging"),
            pageListContainer: $("#sub-data-table"),
            pageViewName: 'adInfoListPaging',
            url: path + "/web/advertise/adResourcelist",
            curPageName: 'subCurrentPage',
            pageSize: pageSize,
            urlRequestData: {
                "hotelId": detailId,
                "adType": adType,
                "adStatus": adStatus,
                "adLocation": adLocation
            }
        });
    });

});

function openImage(baseSmallImg) {
    $("#imgurlId").attr("src", baseSmallImg);
   var aaa = document.getElementById("aaa");
    var a = (document.documentElement.clientHeight - aaa.offsetHeight) / 2 + "px";
    var b = (document.documentElement.clientWidth - aaa.offsetWidth) / 2 + "px";
    $('#viewcfmModel').css('position', 'fixed');
    $('#viewcfmModel').css('margin', 'auto');

    $('#viewcfmModel').css('left', '0');
    $('#viewcfmModel').css('right', '0');
    $('#viewcfmModel').css('top', a);
//    $('#viewcfmModel').css('bottom', '0');


    $('#viewcfmModel').css("display", "block");
}
