/**
 * Created by zhouy on 2018/08/08.
 */

$(function () {
	
	var path = $("#path").val();
    var $document = $(document);
    var $body = $('body');
    var $main = $(".main");
    var $myTab = $("#myTab");
    var $myTabContent = $("#myTabContent");
    var $window = $(window);
    var $contextmenu = $("#contextmenu");
    var $contextmenumask = $("#contextmenu-mask");


    var $sidebarBoxWrap = $(".sidebar-box-wrap");
    var $sidebarBox = $(".sidebar-box");
    var $sidebarScroll = $(".sidebar-box-scroll");
    var $sidebarThumb = $(".sidebar-box-thumb");

    //个人下拉菜单
    var $headerdropdown = $(".header-dropdown");

    var closeOtherTabsIndex = 0;

    var activeMenu = null;

    var path = $("#path").val();

    function dialogTest() {
        $('#verify').modal();
    }

    Messenger.options = {
        extraClasses: 'messenger-fixed messenger-on-bottom messenger-on-right',
        theme: 'flat'
    };

    //messageTest();
    function messageTest() {
        var msg;

        msg = Messenger().post({
            message: '右下角提醒内容...',
            type: 'info',
            showCloseButton: true,
            id: "Only-one-message",
            actions: {
                cancel: {
                    label: '不再提醒',
                    action: function () {
                        return msg.update({
                            message: '以后不再显示',
                            type: 'success',
                            actions: false,
                            showCloseButton: true
                        });
                    }
                }
            }
        });
    }

    $("#showMessage").on("click", function () {
        messageTest();
    });

    $("#showDialog").on("click", function () {
        dialogTest();
    });

    //$("[data-toggle=tooltip]").tooltip();

    $document.on("click", ".sidebar .shrink", function () {
        var $console = $(".console");
        $console.toggleClass("shrunk");
    });

    $document.on("click", ".sidebar dt", function () {
        var $this = $(this);
        var href = $this.attr('data');
        var action = $this.attr('action');
        var text = $this.text();
        var linkId = $this.attr("data-id");

        var $dl = $this.parent();
        if ($dl.is(".active")) {
            $dl.removeClass("active");
        } else {
            $dl.addClass("active").siblings().removeClass("active");
        }
        if (action == 'firstPage') {
            renderTab(text, href, linkId)
        }
        setScroll();
    });

    function renderTab(text, href, linkId) {

        var $oldLi = $myTab.find("li[data-id=" + linkId + "]");

        if ($oldLi.length > 0) {
            switchTab($oldLi.index())
        } else {

            var size = $myTab.children().length;
            if (size >= 20) {
                $('#maxDialog').modal();
            } else {

                createTab();
                var $tabPaneActive = $myTabContent.find(".tab-pane.active");
                var $tabActive = $myTab.find("li.am-active");

                $tabActive.find("span").text(text);
                $tabActive.attr("data-id", linkId);

                var $iframe = $('<iframe class="iframe" src="' + href + '" frameborder="0"></iframe>');
                $tabPaneActive.html($iframe);
            }


        }
        resize();

    }

    window.renderTab = renderTab;

    $document.on("click", ".nav-sidebar a", function (e) {
        e.preventDefault();

        if (e.which === 1 || e.which === 0) {
            var $this = $(this);
            var href = $this.attr("data");
            var text = $this.text();
            var linkId = $this.attr("data-id");

            setOpened(linkId);

            renderTab(text, href, linkId);
        }

    });

    /**
     * 设置Opened样式
     * @param linkId
     */
    function setOpened(linkId) {
        var $this = $(".nav-sidebar a[data-id=" + linkId + "]");

        $(".nav-sidebar,.nav-sidebar a").removeClass("opened");
        $(".nav-sidebar dl").removeClass("active");
        var $navSidebar = $this.parents(".nav-sidebar");
        var $navSidebarDl = $this.parents("dl").addClass("active");
        $navSidebar.addClass("opened");
        $this.addClass("opened");

    }

    $document.on("mousedown", "#contextmenu-mask", function (e) {
        contextMenuHide()
    });

    function contextMenuHide() {
        $contextmenumask.hide();
        $contextmenu.hide();
    }

    function resize() {
        var windowHeight = $window.height();
        var tabHeight = $myTab.height();
        var topHeight = $(".header").eq(0).height();
        var height = windowHeight - topHeight - tabHeight;
        $myTabContent.height(height);
        var $iframe = $myTabContent.find(".iframe");
        $iframe.height(9999);
        setScroll();
        setTimeout(function () {
            $iframe.height(height);
        }, 1);
    }

    resize();

    $window.on("resize", function () {
        resize();
    });

    $document.on("click", ".JS_close_other_tab", function () {
        contextMenuHide();
        var $lis = $myTab.children("li");

        var $notClose = $myTab.find("li[data-id=" + closeOtherTabsIndex + "]");

        var index = $notClose.index();
        var $notCloseContent = $myTabContent.find(".tab-pane").eq(index);

        $myTab.children("li").not($notClose).remove();
        $myTabContent.children(".tab-pane").not($notCloseContent).remove();

        switchTab(0);
    });

    $document.on("click", ".JS_refresh_tab", function () {
        contextMenuHide();

        var $li = $myTab.find("li[data-id=" + closeOtherTabsIndex + "]");

        var index = $li.index();
        var $content = $myTabContent.find(".tab-pane").eq(index);

        var $iframe = $content.find(".iframe");
        var src = $iframe.attr("src");
        $iframe.attr("src", src);

    });

    function createTab() {

        var content = '<div role="tabpanel" class="tab-pane active">' +
            '</div>';
        var tab = '<li role="presentation" class="am-active">' +
            '<a><span></span> &nbsp;<button type="button" class="am-close">&times;</button></a>' +
            '</li>';

        $myTab.children().removeClass("am-active");
        $myTabContent.children().removeClass("active");

        $myTab.append(tab);
        $myTabContent.append(content);

    }

    $document.on("click", "#myTab .am-close", function (e) {

        e.stopPropagation();

        var $this = $(this);

        var $tab = $this.parents("li").eq(0);
        var index = $tab.index();

        var $myTabChildren = $myTab.children();
        var size = $myTabChildren.length;

        var $myContentChildren = $myTabContent.children();

        if (size > 1) {
            $myTabChildren.eq(index).remove();
            $myContentChildren.eq(index).remove();
            resize();
        } else {
            $('#myModal').modal();
        }

        switchTab(index - 1);

    });

    function switchTab(index) {
        var $myContentChildren = $myTabContent.children();
        var size = $myContentChildren.length;
        var $myTabChildren = $myTab.children();
        if (index > size - 1) {
            index = size - 1;
        }
        $myContentChildren.removeClass("active").eq(index).addClass("active");
        $myTabChildren.removeClass("am-active").eq(index).addClass("am-active");
        resize();
    }

    $document.find("#contextmenu,#contextmenu-mask,#myTab").on("contextmenu", function () {
        return false;
    });

    $document.on("mousedown", "#myTab li", function (e) {
        $li = $(this);

        var index = $li.index();

        var x = e.pageX;
        var y = e.pageY;

        var linkId = $li.attr("data-id");
        if (e.which === 3) {

            activeMenu = $(this);
            $contextmenu.css({
                left: x,
                top: y
            });
            $contextmenumask.show();
            $contextmenu.show();
            closeOtherTabsIndex = linkId;
        } else {
            switchTab(index);
            setOpened(linkId);
            setScroll();

        }

    });

    $document.on("mouseenter", ".sidebar", function () {
        var $this = $(this);
        var sidebarHeight = $this.height();
        var $navSidebar = $this.find(".nav-sidebar");
        var sidebarSize = $navSidebar.length;
        var navSidebarHeight = $navSidebar.height();

        var $console = $this.parents(".console");
        if ($console.is(".shrunk")) {

            if (navSidebarHeight * sidebarSize > sidebarHeight) {
                $console.addClass("temp-spread");
            }

        }

        $this.addClass("sidebar-hover");

    });

    $document.on("mouseleave", ".sidebar", function () {
        var $this = $(this);
        var $console = $this.parents(".console");
        $console.removeClass("temp-spread");

        $this.removeClass("sidebar-hover");
    });

    (function bindMouseScrollEvent() {
        var Sys = {}, s, ua = navigator.userAgent.toLowerCase();
        (s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[1] :
            (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[1] :
                (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[1] :
                    (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[1] :
                        (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[1] : 0;
        if (Sys.ie) {
            $sidebarBoxWrap[0].attachEvent('onmousewheel', mouseWheelHandler);
        } else {
            $sidebarBoxWrap[0].addEventListener('mousewheel', mouseWheelHandler);
            $sidebarBoxWrap[0].addEventListener("DOMMouseScroll", mouseWheelHandler);
        }
    }());

    function mouseWheelHandler(e) {
        if (!e.preventDefault)
            e.returnValue = false;
        else
            e.preventDefault();
        e = e || window.event;
        var delta = Math.max(-1, Math.min(1, (e.wheelDelta || -e.detail)));
        switch (delta) {
            case 1:
                move(1);
                break;
            case -1:
                move(-1);
                break;
        }
    }

    $sidebarBoxWrap.on("mouseenter", function () {
        $sidebarScroll.show();
        setScroll();
    });
    $sidebarBoxWrap.on("mouseleave", function () {
        $sidebarScroll.hide();
    });

    function setScroll() {

        var height = $sidebarBox.height();
        var wrapHeight = $sidebarBoxWrap.height();

        if (wrapHeight > height) {
            $sidebarScroll.hide();
            return false;
        } else {
            if ($(".sidebar").is(".sidebar-hover")) {

                $sidebarScroll.show();
            }
        }

        var proportion = height / wrapHeight;

        $sidebarThumb.css("height", wrapHeight / proportion);

    }

    var position = {};
    var down = false;
    $document.on("mousedown", ".sidebar-box-scroll", function (e) {
        if (e.which === 1) {
            down = true;
            position.top = e.pageY;

        }

        $body.addClass("cant-select");

        $document.on("mousemove", mouseMoveHandler);
    });

    var mouseMoveHandler = function (e) {
        if (down) {
            var positionNow = {};
            positionNow.top = e.pageY;

            if (positionNow.top > position.top) {
                move(-1, 2);
            } else {
                move(1, 2);
            }

        }

        position.top = e.pageY;
    };

    var mouseUpHandler = function () {

        $document.off("mousemove", mouseMoveHandler);
        down = false;
        $body.removeClass("cant-select");
    };
    $document.on("mouseup", mouseUpHandler);


    function move(up, step) {

        step = step || 50;

        var top = parseInt($sidebarBox.css("top"));

        var height = $sidebarBox.height();
        var wrapHeight = $sidebarBoxWrap.height();
        var proportion = height / wrapHeight;

        if (up !== 1) {

            top -= step;
        } else {
            top += step;
        }

        if (height - wrapHeight < -top) {
            top = -(height - wrapHeight)
        }

        var thumbTop = -top / proportion;

        if (top > 0) {
            top = 0;
        }

        if (thumbTop < 0) {
            thumbTop = 0;
        }

        $sidebarThumb.css("top", thumbTop);
        $sidebarBox.css("top", top);
    }

    //个人下拉菜单
    $headerdropdown.on('click', '.header-dropdown-menu li a',function (url) {
        var href = $(this).attr("data");
        var dataId = $(this).attr("data-id");
        var text = $(this).text();
        renderTab(text,href,dataId);
    });

    $("#navigationBar").on('mouseenter', function () {
        $(".listMethodItem").removeClass("displayOff");
    });
    $(".listMethodItem").on('mouseleave', function () {
        $(".listMethodItem").addClass("displayOff");
    }).on('mouseenter', function () {
        $(".listMethodItem").removeClass("displayOff");
    });

    $("#menu-box").on('click', '.menu-item', function () {
    	$("#password").val("");
        $("#newPassword").val("");
        $("#passwordOk").val("");
        var href = path + "/apiCounter/showSingle?methodId=" + $(this).attr("data-id");
        var dataId = $(this).attr("data-id");
        var text = $(this).text();
        renderTab(text,href,dataId);
    });

    $(".header-dropdown-menu").on('click', ".toEditPassword", function () {
        $('#modify-password').load(path + "/sysuser/toEditPassword");
        
        $('#modify-password').modal({});
        return false;
    });
});
