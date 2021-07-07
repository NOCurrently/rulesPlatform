<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact am-table-centered">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 8%;">ID</th>
        <th nowrap="nowrap" >表单code</th>
        <th nowrap="nowrap" >标题</th>
        <th nowrap="nowrap" >模版路径</th>
        <th nowrap="nowrap" >数据编码</th>
        <th nowrap="nowrap" style="width: 8%;">优先级</th>
        <th nowrap="nowrap" style="width: 8%;">备注</th>
        <th nowrap="nowrap" style="width: 8%;">状态</th>
        <th nowrap="nowrap" style="width: 13%;">操作</th>
    </tr>
    </thead>

    <tbody>
    <#if pageInfo?? && pageInfo.list??>
    <#list pageInfo.list as ad>
        <tr class="auth_${ad.id}">
            <td>${ad.id!}</td>
            <td>${ad.templateCode!}</td>
            <td>${ad.title!}</td>
            <td>${ad.templateUrl!}</td>
            <td><#if ad.code?? && ad.code != "">${ad.code!}<#else>无</#if></td>
            <td>${ad.priority!}</td>
            <td>${ad.remarks!}</td>
            <td><#if ad.status?? && ad.status == 1>开<#else>关</#if></td>
            <td>
                <a class="am-btn am-btn-xs am-btn-primary edit_template btn-info" href="javascript:void(0)" templateCode="${ad.templateCode!}">编辑</a>
                <a class="am-btn am-btn-xs am-btn-primary delete_template btn-danger" href="javascript:void(0)" id="${ad.id!}">删除</a>
                <a class="am-btn am-btn-xs am-btn-primary changeStatus_template btn-danger" href="javascript:void(0)"
                   templateId="${ad.id!}" templateStatusFlag="${ad.status!}" >
                    <#if ad.status?? && ad.status == 1>关<#else>开</#if>
                </a>
            </td>
        </tr>
    </#list>
   
    </tbody>
</table>
<input id="totalCount" value="${pageInfo.total!}" type="hidden"/>
 </#if>
<script type="text/javascript" src="${base}/static/js/layer.js"></script>
<script type="text/javascript" src="${base}/static/js/td-hover.js"></script>


