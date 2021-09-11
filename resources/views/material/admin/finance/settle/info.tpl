{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">结算详情</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-12 col-sm-12">
            <div class="card margin-bottom-no">
                <div class="card-main">
                    <div class="card-header">
                        <div class="card-inner">
                            <p class="card-heading">结算信息</p>
                        </div>
                    </div>
                    <div class="card-inner">
                        <div class="card-inner">
                            <p class="card-heading">结算ID：{$bill->id}</p>

                            <p class="card-heading">代理商：{$agent->user_name}({$agent->id})</p>
                            <p class="card-heading">结算人：{$finance->user_name}({$finance->id})</p>
                            <p class="card-heading">结算金额：<code>{$bill->amount}</code> 元</p>
                            <p class="card-heading">结算时间：{$bill->created_at}</p>
                            <p class="card-heading">结算状态：
                                {if $bill->status == 'NORMAL'}
                                    正常
                                {else}
                                    已撤销
                                {/if}
                            </p>
                            {if $bill->status == 'CANCEL'}
                                <p class="card-heading">撤销时间：{$bill->canceled_at}</p>
                            {/if}
                            {if $bill->is_cancel}
                                <button id="cancel" class="btn btn-red">撤销</button>
                            {/if}
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
    $("#cancel").click(function () {
        if (transferLoad){
            return false;
        }
        let bill_id = {$bill->id};
        let params = {
            bill_id,
        };
        if(confirm("确认转账?")){
            transferLoad = true;
            $.ajax({
                type: "POST",
                url: "/admin/finance/settle/cancel",
                dataType: "json",
                data: params,
                success: data => {
                    transferLoad = false;
                    console.log(data);
                    if(data.ret){
                        $.toast({
                            heading: 'Positioning',
                            text: "撤销成功!",
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
