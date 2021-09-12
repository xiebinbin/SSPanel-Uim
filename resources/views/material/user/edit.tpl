{include file='user/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">修改资料</h1>
        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">
            <div class="col-xx-12 col-sm-6">
                <div class="card margin-bottom-no">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading">用戶名修改</div>
                                    <button class="btn btn-flat" id="username-update"><span class="icon">check</span>&nbsp;
                                    </button>
                                </div>
                                <div class="form-group form-group-label">
                                    <label class="floating-label" for="newusername">新用戶名</label>
                                    <input class="form-control maxwidth-edit" id="newusername" type="text">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                {if $config['enable_change_email'] == true}
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-inner">
                                    <div class="cardbtn-edit">
                                        <div class="card-heading">账户邮箱修改</div>
                                        <button class="btn btn-flat" id="email-update"><span class="icon">check</span>&nbsp;
                                        </button>
                                    </div>
                                    <div class="form-group form-group-label">
                                        <label class="floating-label" for="newemail">新邮箱</label>
                                        <input class="form-control maxwidth-edit" id="newemail" type="text">
                                    </div>
                                    {if $config['enable_email_verify'] == true}
                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="email_code">邮箱验证码</label>
                                            <input class="form-control maxwidth-auth" id="email_code" type="text"
                                                   onKeypress="javascript:if(event.keyCode == 32)event.returnValue = false;" autocomplete="one-time-code">
                                        </div>
                                        <div class="form-group form-group-label">
                                            <button id="email_verify"
                                                    class="btn-reg btn btn-block btn-brand-accent waves-attach waves-light">
                                                获取验证码
                                            </button>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
            </div>
            <div class="col-xx-12 col-sm-6">
                <div class="card margin-bottom-no">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading">账号登录密码修改</div>
                                    <button class="btn btn-flat" id="pwd-update"><span class="icon">check</span>&nbsp;
                                    </button>
                                </div>
                                <div class="form-group form-group-label">
                                    <label class="floating-label" for="oldpwd">当前密码</label>
                                    <input class="form-control maxwidth-edit" id="oldpwd" type="password">
                                </div>
                                <div class="form-group form-group-label">
                                    <label class="floating-label" for="pwd">新密码</label>
                                    <input class="form-control maxwidth-edit" id="pwd" type="password">
                                </div>
                                <div class="form-group form-group-label">
                                    <label class="floating-label" for="repwd">确认新密码</label>
                                    <input class="form-control maxwidth-edit" id="repwd" type="password">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <section class="content-inner margin-top-no">
            <div class="col-xx-12 col-sm-12">
                <div class="card margin-bottom-no">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading">节点连接密码修改</div>
                                    <button class="btn btn-flat" id="ss-pwd-update"><span class="icon">check</span>&nbsp;</button>
                                </div>
                                <p>当前连接密码：<code id="ajax-user-passwd">{$user->passwd}</code>
                                    <button class="kaobei copy-text btn btn-subscription" type="button" data-clipboard-text="{$user->passwd}">
                                        点击拷贝
                                    </button>
                                </p>
                                <p>点击重置按钮将会自动生成由随机字母和数字组成的连接密码。</p>
                                <p>修改连接密码同时也会自动为您重新生成 V2Ray 和 Trojan 节点的 UUID。</p>
                                <p>修改连接密码后，您需要更新订阅或修改客户端配置方可继续使用。</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xx-12 col-sm-12">
                <div class="card margin-bottom-no">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="card-inner">
                                <div class="cardbtn-edit">
                                    <div class="card-heading">重置订阅链接</div>
                                    <div class="reset-flex">
                                        <a class="reset-link btn btn-brand-accent btn-flat" ><i class="icon">autorenew</i>&nbsp;</a>
                                    </div>
                                </div>
                                <p>点击会重置您的订阅链接，您需要更新客户端中所配置的订阅地址方可继续使用。</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xx-12 col-sm-6">
                {if $config['port_price']>=0 || $config['port_price_specify']>=0}
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                {if $config['port_price']>=0}
                                    <div class="card-inner">
                                        <div class="cardbtn-edit">
                                            <div class="card-heading">重置端口</div>
                                            <button class="btn btn-flat" id="portreset"><span
                                                        class="icon">autorenew</span>&nbsp;
                                            </button>
                                        </div>
                                        <p>对号码不满意？来摇号吧～！</p>
                                        <p>随机更换一个端口使用，价格：<code>{$config['port_price']}</code>元/次</p>
                                        <p>重置后 1 分钟内生效</p>
                                        <p>当前端口：<code id="ajax-user-port">{$user->port}</code></p>
                                    </div>
                                {/if}
                                {if $config['port_price_specify']>=0}
                                    <div class="card-inner">
                                        <div class="cardbtn-edit">
                                            <div class="card-heading">钦定端口</div>
                                            <button class="btn btn-flat" id="portspecify"><span
                                                        class="icon">call_made</span>&nbsp;
                                            </button>
                                        </div>
                                        <p>不想摇号？来钦定端口吧～！</p>
                                        <p>价格：<code>{$config['port_price_specify']}</code>元/次</p>
                                        <p>端口范围：<code>{$config['min_port']}～{$config['max_port']}</code></p>
                                        <div class="form-group form-group-label">
                                            <label class="floating-label" for="port-specify">在这输入想钦定的端口号</label>
                                            <input class="form-control maxwidth-edit" id="port-specify" type="num">
                                        </div>
                                    </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                {/if}
            </div>
                {include file='dialog.tpl'}
        </section>
    </div>
</main>

{include file='user/footer.tpl'}

<script>
    $(function () {
        new ClipboardJS('.copy-text');
    });
    $(".copy-text").click(function () {
        $("#result").modal();
        $$.getElementById('msg').innerHTML = '已复制到您的剪贴板。';
    });
</script>
{literal}
<script>
    /*
     * 筛选 SS/SSR 加密、混淆和协议的选项
     *
     * 引入三个按钮：
     * #filter-btn-ss 筛选 SS，点击以后隐藏 .filter-item-ssr，显示 .filter-item-ss 和 .filter-item-universal
     * #filter-btn-ssr 筛选 SSR，点击以后隐藏 .filter-item-ss，显示 .filter-item-ssr 和 .filter-item-universal
     * #filter-btn-universal 筛选必须同时兼容两者的，点击以后隐藏 .filter-item-ss 和 .filter-item-ssr，显示 .filter-item-universal
     *
     * 引入函数 hideFilterItem(itemType) 和 showFilterItem(itemType)，参数 item 可以是 ss ssr universal。
     */
    (() => {
        const hideFilterItem = (itemType) => {
            for (let i of $$.getElementsByClassName(`filter-item-${itemType}`)) {
                i.style.display = 'none';
            }
        };
        const showFilterItem = (itemType) => {
            for (let i of $$.getElementsByClassName(`filter-item-${itemType}`)) {
                i.style.display = 'block';
            }
        };
        const chooseSS = () => {
            hideFilterItem('ssr');
            showFilterItem('ss');
            showFilterItem('universal');
        };
        const chooseSSR = () => {
            hideFilterItem('ss');
            showFilterItem('ssr');
            showFilterItem('universal');
        };
        const chooseUniversal = () => {
            hideFilterItem('ss');
            hideFilterItem('ssr');
            showFilterItem('universal');
        };
        $$.getElementById('filter-btn-ss').addEventListener('click', chooseSS);
        $$.getElementById('filter-btn-ssr').addEventListener('click', chooseSSR);
        $$.getElementById('filter-btn-universal').addEventListener('click', chooseUniversal);
    })();
</script>
{/literal}
{literal}
<script>
    $(document).ready(function () {
        $("#portreset").click(function () {
            $.ajax({
                type: "POST",
                url: "resetport",
                dataType: "json",
                data: {},
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('ajax-user-port').innerHTML = data.msg;
                        $$.getElementById('msg').innerHTML = `设置成功，新端口是 ${
                                data.msg
                                }`;
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } 出现了一些错误`;
                }
            })
        })
    })
</script>
<script>
    $(document).ready(function () {
        $("#portspecify").click(function () {
            $.ajax({
                type: "POST",
                url: "specifyport",
                dataType: "json",
                data: {
                    port: $$getValue('port-specify')
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('ajax-user-port').innerHTML = $$getValue('port-specify');
                        $$.getElementById('msg').innerHTML = data.msg;
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } 出现了一些错误`;
                }
            })
        })
    })
