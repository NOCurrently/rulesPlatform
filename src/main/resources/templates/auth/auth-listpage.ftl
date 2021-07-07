<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 10%;">资源名称</th>
        <th nowrap="nowrap" style="width: 5%;">资源编码</th>
        <th nowrap="nowrap" style="width: 10%;">资源url</th>
        <th nowrap="nowrap" style="width: 5%;">排序</th>
        <th nowrap="nowrap" style="width: 5%;">状态</th>
        <th nowrap="nowrap" style="width: 10%;">操作</th>
    </tr>
    </thead>

    <tbody>
    <#list pageInfo.list as auth>
	    <tr class="auth_${auth.id}">
	        <td>${auth.name!}</td>
	        <td>${auth.code!}</td>
	        <td>${auth.url!}</td>
	        <td>${auth.sort!}</td>
	        <#if auth.status == 1>
	            <td>可用</td>
	        <#else>
	            <td>不可用</td>
	        </#if>
	        <td>
	            <a class="am-btn am-btn-xs am-btn-primary edit btn-info" href="javascript:void(0)" authId = "${auth.id}">编辑</a>
                <#--<a class="am-btn am-btn-xs am-btn-primary delete btn-danger" href="javascript:void(0)" authId = "${auth.id}" onClick="delcfm('${base}/sysauth/deleteSysAuth?id=${auth.id}')">删除</a>-->
	        </td>
	    </tr>
    </#list>
    </tbody>
</table>
<input id="totalCount" value="${pageInfo.total!}" type="hidden"/>
<script type="text/javascript" src="${base}/static/js/layer.js"></script>
<script type="text/javascript" src="${base}/static/js/td-hover.js"></script>
