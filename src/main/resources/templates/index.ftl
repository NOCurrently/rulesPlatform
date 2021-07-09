<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>内容投放管理平台</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="format-detection" content="telephone=no">
    <meta name="renderer" content="webkit">

    <link rel="stylesheet" href="/amazeui/css/amazeui.min.css"/>
    <link rel="stylesheet" href="/css/messenger.css"/>
    <link rel="stylesheet" href="/css/index.css"/>

    <link href="/css/modify-password.css" type="text/css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/bounced/bootstrap/3.0.3/css/bootstrap.min.css">
</head>

<body>
<input type="hidden" id="path" value="${base}"/>
<div class="header clearfix">
    <div class="left clearfix">
        <a class="logo"><i style="background:url('/img/logo.png')"></i><em>内容投放管理平台</em></a>
    </div>
    <div style="float:right;">
        <div class="header-dropdown">
            <a class="header-dropdown-toggle">
                <strong></strong><em>${ssoUser.name}</em><i></i>
            </a>
            <ul class="header-dropdown-menu">
                <li><a class="my-pwd toEditPassword" href="javascript:void(0)"><i class="glyphicon glyphicon-edit"></i><em>修改密码</em></a></li>
                <li><a class="my-pwd" href="${base}/web/logout"><i class="glyphicon glyphicon-off"></i><em>退出</em></a></li>
            </ul>
        </div>
    </div>
</div>

<div>
    <div class="console">
        <div class="sidebar">
            <div class="shrink" title="固定"><i></i></div>
            <div class="sidebar-box-wrap">
                <div class="sidebar-box">
                    <#list resourceTrees as firtLevel>
                        <dl class="nav nav-sidebar">
                            <dt><i class="${firtLevel.icon}"></i><em title="${firtLevel.name}">${firtLevel.name}</em><b></b></dt>
                            <dd>
                                <#list firtLevel.treeList as secondLevel>
                                    <a data-id="${secondLevel.id}" href="#"
                                       data="<#if secondLevel.url?? &&secondLevel.url?index_of('http://')==-1> ${base}</#if>${secondLevel.url}"><i
                                                class="${secondLevel.icon}"></i><span>${secondLevel.name}</span></a>
                                </#list>
                            </dd>
                        </dl>
                    </#list>
                </div>
                <div class="sidebar-box-scroll">
                    <div class="sidebar-box-thumb"></div>
                </div>
            </div>
        </div>
        <div class="main">
            <ul id="myTab" class="am-nav am-nav-tabs" style="font-size: 12px;">
                <li role="presentation" class="am-active" data-id="0">
                    <a><span>欢迎页</span> &nbsp;<button type="button" class="am-close">&times;</button>
                    </a>
                </li>
            </ul>
            <div id="myTabContent" class="tab-content">
                <div role="tabpanel" class="tab-pane active">
                    <div class="am-container" style="min-height: 800px">
                        <div class="jumbotron">
                            <h2>欢迎来到OYO内容投放管理平台</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header" style="text-align:center">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h3 class="modal-title">提示信息</h3>
            </div>
            <div class="modal-body" style="text-align:center">
                <p>无法关闭最后一个标签页!</p>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- Small modal -->
<div class="modal fade" id="maxDialog">
    <div class="modal-dialog">
        <div class="modal-content message_align">
            <div class="modal-header" style="text-align:center">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                <h3 class="modal-title">提示信息</h3>
            </div>
            <div class="modal-body" style="text-align:center">
                <p>最多打开20个标签页!</p>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div class="modal fade" id="modify-password" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

</div>

<div id="contextmenu-mask"></div>
<ul id="contextmenu" class="dropdown-menu">
    <!--<li class="JS_open_new_tab"><a>新标签页打开</a></li>-->
    <li class="JS_refresh_tab"><a>刷新标签页</a></li>
    <li role="presentation" class="divider"></li>
    <li class="JS_close_other_tab"><a>关闭其他标签页</a></li>
</ul>
<script type="text/javascript" src="/js/jquery-3.1.1.min.js"></script>
<script type="text/javascript" src="/amazeui/js/amazeui.min.js"></script>
<script type="text/javascript" src="/js/messenger.min.js"></script>
<script type="text/javascript" src="/js/index.js"></script>

<script src="/bounced/js/jquery.form.js"></script>
<script src="/bounced/js/checkForm.js" type="text/javascript"></script>
<script src="/bounced/bootstrap/3.0.3/js/bootstrap.min.js"></script>
</body>
</html>
