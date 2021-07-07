/**
 * Created by Administrator on 2018/7/25.
 */
$(function () {
    var path = $("#path").val();
    var keyword = $("#search-input").val();

    if ('' == keyword) {
        keyword = "";
    }

    authListPaging = new PageView({
        pageContainer: $("#authListPaging"),
        pageListContainer: $("#data-table"),
        pageViewName: 'authListPaging',
        url: path + "/web/auth/selectSysAuthList",
        curPageName: 'currentPage',
        pageSize: 15,
        urlRequestData:{}
    });

    function getFirstAuthMenu() {
    	//显示一级目录
 	   $.ajax({
 			type: "GET",
 			url: path + "/web/auth/firstAuthMenu",
 			//async: false,//一条请求
 			error:function(data){
 				//alert('11');
 			},

 			success: function(data){
 				for (var i = 0; i < data.length; i++) {
 	  			    $("#pid").append("<option value='"+data[i].id+"' data-lev='"+data[i].pid+"'>"+data[i].name+"</option>");
 	            }
 			}
 		});
 	    $("#type").change(function(){
 			  var type = $("#type").val();
 			  switch (type){
 	            case "oneLevel":
 	                  $("#oneLevel").css("display","none");
 	            	  $("#pid").val("");
 	                break;
 	            case "url":
 	          	  $("#oneLevel").css("display","block");
 	                break;
 	        }
 		  });
 	    $("#oneLevel").css("display","none");
    }

    $("#insert-button").click(function () {
    	$("#name").val("");
    	$("#code").val("");
    	$("#type").val("oneLevel");
    	$("#url").val("");
    	$("#sort").val("0");
    	$("#icon").val("glyphicon glyphicon-globe");
    	$("#remark").val("");
    	document.getElementById("pid").innerHTML = ""
    	document.getElementById("auth_result").innerHTML = "";
    	$('#result').css("display","none");

    	getFirstAuthMenu();
		$('#createAuthModel').modal({});

    });

    //提交数据
	$("#authSaveBtn").bind("click",function(){
		if(!$("#name").val()) {
			 $('#auth_result').html("资源名称不能为空").show();
			 return false;
		} else if(!$("#code").val()) {
			$('#auth_result').html("资源编码不能为空").show();
			 return false;
		} else if(!$("#url").val()) {
			$('#auth_result').html("资源请求路径不能为空").show();
			 return false;
		}
	     $(this).attr('disabled', 'disabled');

		 $('#r_authForm').ajaxForm({
			 dataType: 'json',
	            success:function (data) {
	            	userComplete(data); 
	    			 $("#authSaveBtn").removeAttr('disabled');
	            },  
				 error: function (e) {
	    			 $("#authSaveBtn").removeAttr('disabled');
		         }  	 // post-submit callback
	           
	     }).submit();
		return true;
	});

	//提交成功后
    function userComplete(data){
         if (data.code=='200'){
        	//关闭当前窗口
	    	 $("#createAuthModel").modal('hide');

	         //pageSize标签存在于page.js中
	         var pageSize = $("#pageSize").val();
	         if(!pageSize) {
	         	pageSize = 15;
	         }
	         authListPaging = new PageView({
	             pageContainer: $("#authListPaging"),
	             pageListContainer: $("#data-table"),
	             pageViewName: 'authListPaging',
	             url: path + "/web/auth/selectSysAuthList",
	             curPageName: 'currentPage',//currentPage当前页码，传入后台的key值
	             pageSize: pageSize,
	             urlRequestData: {
	             }
	         });
	         $(".search-input").val("");
         } else {
        	 $('#auth_result').html(data.errorMessage).show();
         }
    }

    $("#clear-btn").click(function () {
        $(".search-input").val("");
        $(".search-input").focus();
    });

    var table = $("#data-table");

    table.on('click', ".edit", function () {
        var id = $(this).attr('authId');
        $('#modifyAuthModel').load(path + "/web/auth/editAuth?id="+id);

        $('#modifyAuthModel').modal();
    });

    table.on('click', ".delete", function () {
    	var id = $(this).attr('authId');
    	$('#authId').val(id);
    	$('#delcfmModel').modal();
    });

    $("#imsuer").click(function () {
    	var authId=$("#authId").val();
   	 	$.ajax({
            type: "get",
            url: path + "/web/auth/deleteSysAuthById?id=" + authId,
            format: "json",
            success: function (data) {
                if (data.code != "200") {
               	 	alert(data.errorMessage);
                } else {
                	var authname = $("#authname").val();
	       	         var authurl = $("#authurl").val();

	       	         var curPage = $("#pageInput").val();
	       	         if (!curPage) {
	       	        	 curPage = 1;
	       	         }
	       	         //pageSize标签存在于page.js中
	       	         var pageSize = $("#pageSize").val();
	       	         if(!pageSize) {
	       	         	pageSize = 15;
	       	         }
	       	      authListPaging = new PageView({
	       	             pageContainer: $("#authListPaging"),
	       	             pageListContainer: $("#data-table"),
	       	             pageViewName: 'authListPaging',
	       	             url: path + "/web/auth/selectSysAuthList",
	       	             curPageName: 'currentPage',//currentPage当前页码，传入后台的key值
	       	             pageSize: pageSize,
	       	             curPage: curPage,
	       	             urlRequestData: {
	       	                 "authurl": authurl,
	       	                 "authname":authname
	       	             }
	       	         });
                }
            }
        });
    });

    $("#search-button").click(function () {
        var authname = $("#authname").val();
        var authurl = $("#authurl").val();

        //pageSize标签存在于page.js中
        var pageSize = $("#pageSize").val();
        if(!pageSize) {
        	pageSize = 15;
        }
        authListPaging = new PageView({
            pageContainer: $("#authListPaging"),
            pageListContainer: $("#data-table"),
            pageViewName: 'authListPaging',
            url: path + "/web/auth/selectSysAuthList",
            curPageName: 'currentPage',
            pageSize: pageSize,
            urlRequestData: {
                "authurl": authurl,
                "authname":authname
            }
        });
    });

});