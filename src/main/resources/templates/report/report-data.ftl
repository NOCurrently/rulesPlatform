<table class="am-table am-table-bordered am-table-hover am-table-striped am-table-centered am-table-compact">
   
    <thead>
    <tr>
        <th style="width: 15%;"  rowspan="2">Region 大区</th>
        <th   rowspan="2">Active Property (Status FTD) 当天Active状态酒店数</th>
        <th   rowspan="2">Property -Collection Completed.已收集完</th>
        <th   rowspan="2">Completion Rate 完成率</th>
        <#if (num??)&& num != 0>
        	<th   colspan="${num!}">可用广告位和潜在广告位</th>
	    </#if>
    </tr>
     <tr>
        <#if (reportData[0].a)??>
	        <th >A</th>
	        </#if>
	        <#if (reportData[0].b)??>
	        <th >B</th>
	        </#if>
	        <#if (reportData[0].c)??>
	        <th >C</th>
	        </#if>
	        <#if (reportData[0].d)??>
	       <th >D</th>
	        </#if>
	       <#if (reportData[0].e)??>
	       <th >E</th>
	        </#if>
	       <#if (reportData[0].f)??>
	        <th >F</th>
	        </#if>
	       <#if (reportData[0].g)??>
	        <th >G</th>
	        </#if>
	       <#if (reportData[0].h)??>
	      <th >H</th>
	        </#if>
	        
    </tr>
    </thead>

    <tbody>
   
   		 <#list reportData as data>
			 <tr>
	        <td>${data.zoneName!}</td>
	        <td>${data.activeHotel!}</td>
	        <td>${data.completedHotel!}</td>
	        <td>${data.rate*100!}%</td>
	        <#if (data.a)??>
	        <td>${data.a!}</td>
	        </#if>
	        <#if (data.b)??>
	        <td>${data.b!}</td>
	        </#if>
	        <#if (data.c)??>
	        <td>${data.c!}</td>
	        </#if>
	        <#if (data.d)??>
	        <td>${data.d!}</td>
	        </#if>
	       <#if (data.e)??>
	        <td>${data.e!}</td>
	        </#if>
	       <#if (data.f)??>
	        <td>${data.f!}</td>
	        </#if>
	       <#if (data.g)??>
	        <td>${data.g!}</td>
	        </#if>
	       <#if (data.h)??>
	        <td>${data.h!}</td>
	        </#if>
    		 </tr>
		 </#list>
    
   
    </tbody>
    
</table>
<script type="text/javascript" src="${base}/static/js/layer.js"></script>
<script type="text/javascript" src="${base}/static/js/td-hover.js"></script>
