<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 2%;">选择</th>
        <th nowrap="nowrap" style="width: 50%;"> key</th>
        <th nowrap="nowrap" style="width: 30%;"> 操作</th>
    </tr>
    </thead>
    <#if message?? >
       <div class="alert alert-danger" >${message}</div>
    </#if>

    <tbody>
    <#if cacheList?? >
    <#list cacheList as key>
	    <tr class="clean_${key}">
	       <td><input value="${key}"  name="cache" type='checkbox'/></td>
	        <td>${key}</td>
	        <td>
	            <a class="am-btn am-btn-xs am-btn-primary delete btn-danger" href="javascript:void(0)" cleanKey = "${key}">清除缓存</a>
	            <a class="am-btn am-btn-xs am-btn-primary observed btn-info" href="javascript:void(0)" cleanKey = "${key}">查看</a>
	        
	        </td>
	    </tr>
    </#list>
        </#if>
    
    </tbody>
</table>
<script type="text/javascript" src="${base}/static/js/layer.js"></script>
<script type="text/javascript" src="${base}/static/js/td-hover.js"></script>