</script>
<script>
    $(document).ready(function () {
        $("#pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "password",
                dataType: "json",
                data: {
                    oldpwd: $$getValue('oldpwd'),
                    pwd: $$getValue('pwd'),
                    repwd: $$getValue('repwd')
                },
                success: (data) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } 出现了一些错误`;
                }
            })
        })
    })
</script>
{/literal}
<script>
    $(document).ready(function () {
        $("#username-update").click(function () {
            $.ajax({
                type: "POST",
                url: "username",
                dataType: "json",
                data: {
                    newusername: $$getValue('newusername')
                },
                success: (data) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                        data.msg
                    } 出现了一些错误`;
                }
            })
        })
    })
</script>
{if $config['enable_change_email'] == true}
    <script>
        $(document).ready(function () {
            $("#email-update").click(function () {
                $.ajax({
                    type: "POST",
                    url: "email",
                    dataType: "json",
                    data: {
                        {if $config['enable_email_verify'] == true}
                            emailcode: $$getValue('email_code'),
                        {/if}
                        newemail: $$getValue('newemail')
                    },
                    success: (data) => {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    },
                    error: (jqXHR) => {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = `${
                            data.msg
                        } 出现了一些错误`;
                    }
                })
            })
        })
    </script>
    {if $config['enable_email_verify'] == true}
        <script>
            var wait = 60;
            function time(o) {
                if (wait == 0) {
                    o.removeAttr("disabled");
                    o.text("获取验证码");
                    wait = 60;
                } else {
                    o.attr("disabled", "disabled");
                    o.text("重新发送(" + wait + ")");
                    wait--;
                    setTimeout(function () {
                        time(o)
                    },
                    1000)
                }
            }
            $(document).ready(function () {
                $("#email_verify").click(function () {
                    time($("#email_verify"));
                    $.ajax({
                        type: "POST",
                        url: "send",
                        dataType: "json",
                        data: {
                            email: $$getValue('newemail')
                        },
                        success: (data) => {
                            if (data.ret) {
                                $("#result").modal();
                                $$.getElementById('msg').innerHTML = data.msg;
                            } else {
                                $("#result").modal();
                                $$.getElementById('msg').innerHTML = data.msg;
                            }
                        },
                        error: (jqXHR) => {
                            $("#result").modal();
                            $$.getElementById('msg').innerHTML = `${
                                data.msg
                            } 出现了一些错误`;
                        }
                    })
                })
            })
        </script>
    {/if}
{/if}
<script>
    var ga_qrcode = '{$user->getGAurl()}',
            qrcode1 = new QRCode(document.getElementById("ga-qr"));

    qrcode1.clear();
    qrcode1.makeCode(ga_qrcode);
    {if $config['enable_telegram'] === true}
    var telegram_qrcode = 'mod://bind/{$bind_token}';
    if ($$.getElementById("telegram-qr")) {
        let qrcode2 = new QRCode(document.getElementById("telegram-qr"));
        qrcode2.clear();
        qrcode2.makeCode(telegram_qrcode);
    }
    {/if}
