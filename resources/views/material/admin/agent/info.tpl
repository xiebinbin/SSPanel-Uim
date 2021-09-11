{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">代理列表</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-6 col-sm-6">
            <div class="card margin-bottom-no">
                <div class="card-main">
                    <div class="card-header">
                        <div class="card-inner">
                            <p class="card-heading">用户信息</p>
                        </div>
                    </div>
                    <div class="card-inner">
                        <div class="card-inner">
                            <p class="card-heading">用户ID：{$agent->id}</p>
                            <p class="card-heading">用户名：{$agent->user_name}</p>
                            <p class="card-heading">用户邮箱：{$agent->email}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6 col-sm-6">
            <div class="card margin-bottom-no">
                <div class="card-main">
                    <div class="card-header">
                        <div class="card-inner">
                            <p class="card-heading">流水信息</p>
                        </div>
                    </div>
                    <div class="card-inner">
                        <div class="card-inner">
                            <p class="card-heading">总流水：<code>{$wallet->sum_sale_amount}</code> 元</p>
                            <p class="card-heading">昨日流水：<code>{$wallet->yesterday_sale_amount}</code> 元
                            </p>
                            <p class="card-heading">当日流水：<code>{$wallet->today_sale_amount}</code> 元</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-6 col-sm-6">
            <div class="card margin-bottom-no">
                <div class="card-main">
                    <div class="card-header">
                        <div class="card-inner">
                            <p class="card-heading">结算信息</p>
                        </div>
                    </div>
                    <div class="card-inner">
                        <div class="card-inner">
                            <p class="card-heading">已结算：<code>{$wallet->settled_amount}</code> 元</p>
                            <p class="card-heading">未结算：<code>{$wallet->balance}</code> 元</p>
                            <a href="/admin/finance/transfer?agent_id={$agent->id}" class="btn">去结算</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

{include file='admin/footer.tpl'}
