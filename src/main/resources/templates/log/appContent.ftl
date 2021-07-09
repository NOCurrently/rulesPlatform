<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>oyo-cms</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="format-detection" content="telephone=no">
    <meta name="renderer" content="webkit">

    <link rel="stylesheet" href="${base}/static/amazeui/css/amazeui.min.css"/>
    <link rel="stylesheet" href="${base}/static/css/messenger.css"/>
    <link rel="stylesheet" href="${base}/static/css/index.css"/>
    
	<link href="${base}/static/css/modify-password.css" type="text/css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css">
</head>

<body>
<input type="hidden" id="path" value="${base}"/>
<div  class="header clearfix" style="background-color:#ffffff;color:#000000">
    <div class="console" style="background-color:#ffffff;color:#000000">
        <div class="sidebar" style="background-color:#ffffff;color:#000000;top: -45px;">
            <div class="sidebar-box-wrap" style="background-color:#ffffff;color:#000000">
                <div class="sidebar-box" style="background-color:#ffffff;color:#000000;">
                	<#list treeMenu as child>
                		<dl class="nav nav-sidebar" style="background-color:#ffffff;color:#000000;">
	                        <dt style="background-color:#ffffff;"><i></i><em style="background-color:#ffffff;color:#000000" title="${child.name}">${child.name}</em><b></b></dt>
	                        <dd style="background-color:#ffffff;color:#000000">
	                        	<#list child.menuList as sysAuth>
	                        		<a data-id="${sysAuth.id}" href="#" data="${base}${sysAuth.url}" style="color:#000000">
	                        		<i class="${sysAuth.icon}"></i>
	                        		<span style="color:#000000">${sysAuth.name}</span>
	                        		</a>
	                        	</#list>
	                        </dd>
                    	</dl>
				    </#list>
                </div>
                <div class="sidebar-box-scroll" style="background-color:#ffffff;color:#000000">
                    <div class="sidebar-box-thumb" style="background-color:#ffffff;color:#000000"></div>
                </div>
            </div>
        </div>
        <div class="main">
            <ul id="myTab" class="am-nav am-nav-tabs" style="font-size: 12px;">
            </ul>
            <div id="myTabContent" class="tab-content">
            </div>
        </div>
    </div>
</div>
 
<div class="modal fade" id="myModal">  
  <div class="modal-dialog">  
    <div class="modal-content message_align">  
      <div class="modal-header" style="text-align:center">  
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>  
        <h3 class="modal-title">提示信息</h3>  
      </div>  
      <div class="modal-body" style="text-align:center">  
        <p>无法关闭最后一个标签页!</p>  
      </div>  
    </div><!-- /.modal-content -->  
  </div><!-- /.modal-dialog -->  
</div><!-- /.modal -->  

<!-- Small modal -->  
<div class="modal fade" id="maxDialog">  
  <div class="modal-dialog">  
    <div class="modal-content message_align">  
      <div class="modal-header" style="text-align:center">  
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>  
        <h3 class="modal-title">提示信息</h3>  
      </div>  
      <div class="modal-body" style="text-align:center">  
        <p>最多打开20个标签页!</p>  
      </div>  
    </div><!-- /.modal-content -->  
  </div><!-- /.modal-dialog -->  
</div><!-- /.modal -->

<div class="modal fade" id="modify-password" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

</div>

<div id="contextmenu-mask"></div>
<ul id="contextmenu" class="dropdown-menu">
    <!--<li class="JS_open_new_tab"><a>新标签页打开</a></li>-->
    <li class="JS_refresh_tab"><a>刷新标签页</a></li>
    <li role="presentation" class="divider"></li>
    <li class="JS_close_other_tab"><a>关闭其他标签页</a></li>
</ul>
<script type="text/javascript" src="${base}/static/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="${base}/static/amazeui/js/amazeui.min.js"></script>
<script type="text/javascript" src="${base}/static/js/messenger.min.js"></script>
<script type="text/javascript" src="${base}/static/js/test.js"></script>

<script src="${base}/static/bounced/js/jquery.form.js"></script> 
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script> 
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</body>
</html>
