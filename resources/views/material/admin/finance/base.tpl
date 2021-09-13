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
                            <p class="card-heading">今日收入：<code>{$data['today_income']}</code> 元</p>
                            <p class="card-heading">今日支出：<code>{$data['today_expend']}</code> 元</p>
                            <p class="card-heading">当月收入：<code>{$data['current_month_income']}</code> 元</p>
                            <p class="card-heading">当月支出：<code>{$data['current_month_expend']}</code> 元</p>
                            <p class="card-heading">当月收入：<code>{$data['sum_income']}</code> 元</p>
                            <p class="card-heading">当月支出：<code>{$data['sum_expend']}</code> 元</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

{include file='admin/footer.tpl'}
