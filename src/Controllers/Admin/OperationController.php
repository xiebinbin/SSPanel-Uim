<?php

namespace App\Controllers\Admin;

use App\Controllers\AdminController;
use App\Models\{AgentWallet, User};
use App\Utils\Tools;
use Carbon\Carbon;
use Illuminate\Database\Capsule\Manager as DB;
use Slim\Http\{
    Request,
    Response
};

class OperationController extends AdminController
{
    /**
     * @param Request $request
     * @param Response $response
     * @param array $args
     */
    public function userInfo($request, $response, $args)
    {
        $id = $request->getParam('id',0);
        if (empty($id)) {
            throw new \Exception("参数不正确!");
        }
        $user = User::find($id);
        if (empty($user)){
            throw new \Exception("用户不存在!");
        }
        $superior = $user->ref_by_user();
        return $response->write(
            $this->view()
                ->assign('superior',$superior)
                ->assign('userInfo',$user)
                ->display('admin/operation/user/info.tpl')
        );
    }
    /**
     * @param Request $request
     * @param Response $response
     * @param array $args
     */
    public function userIndex($request, $response, $args)
    {

        $input = $request->getQueryParams();
        $pageNum = $input['page'] ?? 1;
        $userId = $input['user_id'] ?? '';
        $agentId = $input['agent_id'] ?? '';
        $role = intval($input['role'] ?? 0);
        $query = User::query();
        if(!empty($role)){
            if($role == 1){
                $query->where('is_agent', 1)->where('agent_level',1);
            }elseif($role==2){
                $query->where('is_agent', 1)->where('agent_level',2);
            }elseif($role==3){
                $query->where('is_agent', 0);
            }

        }
        if(!empty($userId)){
            $query->where('id', $userId);
        }
        if(!empty($agentId)){
            $query->where('ref_by', $agentId);
        }
        $users = $query->orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
        $users->setPath('/admin/operation/user/index');
        $render = Tools::paginate_render($users);
        return $this->view()
            ->assign('users', $users)
            ->assign('page', $pageNum)
            ->assign('user_id', $userId)
            ->assign('agent_id', $agentId)
            ->assign('render', $render)
            ->display('admin/operation/user/index.tpl');
    }
    /**
     * @param Request $request
     * @param Response $response
     * @param array $args
     */
    public function updateUserInfo($request, $response, $args)
    {
        $userId = $request->getParam('user_id', 0);
        $isAgent = intval($request->getParam('is_agent', 0));
        $refBy = intval($request->getParam('ref_by', 0));
        if(empty($userId)){
            return $response->withJson([
                'ret' => 0,
                'msg' => '参数不正确!'
            ]);
        }
        $user = User::find($userId);
        if(empty($user)){
            return $response->withJson([
                'ret' => 0,
                'msg' => '用户不存在!'
            ]);
        }
        $wallet = null;
        if($isAgent == 1){
            $wallet = AgentWallet::query()->where('user_id', $userId)->first();
        }
        DB::beginTransaction();
        try {
            // 构建订单
            $user->is_agent = $isAgent;
            if ($refBy > 0){
                $user->ref_by = $refBy;
            }
            $user->agent_level = empty($refBy) ? 1 : 2;
            if ($isAgent == 1 && empty($wallet)){
                // 生成钱包
                $agentWallet = new AgentWallet();
                $agentWallet->user_id = $user->id;
                $agentWallet->created_at = Carbon::now();
                $agentWallet->updated_at = Carbon::now();
                $agentWallet->save();
            }
            $user->save();
            DB::commit();
            return $response->withJson([
                'ret' => 200,
                'msg' => '设置成功!'
            ]);
        }catch (\Exception $e){
            DB::rollBack();
            return $response->withJson([
                'ret' => 0,
                'msg' => '设置失败!'.$e->getMessage()
            ]);
        }
    }
}
