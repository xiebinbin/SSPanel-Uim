{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">代理列表</h1>
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
                                        <form style="display: flex;" action="/admin/agent/index" method="get">
                                            <input name="keywords" value="{$keywords}" class="form-control input-control" placeholder="代理邮箱或名称"/>
                                            <input type="hidden" name="page" value="{$page}"/>
                                            <button class="btn" type="submit">搜索</button>
                                        </form>
                                    </div>
                                </div>
                                <table class="table">
                                    <tr>
                                        <th>代理ID</th>
                                        <th>代理名称</th>
                                        <th>代理邮箱</th>
                                        <th>累计结算</th>
                                        <th>未结算</th>
                                        <th>操作</th>
                                    </tr>
                                    {foreach $agents as $agent}
                                        <tr>
                                            <td>{$agent->id}</td>
                                            <td>{$agent->user_name}</td>
                                            <td>{$agent->email}</td>
                                            <td>{$agent->wallet->settled_amount}</td>
                                            <td>{$agent->wallet->balance}</td>
                                            <td>
                                                <a href="/admin/agent/info?id={$agent->id}" class="btn">详情</a>
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
