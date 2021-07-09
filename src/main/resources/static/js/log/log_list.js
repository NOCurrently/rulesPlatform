/**
 * Created by Administrator on 2018/7/29.
 */
$(function() {
	var path = $("#path").val();
	var type = $(".search-input").val();
	var objectId = $(".search-input1").val();
	
	//var objectId = $("#objectId").val();


	logListPaging = new PageView({
		pageContainer : $("#logListPaging"),
		pageListContainer : $("#data-table"),
		pageViewName : 'logListPaging',
		url : path + "/sysLog/list",
		curPageName : 'currentPage',
		pageSize : 15,
		urlRequestData : {
			keyword : type,
			keyword1 : objectId
		}
	});

	$("#insert-button").click(function() {
		 $("#r_userForm")[0].reset();
		 $("#logId").val("");
	     $("#type").val("");
	     $("#userId").val("");
	     $("#userName").val("");
	     $("#ip").val("");
	     $("#objectType").val("");
	     $("#objectId").val("");
	     $("#objectContent").val("");
		document.getElementById("user_result").innerHTML = "";
		$('#result').css("display", "none");
		$('#createUserModel').modal({});
	});

	// 提交数据
	$("#userSaveBtn").bind("click", function() {
		$('#r_userForm').ajaxForm({
			success : userComplete, // post-submit callback
			dataType : 'json'
		}).submit();
		return false;
	});

	//提交成功后
    function userComplete(data){
	     if (data.code=='200'){
	    	 //关闭当前窗口
	    	 $("#createUserModel").modal('hide');
	    	 
	    	 var keyword = $(".search-input").val();
	    	 var keyword1 = $(".search-input1").val();
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
	         userPage = new PageView({
	             pageContainer: $("#logListPaging"),
	             pageListContainer: $("#data-table"),
	             pageViewName: 'userPage',
	             url: path + "/sysLog/list",
	             curPageName: 'currentPage',
	             pageSize: pageSize,
	             curPage: curPage,
	             urlRequestData: {
	            	 "keyword" : keyword,
	 				 "keyword1": keyword1
	             }
	         });
	     } else {
	    	 $('#user_result').html(data.errorMessage).show();
	     }
	}

	$("#clear-btn").click(function() {
		$(".search-input").val("");
		$(".search-input").focus();
	});
	var table = $("#data-table");

	table.on('click', ".edit", function() {
		var id = $(this).attr('logId');

		$('#modifyUserModel').load(path + "/sysLog/edit?id=" + id);
		$('#modifyUserModel').modal({});
	});

	table.on('click', ".delete", function() {
		var id = $(this).attr('logId');
		$('#confirm-model').val(id);
		$('#delcfmModel').modal();
	});

	$("#imsuer").click(function() {
		var logId = $("#confirm-model").val();
		$.ajax({
			type : "post",
			url : path + "/sysLog/delete?id=" + logId,
			format : "json",
			success : function(data) {
				if ($.trim(data.code) != "200") {
					alert(data.message);
				} else {
					alert(data.message);
					$(".log_" + logId).remove();
				}
			}
		});
	});

	$("#search-button").click(function() {
		// var keyword = $(".search-input").val();

		var type = $("#type").val();
		var objectId = $("#objectId").val();
//		if ('' == keyword) {
//			keyword = "";
//		}
		// pageSize标签存在于page.js中
		var pageSize = $("#pageSize").val();
		if (!pageSize) {
			pageSize = 15;
		}
		userPage = new PageView({
			pageContainer : $("#logListPaging"),
			pageListContainer : $("#data-table"),
			pageViewName : 'userPage',
			url : path + "/sysLog/list",
			curPageName : 'currentPage',
			pageSize : pageSize,
			urlRequestData : {
			    keyword : type,
				keyword1:objectId
			}
		});
	})
});