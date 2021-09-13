{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">用户列表</h1>
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
                                        <form style="display: flex;" action="/admin/operation/user/index" method="get">
                                            <input name="user_id" value="{$user_id}" class="form-control input-control" placeholder="用户ID"/>
                                            <input name="agent_id" value="{$agent_id}" class="form-control input-control" placeholder="代理ID(查询下一级)"/>
                                            <input type="hidden" name="page" value="1"/>
                                            <button class="btn" type="submit">搜索</button>
                                        </form>
                                        <div>
                                            <a href="/admin/operation/user/index?page=1&agent_id={$agent_id}&user_id={$user_id}">全部</a>
                                            <a href="/admin/operation/user/index?page=1&agent_id={$agent_id}&user_id={$user_id}&role=1">一级代理</a>
                                            <a href="/admin/operation/user/index?page=1&agent_id={$agent_id}&user_id={$user_id}&role=2">二级代理</a>
                                            <a href="/admin/operation/user/index?page=1&agent_id={$agent_id}&user_id={$user_id}&role=3">普通用户</a>
                                        </div>
                                    </div>
                                </div>
                                <table class="table">
                                    <tr>
                                        <th>ID</th>
                                        <th>邮箱</th>
                                        <th>昵称</th>
                                        <th>是否为代理</th>
                                        <th>代理等级</th>
                                        <th>操作</th>
                                    </tr>
                                    {foreach $users as $item}
                                        <tr>
                                            <td>{$item->id}</td>
                                            <td>{$item->email}</td>
                                            <td>{$item->user_name}</td>
                                            <td>
                                                {if $item->is_agent==1}是{else}否{/if}
                                            </td>
                                            <td>{$item->agent_level}</td>
                                            <td>{$item->amount}</td>
                                            <td>
                                                <a href="/admin/operation/user/info?id={$item->id}" class="btn">详情</a>
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
