{include file='user/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">结算记录</h1>
        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">
            <div class="row">
                <div class="col-xx-12">
                    <div class="card">
                        <div class="card-main">
                            <div class="card-inner">
                                <div class="card-table">
                                    <div class="table-responsive bgc-fix table-user">
                                        {$render}
                                        <table class="table">
                                            <tr>
                                                <th>用户ID</th>
                                                <th>金额</th>
                                                <th>备注</th>
                                                <th>资金流向</th>
                                                <th>操作时间</th>

                                            </tr>
                                            {foreach $bills as $bill}
                                                <tr>
                                                    <td>{$bill->user_id}</td>
                                                    <td>{$bill->amount}</td>
                                                    <td>{$bill->remark}</td>
                                                    <td>
                                                        {if $bill->flow == 'INPUT'}
                                                            流入
                                                        {else}
                                                            流出
                                                        {/if}
                                                    </td>
                                                    <td>{$bill->creted_at}</td>
                                                </tr>
                                            {/foreach}
                                        </table>
                                        {$render}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                {include file='dialog.tpl'}
            </div>
        </section>
    </div>
</main>

{include file='user/footer.tpl'}
