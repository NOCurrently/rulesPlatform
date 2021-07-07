/**
 * Created by Administrator on 2018/7/29.
 */
$(function () {
    var path = $("#path").val();
    //查询key
    $("#search-button").click(function () {
        var keyword = $(".search-input").val();
        
        cleanListPaging = new PageView({
            pageContainer: $("#listPaging"),
            pageListContainer: $("#data-table"),
            pageViewName: 'listPaging',
            url: path + "/cache/getCacheList",
            urlRequestData: {
            	"keyword" : keyword
            }
        });
    })
    //清楚搜索
    $("#clear-btn").click(function () {
        $(".search-input").val("");
        $(".search-input").focus();
    });
    
    
    var table = $("#data-table");
    //删除页面
    table.on('click', ".delete", function () {
    	var cleanKey = $(this).attr('cleanKey');
    	$('#cleanKey').val(cleanKey);
    	$('#delcfmModel').modal();
    });
       //确认删除
    $("#imsuer").click(function () {
    	var cleanKey=$("#cleanKey").val();
   	 	$.ajax({
            type: "post",
            url: path + "/cache/deleteCacheByKey?keys=" + cleanKey,
            format: "json",
            success: function (data) {
                if (data.success) {
        	        var keyword = $(".search-input").val();
        	        cleanListPaging = new PageView({
        	            pageContainer: $("#listPaging"),
        	            pageListContainer: $("#data-table"),
        	            pageViewName: 'listPaging',
        	            url: path + "/cache/getCacheList",
        	            urlRequestData: {
        	            	"keyword" : keyword
        	            }
        	        });
                } else {
                	 alert(data.errorMessage);
                }
            }
        });
    });
    //查看
    table.on('click', ".observed", function () {
    	var cleanKey = $(this).attr('cleanKey');
    	$.ajax({
            type: "post",
            url: path + "/cache/observed?key=" + cleanKey,
            format: "json",
            success: function (data) {
                if (data.success) {
                	var cachedata = data.data;
        	        $('#cacheValue').html(cachedata.type+"--->"+cachedata.data);
        	    	$('#observedModel').modal();
                } else {
                	 alert(data.errorMessage);
                }
            }
        });
    });
    
    //选择删除
    $("#cleancache-button").click(function() {
    	var caches = "";
    	$("input[name='cache']:checked").each(function () {
            //alert(this.value);
    		caches=caches+this.value+",";
        });
    	alert(caches)
    	$.ajax({
            type: "post",
            url: path + "/cache/deleteCacheByKey?keys=" + caches,
            format: "json",
            success: function (data) {
                if (data.success) {
        	        var keyword = $(".search-input").val();
        	        cleanListPaging = new PageView({
        	            pageContainer: $("#listPaging"),
        	            pageListContainer: $("#data-table"),
        	            pageViewName: 'listPaging',
        	            url: path + "/cache/getCacheList",
        	            urlRequestData: {
        	            	"keyword" : keyword
        	            }
        	        });
                } else {
                	 alert(data.errorMessage);
                }
            }
        });
    });
});