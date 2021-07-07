/**
 * Created by Administrator on 2018/7/26.
 */
//提交数据
//提交数据
$(function () {
	var path = $("#path").val();
	$("#authUpdateBtn").bind("click",function(){
		if(!$("#editname").val()) {
			 $('#m_auth_result').html("资源名称不能为空").show();
			 return false;
		} else if(!$("#editcode").val()) {
			$('#m_auth_result').html("资源编码不能为空").show();
			 return false;
		} else if(!$("#editurl").val()) {
			$('#m_auth_result').html("资源请求路径不能为空").show();
			 return false;
		}
	     $(this).attr('disabled', 'disabled');
		 $('#m_authForm').ajaxForm({
			 dataType: 'json',
            success: function (data) {
            	 authComplete(data); 
    			 $("#authUpdateBtn").removeAttr('disabled');
            },  
			 error: function (e) {
    			 $("#authUpdateBtn").removeAttr('disabled');
	         }
	     }).submit();
		return true;
	});
		
	//提交成功后
	function authComplete(data){
	    if (data.code == '200'){
	    	//关闭当前窗口
	    	 $("#modifyAuthModel").modal('hide');
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
	         authPage = new PageView({
	             pageContainer: $("#authListPaging"),
	             pageListContainer: $("#data-table"),
	             pageViewName: 'authPage',
	             url: path + "/web/auth/selectSysAuthList",
	             curPageName: 'currentPage',//currentPage当前页码，传入后台的key值
	             pageSize: pageSize,
	             curPage: curPage,
	             urlRequestData: {
	                 "authurl": authurl,
	                 "authname":authname
	             }
	         });
	    } else {
	    	$('#m_auth_result').html(data.errorMessage).show();
	    }
	}
	  	  
	$(function(){
		  
		  // 如果是菜单，隐藏
		  if($("#edittype").val() == "oneLevel"){
			  $("#oneLevelModify").css("display","none");
		  	  $("#firstModify").css("display","none");
		  	  $("#editpid").val("");
		  	  $("#pidt").val("");
		  } else {
			  $("#oneLevelModify").css("display","block");
		  	  $("#firstModify").css("display","block");
		  }
		  
		  $("#edittype").change(function(){
			  var type = $("#edittype").val();
			  switch (type){
		          case "oneLevel":
		              $("#oneLevelModify").css("display","none");
		          	  $("#firstModify").css("display","none");
		          	  $("#editpid").val("");
		          	  $("#pidt").val("");
		              break;
		          case "url":
		        	  $("#oneLevelModify").css("display","block");
		  	  	  	  $("#firstModify").css("display","block");
		              break;
		      }
		  });
		  
		  $("#oneLevel").css("display","none");
		  $("#first").css("display","none");
	});
});