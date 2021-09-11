{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">结算记录</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-12 col-sm-12">
            <div class="card">
                <div class="card-body">
                    <div class="card-inner">
                        <div class="card-table">
                            <div class="table-responsive">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <form style="display: flex;" action="/admin/finance/settle/index" method="get">
                                            <input name="agent_id" value="{$agent_id}" class="form-control input-control" placeholder="代理商ID"/>
                                            <input type="hidden" name="page" value="{$page}"/>
                                            <button class="btn" type="submit">搜索</button>
                                        </form>
                                    </div>
                                </div>
                                <table class="table">
                                    <tr>
                                        <th>ID</th>
                                        <th>代理商ID</th>
                                        <th>代理商名称</th>
                                        <th>结算金额</th>
                                        <th>状态</th>
                                        <th>结算日期</th>
                                        <th>操作</th>
                                    </tr>
                                    {foreach $bills as $bill}
                                        <tr>
                                            <td>{$bill->id}</td>
                                            <td>{$bill->user->id}</td>
                                            <td>{$bill->user->user_name}</td>
                                            <td>{$bill->amount}</td>
                                            <td>
                                                {if $bill->status == 'NORMAL'}
                                                    成功
                                                {/if}
                                                {if $bill->status == 'CANCEL'}
                                                    已撤销({$bill->canceled_at})
                                                {/if}
                                            </td>
                                            <td>{$bill->created_at}</td>
                                            <td>
                                                <a href="/admin/finance/settle/info?id={$bill->id}" class="btn">详情</a>
                                            </td>
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
    </div>
</main>

{include file='admin/footer.tpl'}
<script>

</script>
