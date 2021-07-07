<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact am-table-centered">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 5%;">酒店ID</th>
        <th nowrap="nowrap" style="width: 10%;">酒店名称</th>
        <th nowrap="nowrap" style="width: 3%;">市</th>
        <th nowrap="nowrap" style="width: 20%;">地址</th>
        <th nowrap="nowrap" style="width: 5%;">资源总数</th>
        <th nowrap="nowrap" style="width: 5%;">可用广告位总数</th>
        <th nowrap="nowrap" style="width: 5%;">潜在广告位总数</th>
        <th nowrap="nowrap" style="width: 5%;">操作</th>
    </tr>
    </thead>

    <tbody>
    <#list pageInfo.list as advertisement>
        <tr class="auth_${advertisement.id}">
            <td>${advertisement.id!}</td>
            <td>${advertisement.name!}</td>
            <td>${advertisement.cname!}</td>
            <td>${advertisement.street!}</td>
            <td>${advertisement.adStatusNum!}</td>
            <td>${advertisement.onAdStatusNum!}</td>
            <td>${advertisement.offAdStatusNum!}</td>
            <td>
                <a class="am-btn am-btn-xs am-btn-primary edit btn-info" href="javascript:void(0)" hotelId="${advertisement.id}">查看</a>
            </td>
        </tr>
    </#list>
    </tbody>
</table>
<input id="totalCount" value="${pageInfo.total!}" type="hidden"/>
<script type="text/javascript" src="${base}/static/js/layer.js"></script>
<script type="text/javascript" src="${base}/static/js/td-hover.js"></script>


