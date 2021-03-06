<#macro paginate currentPage totalPage actionUrl totalCount=0 urlParams=""  >
  <#if (totalPage <= 0) || (currentPage > totalPage)><#return></#if>
  <#local startPage = currentPage - 2>
  <#if (startPage < 1)><#local startPage = 1></#if>
  <#local endPage = currentPage + 2>
  <#if (endPage > totalPage)><#local endPage = totalPage></#if>
<div class="box-footer clearfix">
  <div class="row">
    <div class="col-sm-12">
      <div class="col-sm-5">
        <#if (totalCount>0)>
          <div>共 ${totalCount} 条</div>
        </#if>
      </div>
      <div class="col-sm-7">
        <ul class="pagination pagination-sm no-margin pull-right <#if totalPage == 1>hidden-xs hidden-sm hidden-md hidden-lg</#if>">
          <#if (currentPage <= 3)>
            <#local startPage = 1>
          </#if>
          <#if ((totalPage - currentPage) < 2)>
            <#local endPage = totalPage>
          </#if>
          <#if (currentPage == 1)>
            <!--<li>上页</li>-->
          <#else>
            <li><a href="${actionUrl}?pageNo=1${urlParams!}">&lt;&lt;</a></li>
            <li><a href="${actionUrl}?pageNo=#{currentPage - 1}${urlParams!}">&lt;</a></li>
          </#if>
          <#list startPage..endPage as i>
            <#if currentPage == i>
              <li class="active"><a class="disabled">#{i}</a></li>
            <#else>
              <li><a href="${actionUrl}?pageNo=#{i}${urlParams!}">#{i}</a></li>
            </#if>
          </#list>
          <#if (currentPage == totalPage)>
            <!--<li>下页</li>-->
          <#else>
            <li><a href="${actionUrl}?pageNo=#{currentPage + 1}${urlParams!}">&gt;</a></li>
            <li><a href="${actionUrl}?pageNo=#{totalPage}${urlParams!}">&gt;&gt;</a></li>
          </#if>
        </ul>
      </div>
    </div>
  </div>
</div>
</#macro>