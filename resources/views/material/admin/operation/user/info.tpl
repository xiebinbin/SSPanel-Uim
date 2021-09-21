{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">用户详情</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-12 col-sm-6">
            <div class="card margin-bottom-no">
                <div class="card-main">
                    <div class="card-header">
                        <div class="card-inner">
                            <p class="card-heading">用户信息</p>
                        </div>
                    </div>
                    <div class="card-inner">
                        <div class="card-inner">
                            <p class="card-heading">ID：{$userInfo->id}</p>

                            <p class="card-heading">昵称：{$userInfo->user_name}</p>
                            <p class="card-heading">邮箱：{$userInfo->email}</p>
                            <p class="card-heading">是否为代理：{if $userInfo->is_agent==1}是{else}否{/if}</p>
                            {if $userInfo->is_agent == 1}
                                <p class="card-heading">代理等级：{$userInfo->agent_level}</p>
                            {/if}
                            {if !empty($superior)}
                                <p class="card-heading">上级代理：{$superior->email}({$superior->id})</p>
                            {/if}
                            <p class="card-heading">注册时间：{$userInfo->reg_date}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12 col-sm-6">
            <div class="card margin-bottom-no">
                <div class="card-main">
                    <div class="card-header">
                        <div class="card-inner">
                            <p class="card-heading">代理设置</p>
                        </div>
                    </div>
                    <div class="card-inner">
                        <div class="card-inner">
                            <div class="form-group form-group-label">
                                <div class="checkbox switch">
                                    <label for="is_agent">
                                        <input {if $userInfo->is_agent==1}checked{/if} class="access-hide" id="is_agent" type="checkbox"/>
                                        <span class="switch-toggle"></span>是否为代理
                                    </label>
                                </div>
                            </div>
                            <div class="form-group form-group-label">
                                <label for="agent_level">
                                    <label class="floating-label" for="sort">代理等级</label>
                                    <select id="agent_level" class="form-control maxwidth-edit" name="agent_level">
                                        <option value="0" {if $userInfo->agent_level==0}selected{/if}>无
                                        </option>
                                        <option value="1" {if $userInfo->agent_level==1}selected{/if}>1级
                                        </option>
                                        <option value="2" {if $userInfo->agent_level==2}selected{/if}>2级
                                        </option>
                                    </select>
                                </label>
                            </div>
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="email">上级代理ID</label>
                                <input class="form-control maxwidth-edit" id="ref_by" type="number" value="{$userInfo->ref_by}">
                            </div>
                            <button id="transfer" class="btn btn-green" style="color:white !important;">确认设置</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

{include file='admin/footer.tpl'}
<script>
    let transferLoad = false;
    $("#transfer").click(function () {
        if (transferLoad){
            return false;
        }
        let user_id = {$userInfo->id};
        let is_agent = 0;
        if (document.getElementById('is_agent').checked) {
            is_agent = 1;
        }
        let ref_by = $$getValue('ref_by');
        if(confirm("确认设置?")){
            transferLoad = true;
            $.ajax({
                type: "POST",
                url: "/admin/operation/user/update",
                dataType: "json",
                data: {
                    user_id,
                    is_agent,
                    ref_by,
                    agent_level: $$getValue('agent_level')
                },
                success: data => {
                    transferLoad = false;
                    console.log(data);
                    if(data.ret){
                        $.toast({
                            heading: 'Positioning',
                            text: "设置成功!",
                            position: 'top-right',
                            stack: false
                        });
                    }
                    setTimeout(() => location.reload(), 2000);
                },
                error: jqXHR => {
                    transferLoad = false;
                    $.toast({
                        heading: 'Positioning',
                        text: "请求错误",
                        position: 'top-right',
                        stack: false
                    });
                }
            });
        }
        return true;
    });
</script>
