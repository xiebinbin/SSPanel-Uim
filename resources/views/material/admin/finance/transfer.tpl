{include file='admin/main.tpl'}
<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">转账给代理商</h1>
        </div>
    </div>
    <div class="container">
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
                            <p class="card-heading">用户ID：{$user->id}</p>
                            <p class="card-heading">用户名：{$user->user_name}</p>
                            <p class="card-heading">用户邮箱：{$user->email}</p>
                            <p class="card-heading">已结算：<code>{$wallet->settled_amount}</code> 元</p>
                            <p class="card-heading">未结算：<code>{$wallet->balance}</code> 元</p>
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
                            <p class="card-heading">转账面板</p>
                        </div>
                    </div>
                    <div class="card-inner">
                        <div class="card-inner">
                            <input name="transfer-value" id="transfer-value" style="width: 200px;" type="number" min="1" max="{$wallet->balance}" class="form-control input-control" placeholder="转账金额（元）"/>
                            <p>不能超过{$wallet->balance}元</p>
                            <button id="transfer" class="btn btn-green" style="color:white !important;">确认转账</button>
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
        let agent_id = {$user->id};
        let maxAmount = {$wallet->balance};
        let amount = $("#transfer-value").val();
        if (amount == '') {
            amount = 0.0;
        }else{
            amount = parseFloat(amount);
        }


        if (amount > maxAmount) {
            $.toast({
                heading: 'Positioning',
                text: "转账金额不能大于:" + maxAmount + "元",
                position: 'top-right',
                stack: false
            });
            return false;
        }else if (amount < 1) {
            $.toast({
                heading: 'Positioning',
                text: "转账金额不能小于:1元",
                position: 'top-right',
                stack: false
            });
            return false;
        }
        let params = {
            agent_id,
            amount
        };
        if(confirm("确认转账?")){
            transferLoad = true;
            $.ajax({
                type: "POST",
                url: "/admin/finance/settle/create",
                dataType: "json",
                data: params,
                success: data => {
                    transferLoad = false;
                    console.log(data);
                    if(data.ret){
                        $.toast({
                            heading: 'Positioning',
                            text: "转账成功!",
                            position: 'top-right',
                            stack: false
                        });
                    }
                    window.location.reload();
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
