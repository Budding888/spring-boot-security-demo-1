<#include "../../layout/layout.ftl">
<@html page_title="用户列表" page_tab="user_list">
<section class="content-header">
  <h1>
    用户
    <small>列表</small>
  </h1>
  <ol class="breadcrumb">
    <li><a href="/admin/dashboard"><i class="fa fa-dashboard"></i> 首页</a></li>
    <li class="active"> 用户</li>
  </ol>
</section>
<div class="content">
  <div class="row">
    <div class="col-md-12">
      <div class="box">
        <div class="box-header with-border">
          <h3 class="box-title">用户列表</h3>
          <#if sec.allGranted("admin_user:add")>
            <a class="btn btn-primary btn-xs pull-right" href="/admin/admin_user/add">添加</a>
          </#if>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
          <table class="table table-bordered">
            <tbody>
            <tr>
              <th>#</th>
              <th>用户名</th>
              <th>注册时间</th>
              <th>状态</th>
              <th>操作</th>
            </tr>
              <#list page.content as adminUser>
              <tr>
                <td>${adminUser.id?c}</td>
                <td>${adminUser.username!}</td>
                <td>${adminUser.inTime?datetime}</td>
                <td>
                  <#if adminUser.block>
                    <span class="text-danger">禁</span>
                  <#else>
                    <span class="text-success">正常</span>
                  </#if>
                </td>
                <td>
                  <#if adminUser.block>
                    <#if sec.allGranted("admin_user:block")>
                      <a class="btn btn-success btn-xs" id="unblock"
                         href="javascript:if(confirm('确定要解这个用户吗？'))location.href='/admin/admin_user/unblock?id=${adminUser.id?c}'">解</a>
                    </#if>
                  <#else>
                    <#if sec.allGranted("admin_user:unblock")>
                      <a class="btn btn-danger btn-xs" id="block"
                         href="javascript:if(confirm('确定要禁这个用户吗？'))location.href='/admin/admin_user/block?id=${adminUser.id?c}'">禁</a>
                    </#if>
                  </#if>
                  <#if sec.allGranted("admin_user:edit")>
                    <a class="btn btn-warning btn-xs" href="/admin/admin_user/edit?id=${adminUser.id?c}">编辑</a>
                  </#if>
                  <#if sec.allGranted("admin_user:delete")>
                    <a class="btn btn-danger btn-xs"
                       href="javascript:if(confirm('确定要删除这个用户吗？'))location.href='/admin/admin_user/delete?id=${adminUser.id?c}'">删除</a>
                  </#if>
                </td>
              </tr>
              </#list>
            </tbody>
          </table>
        </div>
        <!-- /.box-body -->
        <#include "../../layout/paginate.ftl"/>
        <@paginate currentPage=page.getNumber() + 1 totalPage=page.getTotalPages() totalCount=page.getTotalElements() actionUrl="/admin/admin_user/list" urlParams=""/>
      </div>
    </div>
  </div>
</div>
</@html>