</script>
{literal}
<script>
    $(document).ready(function () {
        $("#wechat-update").click(function () {
            $.ajax({
                type: "POST",
                url: "wechat",
                dataType: "json",
                data: {
                    wechat: $$getValue('wechat'),
                    imtype: $$getValue('imtype')
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('ajax-im').innerHTML = `${$("#imtype").find("option:selected").text()} ${$$getValue('wechat')}`
                        $$.getElementById('msg').innerHTML = data.msg;
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} 出现了一些错误`;
                }
            })
        })
    })
</script>
<script>
    $(document).ready(function () {
        $("#ssr-update").click(function () {
            $.ajax({
                type: "POST",
                url: "ssr",
                dataType: "json",
                data: {
                    protocol: $$getValue('protocol'),
                    obfs: $$getValue('obfs'),
                    obfs_param: $$getValue('obfs-param')
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('ajax-user-protocol').innerHTML = $$getValue('protocol');
                        $$.getElementById('ajax-user-obfs').innerHTML = $$getValue('obfs');
                        $$.getElementById('ajax-user-obfs-param').innerHTML = $$getValue('obfs-param');
                        $$.getElementById('msg').innerHTML = data.msg;
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} 出现了一些错误`;
                }
            })
        })
    })
</script>
<script>
    $(document).ready(function () {
        $("#unblock").click(function () {
            $.ajax({
                type: "POST",
                url: "unblock",
                dataType: "json",
                data: {},
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('ajax-block').innerHTML = `IP：${
                                data.msg
                                } 没有被封`;
                        $$.getElementById('msg').innerHTML = `IP：${
                                data.msg
                                } 解封成功过`;
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} 出现了一些错误`;
                }
            })
        })
    })
</script>
<script>
    $(document).ready(function () {
        $("#ga-test").click(function () {
            $.ajax({
                type: "POST",
                url: "gacheck",
                dataType: "json",
                data: {
                    code: $$getValue('code')
                },
                success: (data) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} 出现了一些错误`;
                }
            })
        })
    })
