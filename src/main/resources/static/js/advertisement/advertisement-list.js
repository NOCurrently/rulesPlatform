/**
 * Created by Administrator on 2018/7/29.
 */
$(function () {
    var path = $("#path").val();
    var stateId = $("#provinceSearchSelect").val();


    adListPaging = new PageView({
        pageContainer: $("#adListPaging"),
        pageListContainer: $("#data-table"),
        pageViewName: 'adListPaging',
        url: path + "/web/advertise/list",
        curPageName: 'currentPage',
        pageSize: 15,
        urlRequestData: {
            "stateId": stateId
        }
    });

    /**
     * 清除搜索框
     */
    $("#clear-btn").click(function () {
        $(".search-input").val("");
    });

    /**
     * 查看详情
     */
    var table = $("#data-table");
    table.on('click', ".edit", function () {
        var hotelId = $(this).attr('hotelId');
        $('#detailModel').load(path + "/web/advertise/advertisementInfo?hotelId=" + hotelId);
        $('#detailModel').modal();
    });


    /**
     * 添加酒店状态
     */
    var loadReqHotelStatus = function (statusId) {
        $.ajax({
            type: "get",
            url: path + "/web/advertise/queryHotelStatus",
            dataType: 'json',
            success: function (jsonData) {
                var select = $("#" + statusId);
                for (var key in jsonData) {
                    select.append("<option value='" + key + "'>" + jsonData[key] + "</option>");
                }
            }
        });
    }
    /**
     * 添加酒店类型
     */
    var loadReqHotelType = function (typeId) {
        $.ajax({
            type: "get",
            url: path + "/web/advertise/queryHotelType",
            dataType: 'json',
            success: function (jsonData) {
                var select = $("#" + typeId);
                for (var key in jsonData) {
                    select.append("<option value='" + key + "'>" + jsonData[key] + "</option>");

                }
            }
        });
    }
    loadReqHotelStatus("hotelStatusSelect");
    loadReqHotelType("hotelTypeSelect");

    /**
     * 省市区3级联动
     */
    var regions;
    var loadRegionsSelect = function (provinceId) {
        $.ajax({
            type: "get",
            url: path + "/web/advertise/queryRegions",
            dataType: 'json',
            success: function (response) {
                var jsonData = response.data;
                regions = jsonData;
                var select = $("#" + provinceId);
                $(jsonData).each(function (i, data) {
                    select.append("<option value='" + data.stateId + "'>" + data.stateName + "</option>");
                });
            }
        });
    }
    loadRegionsSelect("provinceSearchSelect");
    var cities;
    $("#provinceSearchSelect").bind("change", function () {
        var citySelect = $("#citySearchSelect");
        var areaSelect = $("#areaSearchSelect");
        citySelect.empty();
        areaSelect.empty();
        var provinceSelect = $("#provinceSearchSelect");
        var provinceVal = provinceSelect.find("option:selected").val();
        $(regions).each(function (i, data) {
            if (data.stateId == provinceVal) {
                cities = data.cityVOList;
            }
        });
        citySelect.append("<option value=''>请选择城市</option>");
        areaSelect.append("<option value=''>请选择区县</option>");
        $(cities).each(function (i, data) {
            citySelect.append("<option value='" + data.cityId + "'>" + data.cityName + "</option>");
        });
    });
    var areas;
    $("#citySearchSelect").bind("change", function () {
        var areaSelect = $("#areaSearchSelect");
        areaSelect.empty();
        var citySelect = $("#citySearchSelect");
        var cityVal = citySelect.find("option:selected").val();
        $(cities).each(function (i, data) {
            if (data.cityId == cityVal) {
                areas = data.clusterVOList;
            }
        });
        areaSelect.append("<option value=''>请选择区县</option>");
        $(areas).each(function (i, data) {
            areaSelect.append("<option value='" + data.clusterId + "'>" + data.clusterName + "</option>");
        });
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
                            $("#adLocationSelect").append("<option value='" + data.id + "'>" + data.name + "</option>");
                        });
                    }
                    if (k == "ad_type") {
                        $(values).each(function (i, data) {
                            $("#adTypeSelect").append("<option value='" + data.id + "'>" + data.name + "</option>");
                        });
                    }
                    if (k == "ad_status") {
                        $(values).each(function (i, data) {
                            $("#adStatusSelect").append("<option value='" + data.id + "'>" + data.name + "</option>");
                        });
                    }
                }
            }
        });
    }
    loadAdDictionarySelect();

    /**
     * 文件上传
     */
    $("#upload-button").click(function () {
        var hotelId = $("#hotelId").val();
        var hotelName = $("#hotelName").val();
        var adType = $("#adTypeSelect").val();
        var adStatus = $("#adStatusSelect").val();
        var adLocation = $("#adLocationSelect").val();
        var stateId = $("#provinceSearchSelect").val();
        var cityId = $("#citySearchSelect").val();
        var clusterId = $("#areaSearchSelect").val();
        var hotelType = $("#hotelTypeSelect").val();
        var hotelStatus = $("#hotelStatusSelect").val();
        var totalCount = $("#totalCount").val();
        var rrr = path + "/web/advertise/download?hotelId=" + hotelId + "&hotelName=" + hotelName + "&adType=" + adType + "&adStatus=" + adStatus + "&adLocation=" + adLocation + "&stateId=" + stateId + "&cityId=" + cityId + "&clusterId=" + clusterId + "&hotelType=" + hotelType + "&hotelStatus=" + hotelStatus+"&totalCount="+totalCount;
        window.open(rrr);

    });
    /**
     * 搜索框点击事件
     */
    $("#search-button").click(function () {
        $('#active_result').css('display','none');
        var hotelId = $("#hotelId").val();
        if($("#hotelId").val().length > 100){
            $('#active_result').html("酒店ID长度不能超过100").show();
            return;
        }
        var hotelName = $("#hotelName").val();
        if($("#hotelName").val().length > 200){
            $('#active_result').html("酒店名称长度不能超过200").show();
            return;

        }
        var adType = $("#adTypeSelect").val();
        var adStatus = $("#adStatusSelect").val();
        var adLocation = $("#adLocationSelect").val();
        var stateId = $("#provinceSearchSelect").val();
        var cityId = $("#citySearchSelect").val();
        var clusterId = $("#areaSearchSelect").val();
        var hotelType = $("#hotelTypeSelect").val();
        var hotelStatus = $("#hotelStatusSelect").val();
        //pageSize标签存在于page.js中
        var pageSize = $("#selectPageForm").val();
        if (!pageSize) {
            pageSize = 15;
        }
        adListPaging = new PageView({
            pageContainer: $("#adListPaging"),
            pageListContainer: $("#data-table"),
            pageViewName: 'adListPaging',
            url: path + "/web/advertise/list",
            curPageName: 'currentPage',
            pageSize: pageSize,
            urlRequestData: {
                "hotelId": hotelId,
                "hotelName": hotelName,
                "adType": adType,
                "adStatus": adStatus,
                "adLocation": adLocation,
                "stateId": stateId,
                "cityId": cityId,
                "clusterId": clusterId,
                "hotelType": hotelType,
                "hotelStatus": hotelStatus
            }
        });
    });

});