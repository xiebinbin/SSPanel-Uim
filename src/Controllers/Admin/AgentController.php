<?php

namespace App\Controllers\Admin;

use App\Controllers\AdminController;
use App\Utils\Tools;
use App\Models\{AgentWallet, User};

use Slim\Http\{
    Request,
    Response
};

class AgentController extends AdminController
{
    /**
     * @param Request $request
     * @param Response $response
     * @param array $args
     * @return Response
     */
    public function index($request, $response,$args)
    {
        $input = $request->getQueryParams();

        $pageNum = $input['page'] ?? 1;
        $keywords = $input['keywords'] ?? '';
        $userId = $input['user_id'] ?? 0;
        $query = User::query();
        $query->where('is_agent',1);

        if(!empty($keywords)){
            $query->where(function($query) use($keywords){
                $query->where('user_name', 'LIKE', "%{$keywords}%")->orWhere('email','LIKE', "%{$keywords}%");
            });
        }
        if(!empty($userId)){
            $query->where('id',$userId);
        }
        $agents = $query->orderBy('id', 'desc')->paginate(15, ['*'], 'page', $pageNum);
        $wallets= AgentWallet::query()->whereIn('user_id',array_column($agents->items(),'id'))->get();
        $wallets = $wallets->keyBy('user_id');
        foreach ($agents as &$agent){
            $agent->wallet = $wallets[$agent->id] ?? null;
        }
        $agents->setPath('/admin/agent/index');
        $render = Tools::paginate_render($agents);
        return $this->view()
            ->assign('user', $this->user)
            ->assign('agents', $agents)
            ->assign('page', $pageNum)
            ->assign('keywords', $keywords)
            ->assign('render', $render)
            ->display('admin/agent/index.tpl');
    }
    /**
     * @param Request $request
     * @param Response $response
     * @param array $args
     */
    public function info($request, $response, $args)
    {
        $agentId = $request->getQueryParam('id','');
        if(empty($agentId)){
            throw new \Exception("id不能为空");
        }
        $user = User::find($agentId);
        if (empty($user)) {
            throw new \Exception("用户不存在!");
        }
        $user = User::find($agentId);
        if ($user->is_agent != 1) {
            throw new \Exception("用户不是代理!");
        }
        $wallet = AgentWallet::where('user_id',$agentId)->first();
        return $response->write(
            $this->view()
                ->assign('agent', $user)
                ->assign('wallet', $wallet)
                ->display('admin/agent/info.tpl')
        );
    }
}