</script>
<script>
    $(document).ready(function () {
        $("#ga-set").click(function () {
            $.ajax({
                type: "POST",
                url: "gaset",
                dataType: "json",
                data: {
                    enable: $$getValue('ga-enable')
                },
                success: (data) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} 出现了一些错误`;
                }
            })
        })
    })
</script>
<script>
    $(document).ready(function () {
        $("#ss-pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "sspwd",
                dataType: "json",
                data: {},
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = '修改成功';
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = '修改失败';
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                }
            })
        })
    })
</script>
{/literal}
<script>
    $(document).ready(function () {
        $("#mail-update").click(function () {
            $.ajax({
                type: "POST",
                url: "mail",
                dataType: "json",
                data: {
                    mail: $$getValue('mail')
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href='/user/edit'", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                {literal}
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${data.msg} 出现了一些错误`;
                }
                {/literal}
            })
        })
    })
</script>
<script>
    $(document).ready(function () {
        $("#theme-update").click(function () {
            $.ajax({
                type: "POST",
                url: "theme",
                dataType: "json",
                data: {
                    theme: $$getValue('theme')
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href='/user/edit'", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
{literal}
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } 出现了一些错误`;
                }
            })
        })
    })
</script>
<script>
    $(document).ready(function () {
        $("#method-update").click(function () {
            $.ajax({
                type: "POST",
                url: "method",
                dataType: "json",
                data: {
                    method: $$getValue('method')
                },
                success: (data) => {
                    $$.getElementById('ajax-user-method').innerHTML = $$getValue('method');
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = '修改成功';
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `${
                            data.msg
                            } 出现了一些错误`;
                }
            })
        })
    })
</script>
{/literal}
<script>
    $(function () {
        new ClipboardJS('.reset-link');
    });
    $(".reset-link").click(function () {
        $("#result").modal();
        $$.getElementById('msg').innerHTML = '已重置您的订阅链接，请变更或添加您的订阅链接！';
        window.setTimeout("location.href='/user/url_reset'", {$config['jump_delay']});
    });
</script>
