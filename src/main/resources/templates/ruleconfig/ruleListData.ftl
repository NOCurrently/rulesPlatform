<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 5%;">ID</th>
        <th nowrap="nowrap">编码</th>
        <th nowrap="nowrap">编码名称</th>
        <th nowrap="nowrap" style="width: 7%;">最少文案数</th>
        <th nowrap="nowrap" style="width: 7%;">最多文案数</th>
        <th nowrap="nowrap" style="width: 7%;">最少图片数</th>
        <th nowrap="nowrap" style="width: 7%;">最多图片数</th>
        <th nowrap="nowrap" >编码类别</th>
        <th nowrap="nowrap" >编码类别名称</th>
        <th nowrap="nowrap" style="width: 11%;">创建时间</th>
        <th nowrap="nowrap" style="width: 5%;">状态</th>
        <th nowrap="nowrap" style="width: 9%;">操作</th>
    </tr>
    </thead>
    <tbody>
    <#if datas?? && datas.list??>
        <#list datas.list as info>
            <tr class="info_${info.id}">
                <td>${info.id!}</td>
                <td>${info.code!}</td>
                <td>${info.name!}</td>
                <td><#if info.minContent?? && info.minContent == 0>无限制<#else>${info.minContent!}</#if></td>
                <td><#if info.maxContent?? && info.maxContent == 0>无限制<#else>${info.maxContent!}</#if></td>
                <td><#if info.minImg?? && info.minImg == 0>无限制<#else>${info.minImg!}</#if></td>
                <td><#if info.maxImg?? && info.maxImg == 0>无限制<#else>${info.maxImg!}</#if></td>
                <td>${info.typeCode!}</td>
                <td>${info.typeName!}</td>

                <td>${(info.createTime?string("yyyy-MM-dd HH:mm:ss"))!}</td>
                <td><#if info.status?? && info.status == 1>开<#else>关</#if></td>
                <td>
                    <a class="am-btn am-btn-xs am-btn-primary edit btn-info" href="javascript:void(0)" ruleId="${info.id!}">编辑</a>
                    <#--<a class="am-btn am-btn-xs am-btn-primary deleteRule btn-danger" href="javascript:void(0)"
                       ruleId="${info.id!}">删除</a>-->
                    <a class="am-btn am-btn-xs am-btn-primary changeRuleStatus btn-danger" href="javascript:void(0)"
                       ruleId="${info.id!}" ruleStatus="${info.status!}"><#if info.status?? && info.status == 1>关<#else>开</#if>
                    </a>
                </td>
            </tr>
        </#list>
    </#if>
    </tbody>
</table>
<input id="totalCount" value="${datas.total!}" type="hidden"/>
<script type="text/javascript" src="${base}/static/js/layer.js"></script>
<script type="text/javascript" src="${base}/static/js/td-hover.js"></script>