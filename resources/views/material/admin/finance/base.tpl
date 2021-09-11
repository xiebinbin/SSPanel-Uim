{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">基本财务信息</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-6 col-sm-6">
            <div class="card margin-bottom-no">
                <div class="card-main">
                    <div class="card-header">
                        <div class="card-inner">
                            <p class="card-heading">总流水信息</p>
                        </div>
                    </div>
                    <div class="card-inner">
                        <div class="card-inner">
                            <p class="card-heading">总流水：<code>{$data['sum_sale_amount']}</code> 元</p>
                            <p class="card-heading">昨日流水：<code>{$data['yesterday_sale_amount']}</code> 元
                            </p>
                            <p class="card-heading">当日流水：<code>{$data['today_sale_amount']}</code> 元</p>
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
                            <p class="card-heading">总结算信息</p>
                        </div>
                    </div>
                    <div class="card-inner">
                        <div class="card-inner">
                            <p class="card-heading">已结算：<code>{$data['settled_amount']}</code> 元</p>
                            <p class="card-heading">待结算：<code>{$data['balance']}</code> 元</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

{include file='admin/footer.tpl'}
