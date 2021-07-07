$(document).ready(function(){
		//站点信息	
		$('#stationForm').ajaxForm({
            beforeSubmit:  checkStationForm,  // pre-submit callback
            success:       stationComplete,   // post-submit callback
            dataType: 'json'
        });
        function checkStationForm(){
        	if( '' == $.trim($('#station_name').val())){
                $('#result').html('站点名称不能为空').show();
                return false;
            }
            if( '' == $.trim($('#station_code').val())){
                $('#result').html('站点code不能为空').show();
                return false;
            }
            
            //可以在此添加其它判断
        }
        function stationComplete(data){
            $('#result').html(data.info).show();
            if (data.status==1){
                $('#station_code').val('');
           		$('#station_name').val('');
            }
           
        }
		
		//频道信息
		$('#channelForm').ajaxForm({
         // beforeSubmit:  checkChannelForm,  // pre-submit callback
            success:       channelComplete,   // post-submit callback
            dataType: 'json'
        });
        
        $('#mchannelForm').ajaxForm({
           //beforeSubmit:  checkChannelForm,  // pre-submit callback
            success:       mchannelComplete,   // post-submit callback
            dataType: 'json'
        });
        
        
        function checkChannelForm(){
        	if( '' == $.trim($('#channel_name').val())){
                $('#channel_result').html('频道名称不能为空').show();
                return false;
            }
            if( '' == $.trim($('#channel_code').val())){
                $('#channel_result').html('频道code不能为空').show();
                return false;
            }
            
            //可以在此添加其它判断
        }
        
        function channelComplete(data){
            $('#ichannel_result').html(data.info).show();
            if (data.status==1){
            	$('#channel_name').val('');
            	$('#channel_code').val('');
            }
        }
        
        
        function mchannelComplete(data){
            $('#mchannel_result').html(data.info).show();
            if (data.status==1){
            	$('#channel_name').val('');
            	$('#channel_code').val('');
            }
        }
        
        
        
        
        //面包屑
        $('#breadcrumbForm').ajaxForm({
            //beforeSubmit:  checkTagForm,  	// pre-submit callback
            success:       tagComplete,  	 // post-submit callback
            dataType: 'json'
        });
        
        $('#mbreadcrumbForm').ajaxForm({
            success:       mtagComplete,  	 // post-submit callback
            dataType: 'json'
        });
        
        
        //检查表单项目
        function checkTagForm(){
        	
    		if( '' == $.trim($('#tag_name').val())){
                $('#breadcrumb_result').html('面包屑名称不能为空').show();
                return false;
       		}
            if( '' == $.trim($('#tag_code').val())){
                $('#breadcrumb_result').html('面包屑code不能为空').show();
                return false;
            }
	    }
	    
	    function tagComplete(data){
            $('#breadcrumb_result').html(data.info).show();
            if (data.status==1){
               $('#tag_name').val('');
           	   $('#tag_code').val(''); 
            }
        }
        function mtagComplete(data){
            $('#mbreadcrumb_result').html(data.info).show();
            if (data.status==1){
               $('#tag_name').val('');
           	   $('#tag_code').val(''); 
            }
        }
        
    });
