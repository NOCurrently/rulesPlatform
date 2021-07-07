<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 5%;">日志id</th>
        <th nowrap="nowrap" style="width: 5%;">操作类型</th>
        <th nowrap="nowrap" style="width: 10%;">用户名</th>
        <th nowrap="nowrap" style="width: 20%;">操作URL</th>
        <th nowrap="nowrap" style="width: 10%;">创建时间</th>
        <th nowrap="nowrap" style="width: 8%;">表名</th>
        <th nowrap="nowrap" style="width: 5%;">数据id</th>
        <th nowrap="nowrap" style="width: 20%;">数据</th>
    </tr>
    </thead>
    <tbody>
    <#if logDatas.list??>
    <#list logDatas.list as log>
    <tr class="log_${log.id}">
        <td>${log.id!}</td>
        <td>
            <#if log.type??>
                <#if log.type == 1>添加
                <#elseif log.type == 2>修改
                <#elseif log.type == 3>删除
                <#elseif log.type == 4>添加/修改
                <#elseif log.type == 5>修改/删除
                <#else>${log.type!}
                </#if>
            </#if>
        </td>
        <td>${log.username!}</td>
        <td>${log.url!}</td>
        <td>${(log.createTime?string("yyyy-MM-dd HH:mm:ss"))!}</td>
        <td>${log.table!}</td>
        <td>${log.tableId!}</td>
        <td>${log.operationData!}</td>
    </tr>
    </#list>
    </#if>
    </tbody>
</table>
<input id="totalCount" value="${logDatas.total!}" type="hidden"/>
<script type="text/javascript" src="${base}/static/js/layer.js"></script>
<script type="text/javascript" src="${base}/static/js/td-hover.js"></script>

