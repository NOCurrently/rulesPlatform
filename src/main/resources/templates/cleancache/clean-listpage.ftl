<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 15%;"> key</th>
        <th nowrap="nowrap" style="width: 30%;"> 操作</th>
    </tr>
    </thead>

    <tbody>
    <#list cleanCacheList as cleanCache>
	    <tr class="clean_${cleanCache}">
	        <td>${cleanCache}</td>
	        <td>
	            <a class="am-btn am-btn-xs am-btn-primary delete btn-danger" href="javascript:void(0)" cleanKey = "${cleanCache}">清除缓存</a>
	        </td>
	    </tr>
    </#list>
    </tbody>
</table>