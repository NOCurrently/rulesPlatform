<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${base}/static/amazeui/css/amazeui.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/css/user/user-list.css">
    <link type="text/css" rel="stylesheet" href="${base}/static/css/page.css">
    <link rel="stylesheet" type="text/css" href="${base}/static/bounced/bootstrap/3.0.3/css/bootstrap.min.css?v=111111">
</head>
<body>
<input type="hidden" id="path" value="${base}"/>
    

<div class="am-form-inline" id="search-box">
<form id="r_searchForm" method="post">
	<div>
	选择广告位类型:
	  	<#list dictType as type>
			<input type="checkbox" checked="true" name="${type.name!}"  value='${type.id!}'/>${type.lableName!} &emsp;
		 </#list>
	 </div>
	 <br/>
	 <div>
	 资源使用情况:
	  	<select id="status" name="statusId">
	  	<#list adStatus as statu>
			<option value='${statu.id!}'>${statu.name!}</option>
		 </#list>
        </select>
                <a class="am-btn am-btn-primary" id="search-buttonss">执行</a>
        
	 </div>
</form>
</div>
<div id="data-table">
</div>

<script type="text/javascript" src="${base}/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${base}/static/js/page.js"></script>
<script src="${base}/static/bounced/js/jquery.form.js"></script>
<script src="${base}/static/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="${base}/static/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
<script src="${base}/static/js/report/report.js"></script>
</body>
</html>