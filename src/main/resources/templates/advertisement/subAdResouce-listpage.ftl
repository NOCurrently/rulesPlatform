<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-compact am-table-centered">
    <thead>
    <tr>
        <th nowrap="nowrap" style="width: 5%;">唯一标识（KEY）</th>
        <th nowrap="nowrap" style="width: 10%;">位置</th>
        <th nowrap="nowrap" style="width: 5%;">资源类型</th>
        <th nowrap="nowrap" style="width: 5%;">尺寸/长（cm）</th>
        <th nowrap="nowrap" style="width: 5%;">尺寸/宽（cm）</th>
        <th nowrap="nowrap" style="width: 5%;">使用情况</th>
        <th nowrap="nowrap" style="width: 5%;">图片</th>
        <th nowrap="nowrap" style="width: 5%;">填报人</th>
        <th nowrap="nowrap" style="width: 5%;">更新时间</th>
    </tr>
    </thead>

    <tbody>
    <#list pageInfo.list as ad>
        <tr class="auth_${ad.id}">
            <td>${ad.id!}</td>
            <td>${ad.locationName!}</td>
            <td>${ad.typeName!}</td>
            <td>${ad.length!}</td>
            <td>${ad.width!}</td>
            <td>${ad.adStatusName!}</td>
            <td title="${ad.imgUrl!}">
                <img id="imgUrlClick" src="${ad.imgUrl!}" height="50" width="50" onclick="openImage('${ad.imgUrl!}')" />
            </td>
            <td>${ad.updateBy!}</td>
            <td>${ad.updateTime?string('yyyy-MM-dd HH:mm:ss')}</td>
        </tr>
    </#list>
    </tbody>
</table>
<input id="totalCount" value="${pageInfo.total!}" type="hidden"/>
<script type="text/javascript" src="${base}/static/js/layer.js"></script>
<script type="text/javascript" src="${base}/static/js/td-hover.js"></script>


