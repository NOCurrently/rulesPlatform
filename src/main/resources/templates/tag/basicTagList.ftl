<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact am-table-centered">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 5%;">ID</th>
        <th nowrap="nowrap" style="width: 10%;">标签code</th>
        <th nowrap="nowrap" style="width: 5%;">标签名称</th>
        <th nowrap="nowrap" style="width: 5%;">同步标签分类</th>
        <th nowrap="nowrap" style="width: 5%;">同步标签实时标识</th>
        <th nowrap="nowrap" style="width: 5%;">数据来源</th>
        <th nowrap="nowrap" style="width: 5%;">状态</th>
        <th nowrap="nowrap" style="width: 5%;">操作</th>
    </tr>
    </thead>

    <tbody>
    <#if pageInfo?? && pageInfo.list??>
    <#list pageInfo.list as ad>
        <tr class="auth_${ad.id}">
            <td>${ad.id!}</td>
            <td>${ad.tagCode!}</td>
            <td>${ad.tagName!}</td>
            <td><#if ad.syncFlag?? &&ad.syncFlag!=0>${ad.tagCategory!}</#if></td>
            <td><#if ad.syncFlag?? &&ad.syncFlag!=0>${ad.tagType!}</#if></td>
            <td><#if ad.syncFlag?? &&ad.syncFlag==0>自建<#else>同步</#if></td>
            <td> <#if ad.status?? && ad.status == 1>开<#else>关</#if></td>
            <td>
                <a class="am-btn am-btn-xs am-btn-primary edit_tag btn-info" href="javascript:void(0)" tagPoolId="${ad.id!}">编辑</a>
                <a class="am-btn am-btn-xs am-btn-primary delete_tag btn-danger" href="javascript:void(0)" tagPoolId="${ad.id!}">删除</a>
            </td>
        </tr>
    </#list>
   
    </tbody>
</table>
<input id="totalCount" value="${pageInfo.total!}" type="hidden"/>
 </#if>
<script type="text/javascript" src="${base}/static/js/layer.js"></script>
<script type="text/javascript" src="${base}/static/js/td-hover.js"></script>


