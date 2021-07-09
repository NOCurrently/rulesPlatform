<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${base}/static/amazeui/css/amazeui.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/user/user-list.css">
    <link type="text/css" rel="stylesheet" href="${base}/static/css/page.css" >
    
    <link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css?v=111111">
</head>
<body>
<input type="hidden" id="path" value="${base}"/>
<div class="am-form-inline" id="search-box">
	<span>缓存key：</span>
    <div class="am-form-group">
        <input type="text" class="search-input am-form-field"/>
    </div>
    <button class="am-btn am-btn-primary" id="search-button">搜索</button>
    <button class="am-btn  am-btn-primary" id="clear-btn">清空</button>
    <button class="am-btn  am-btn-primary btn-danger" id="cleancache-button">清除缓存</button>
</div>
<div id="data-table">
</div>

<!-- 信息删除确认 -->  
<div class="modal fade" id="delcfmModel">  
  <div class="modal-dialog">  
    <div class="modal-content message_align">  
      <div class="modal-header">  
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>  
        <h4 class="modal-title">提示信息</h4>  
      </div>  
      <div class="modal-body">  
        <p>您确认要清除缓存吗？</p>  
      </div>  
      <div class="modal-footer">  
         <input type="hidden" id="cleanKey"/>  
         <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>  
         <button type="button" id = "imsuer" class="btn btn-success" data-dismiss="modal">确定</button>
      </div>  
    </div><!-- /.modal-content -->  
  </div><!-- /.modal-dialog -->  
</div><!-- /.modal -->  

<div id="cleanListPaging">
	
</div>

<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>

<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script type="text/javascript" src="${base}/static/js/cleancache/cleancache-list.js"></script>

<script src="${base}/static/bounced/js/jquery.form.js"></script> 
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script> 
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</body>
</html>