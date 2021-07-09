<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
    <thead>
	    <tr>
	        <th nowrap="nowrap" style="width: 5%;">日志id</th>
	        <th nowrap="nowrap" style="width: 5%;">操作类型</th>
	        <th nowrap="nowrap" style="width: 5%;">操作者id</th>
	        <th nowrap="nowrap" style="width: 6%;">操作者姓名</th>
	        <th nowrap="nowrap" style="width: 5%;">ip</th>
	        <th nowrap="nowrap" style="width: 10%;">操作URL</th>
	        <th nowrap="nowrap" style="width: 15%;">操作内容</th>
	        <th nowrap="nowrap" style="width: 8%;">创建时间</th>
	    </tr>
	    </thead>
	    <tbody>
    <#list sysLogList.list as log>
	    <tr class = "log_${log.id}">
	            <td>${log.id}</td>
	            <td>${log.type}</td>
		        <td>${log.userId}</td>
		        <td>${log.userName}</td>
		        <td>${log.ip}</td>
		        <td>${log.url}</td>
		        <td title="${log.objectContent}">${log.objectContent}</td>
		        <td>${(log.createTime?string("yyyy-MM-dd HH:mm:ss"))!}</td>
		    </tr>
    </#list>
    </tbody>
</table>
<input id="totalCount" value="${sysLogList.total}" type="hidden"/>
