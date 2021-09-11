<?php

namespace App\Controllers\Admin;

use App\Controllers\AdminController;
use App\Models\{AgentBill, AgentWallet, User};
use App\Utils\Tools;
use Carbon\Carbon;
use Illuminate\Database\Capsule\Manager as DB;
use Slim\Http\{
    Request,
    Response
};

class FinanceController extends AdminController
{
    /**
     * @param Request $request
     * @param Response $response
     * @param array $args
     */
    public function baseInfo($request, $response, $args)
    {

        $data = [
            'sum_sale_amount'=>0,
            'yesterday_sale_amount'=>0,
            'today_sale_amount'=>0,
            'settled_amount'=>AgentWallet::query()->sum('settled_amount'),
            'balance'=>AgentWallet::query()->sum('balance'),
        ];
        return $response->write(
            $this->view()
                ->assign('data',$data)
                ->display('admin/finance/base.tpl')
        );
    }
    /**
     * @param Request $request
     * @param Response $response
     * @param array $args
     */
    public function settleInfo($request, $response, $args)
    {
        $id = $request->getParam('id',0);
        if (empty($id)) {
            throw new \Exception("参数不正确!");
        }
        $bill = AgentBill::find($id);
        if (empty($bill)){
            throw new \Exception("账单不存在!");
        }
        $createdAt = new Carbon($bill->created_at);
        $createdAt->addMinutes(60);
        $nowDate = Carbon::now();
        if ($createdAt->gt($nowDate)) {
            $bill->is_cancel = True;
        }else{
            $bill->is_cancel = False;
        }
        if ($bill->status == 'CANCEL') {
            $bill->is_cancel = False;
        }
        $agent = User::find($bill->agent_user_id);
        $finance = User::find($bill->finance_user_id);
        return $response->write(
            $this->view()
                ->assign('bill',$bill)
                ->assign('finance',$finance)
                ->assign('agent',$agent)
                ->display('admin/finance/settle/info.tpl')
        );
    }
    /**
     * @param Request $request
     * @param Response $response
     * @param array $args
     */
    public function settleIndex($request, $response, $args)
    {

        $input = $request->getQueryParams();
        $pageNum = $input['page'] ?? 1;
        $agentId = $input['agent_id'] ?? '';
        $query = AgentBill::query()->where('flow','OUTPUT');
        if(!empty($agentId)){
            $query->where('agent_user_id',$agentId);
        }
        $bills = $query->orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
        $users = User::query()->whereIn('id', array_column($bills->items(),'agent_user_id'))->get();
        $users = $users->keyBy('id');
        foreach ($bills as &$bill){
            $bill->user = $users[$bill->agent_user_id] ?? null;
        }
        $bills->setPath('/admin/settle/index');
        $render = Tools::paginate_render($bills);
        return $this->view()
            ->assign('bills', $bills)
            ->assign('page', $pageNum)
            ->assign('agent_id', $agentId)
            ->assign('render', $render)
            ->display('admin/finance/settle/index.tpl');
    }
    /**
     * @param Request $request
     * @param Response $response
     * @param array $args
     */
    public function createSettle($request, $response, $args)
    {
        $agentId = $request->getParam('agent_id', 0);
        if(empty($agentId)){
            return $response->withJson([
                'ret' => 0,
                'msg' => '参数不正确!'
            ]);
        }
        $agent = User::find($agentId);
        if(empty($agent)){
            return $response->withJson([
                'ret' => 0,
                'msg' => '用户不存在!'
            ]);
        }
        if($agent->is_agent != 1){
            return $response->withJson([
                'ret' => 0,
                'msg' => '代理不存在!'
            ]);
        }
        $wallet = AgentWallet::query()->where('user_id',$agentId)->first();
        if(empty($wallet)){
            return $response->withJson([
                'ret' => 0,
                'msg' => '钱包不存在!'
            ]);
        }
        $amount = floatval($request->getParam('amount', 0));
        if ($amount < 1){
            return $response->withJson([
                'ret' => 0,
                'msg' => '不能小于1元!'
            ]);
        }
        if ($amount > $wallet->balance){
            return $response->withJson([
                'ret' => 0,
                'msg' => '余额不足!'
            ]);
        }
        DB::beginTransaction();
        try {
            // 构建订单
            $bill = new AgentBill();
            $bill->agent_user_id = $agentId;
            $bill->finance_user_id = $this->user->id;
            $bill->user_id = 0;
            $bill->amount = $amount;
            $bill->flow = 'OUTPUT';
            $bill->created_at = Carbon::now();
            $bill->updated_at = Carbon::now();
            $bill->save();
            // 更新余额
            $result = AgentWallet::query()
                ->where('user_id', $agentId)
                ->where('balance','>', $amount)
                ->update([
                    'settled_amount'=>DB::raw('settled_amount + '. $amount),
                    'balance'=>DB::raw('balance - '. $amount),
                    'updated_at'=>Carbon::now()
                ]);
            if(empty($result)){
                throw new \Exception("更新失败");
            }
            DB::commit();
            return $response->withJson([
                'ret' => 200,
                'msg' => '转账成功!'
            ]);
        }catch (\Exception $e){
            DB::rollBack();
            return $response->withJson([
                'ret' => 0,
                'msg' => '转账失败!'.$e->getMessage()
            ]);
        }
    }
    /**
     * @param Request $request
     * @param Response $response
     * @param array $args
     */
    public function cancelSettle($request, $response, $args)
    {
        $billId = $request->getParam('bill_id',0 );
        if(empty($billId)){
            return $response->withJson([
                'ret' => 0,
                'msg' => '参数不正确!'
            ]);
        }
        $bill = AgentBill::find($billId);
        if(empty($bill)){
            return $response->withJson([
                'ret' => 0,
                'msg' => '结算不存在!'
            ]);
        }
        if($bill->status != 'NORMAL'){
            return $response->withJson([
                'ret' => 0,
                'msg' => '结算状态异常!'
            ]);
        }
        if($this->user->is_finance != 1 || $this->user->is_admin != 1){
            return $response->withJson([
                'ret' => 0,
                'msg' => '没有权限!'
            ]);
        }
        $wallet = AgentWallet::query()->where('user_id',$bill->agent_user_id)->first();
        if(empty($wallet)){
            return $response->withJson([
                'ret' => 0,
                'msg' => '钱包不存在!'
            ]);
        }
        $createdAt = new Carbon($bill->created_at);
        $createdAt->addMinutes(60);
        $nowDate = Carbon::now();
        if ($createdAt->lt($nowDate)) {
            return $response->withJson([
                'ret' => 0,
                'msg' => '超过1小时不能撤销了!'
            ]);
        }
        $amount = $bill->amount;
        DB::beginTransaction();
        try {
            $bill->status = 'CANCEL';
            $bill->updated_at = Carbon::now();
            $bill->canceled_at = Carbon::now();
            $bill->save();
            // 更新余额
            $result = AgentWallet::query()
                ->where('user_id', $bill->agent_user_id)
                ->update([
                    'settled_amount'=>DB::raw('settled_amount - '. $amount),
                    'balance'=>DB::raw('balance + '. $amount),
                    'updated_at'=>Carbon::now()
                ]);
            if(empty($result)){
                throw new \Exception("更新失败");
            }
            DB::commit();
            return $response->withJson([
                'ret' => 200,
                'msg' => '撤销成功!'
            ]);
        }catch (\Exception $e){
            DB::rollBack();
            return $response->withJson([
                'ret' => 0,
                'msg' => '撤销失败!'.$e->getMessage()
            ]);
        }
    }
    /**
     * @param Request $request
     * @param Response $response
     * @param array $args
     */
    public function transfer($request, $response, $args)
    {
        $agentId = $request->getQueryParam('agent_id', 0);
        if(empty($agentId)){
            throw new \Exception("参数不正确");
        }
        $agent = User::find($agentId);
        if(empty($agent)){
            throw new \Exception("用户不存在");
        }
        if($agent->is_agent != 1){
            throw new \Exception("代理不存在!");
        }
        $wallet = AgentWallet::query()->where('user_id',$agentId)->first();
        if(empty($wallet)){
            throw new \Exception("钱包不存在");
        }
        return $response->write(
            $this->view()
                ->assign('agent', $agent)
                ->assign('wallet', $wallet)
                ->display('admin/finance/transfer.tpl')
        );
    }
}
