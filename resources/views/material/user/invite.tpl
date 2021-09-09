{include file='user/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">代理面板</h1>
        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-inner">
                                    <p class="card-heading">流水信息</p>
                                    <p>对方充值时您还会获得对方充值金额的 <code>{$config['code_payback']} %</code> 的返利。</p>
                                    <p class="card-heading">总流水：<code>{$agent_wallet->sum_sale_amount}</code> 元</p>
                                    <p class="card-heading">昨日流水：<code>{$agent_wallet->yesterday_sale_amount}</code> 元
                                    </p>
                                    <p class="card-heading">当日流水：<code>{$agent_wallet->today_sale_amount}</code> 元</p>
                                    <p class="card-heading">已结算：<code>{$agent_wallet->settled_amount}</code> 元</p>
                                    <p class="card-heading">未结算：<code>{$agent_wallet->balance}</code> 元</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                {if $user->is_agent!=0}
                    <div class="col-lg-6 col-md-6">
                        <div class="card margin-bottom-no">
                            <div class="card-main">
                                <div class="card-inner margin-bottom-no">
                                    <div class="card-inner margin-bottom-no">
                                        <div class="cardbtn-edit">
                                            <div class="card-heading">邀请链接</div>
                                            <div class="reset-flex"><span>重置链接</span><a
                                                        class="reset-link btn btn-brand-accent btn-flat"><i
                                                            class="icon">autorenew</i>&nbsp;</a></div>
                                        </div>
                                        <p>发送邀请链接给有需要的人，邀请他人注册时，请将以下链接发给被邀请者</p>
                                        <div class="invite-link">
                                            <input type="text"
                                                   class="input form-control form-control-monospace cust-link"
                                                   name="input1" readonly=""
                                                   value="{$config['baseUrl']}/auth/register?code={$code->code}">
                                            <button class="copy-text btn btn-subscription" type="button"
                                                    data-clipboard-text="{$config['baseUrl']}/auth/register?code={$code->code}">
                                                点击复制
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
                {include file='dialog.tpl'}
            </div>
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
        $$.getElementById('msg').innerHTML = '已复制到您的剪贴板，请您继续接下来的操作。';
    });
    $(document).ready(function () {
        $("#invite").click(function () {
            $.ajax({
                type: "POST",
                url: "/user/invite",
                dataType: "json",
                success: (data) => {
                    window.location.reload();
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `发生错误：${
                            jqXHR.status
                    }`;
                }
            })
        })
    })
</script>
<script>
    $(".reset-link").click(function () {
        $("#result").modal();
        $$.getElementById('msg').innerHTML = '已重置您的邀请链接，复制您的邀请链接发送给其他人！';
        window.setTimeout("location.href='/user/inviteurl_reset'", {$config['jump_delay']});
    });
</script>
