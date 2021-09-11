{include file='user/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">下级用户</h1>
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
                                        <table class="table">
                                            <tr>
                                                <th>用户ID</th>
                                                {if $user->is_agent == 1 && $user->agent_level == 1}
                                                <th>角色</th>
                                                {/if}
                                                <th>邀请时间</th>
                                                <th>操作</th>
                                            </tr>
                                            {foreach $fans as $item}
                                                <tr>
                                                    <td>{$item->id}</td>
                                                    {if $user->is_agent == 1 && $user->agent_level == 1}
                                                        <td>{if $item->is_agent==1}代理{else}普通用户{/if}</td>
                                                    {/if}
                                                    <td>{$item->reg_date}</td>
                                                    <td>
                                                        {if $user->is_agent == 1 && $user->agent_level == 1}
                                                            {if $item->is_agent == 1}
                                                                <button onclick="cancelAgent({$item->id})">取消代理</button>
                                                            {else}
                                                                <button onclick="setAgent({$item->id})">设为代理</button>
                                                            {/if}
                                                        {/if}
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
                {include file='dialog.tpl'}
            </div>
        </section>
    </div>
</main>

{include file='user/footer.tpl'}


<script>
    function cancelAgent(userId){
        $.ajax({
            type: "POST",
            url: "/agent/cancel_agent",
            dataType: "json",
            data: {
                user_id: userId
            },
            success: (data) => {
                if (data.ret) {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                    window.setTimeout("location.href='/user/invite'", {$config['jump_delay']});
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
        });
    }
    function setAgent(userId){
        $.ajax({
            type: "POST",
            url: "/agent/set_agent",
            dataType: "json",
            data: {
                user_id: userId
            },
            success: (data) => {
                if (data.ret) {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                    window.setTimeout("location.reload();", {$config['jump_delay']});
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
        });
    }
</script>
