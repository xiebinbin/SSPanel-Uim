<?php

namespace App\Controllers;

use App\Models\{User};
use Slim\Http\{Request, Response};

/**
 *  HomeController
 */
class AgentController extends BaseController
{
    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function setAgent($request, $response, $args)
    {
        $userId = trim($request->getParam('user_id'));
        if (empty($userId)) {
            return $response->withJson([
                'ret' => 0,
                'msg' => '非法输入'
            ]);
        }
        if ($this->user->is_agent != 1){
            return $response->withJson([
                'ret' => 0,
                'msg' => '您不是代理!'
            ]);
        }
        if ($this->user->agent_level != 1){
            return $response->withJson([
                'ret' => 0,
                'msg' => '代理登记不够!'
            ]);
        }
        $junior = User::find($userId);
        if(empty($junior)){
            return $response->withJson([
                'ret' => 0,
                'msg' => '用户不存在!'
            ]);
        }
        if ($junior->ref_by != $this->user->id){
            return $response->withJson([
                'ret' => 0,
                'msg' => '不是您的用户!'
            ]);
        }
        if ($junior->is_agent == 1){
            return $response->withJson([
                'ret' => 0,
                'msg' => '已经代理了!'
            ]);
        }
        $junior->is_agent = 1;
        $junior->agent_level = 2;
        $junior->save();
        return $response->withJson([
            'ret' => 1,
            'msg' => ''
        ]);
    }
    /**
     * @param Request   $request
     * @param Response  $response
     * @param array     $args
     */
    public function cancelAgent($request, $response, $args)
    {
        $userId = trim($request->getParam('user_id'));
        if (empty($userId)) {
            return $response->withJson([
                'ret' => 0,
                'msg' => '非法输入'
            ]);
        }
        if ($this->user->is_agent != 1){
            return $response->withJson([
                'ret' => 0,
                'msg' => '您不是代理!'
            ]);
        }
        if ($this->user->agent_level != 1){
            return $response->withJson([
                'ret' => 0,
                'msg' => '代理登记不够!'
            ]);
        }
        $junior = User::find($userId);
        if(empty($junior)){
            return $response->withJson([
                'ret' => 0,
                'msg' => '用户不存在!'
            ]);
        }
        if ($junior->ref_by != $this->user->id){
            return $response->withJson([
                'ret' => 0,
                'msg' => '不是您的用户!'
            ]);
        }
        if ($junior->is_agent == 0){
            return $response->withJson([
                'ret' => 0,
                'msg' => '不是代理了!'
            ]);
        }
        $junior->is_agent = 0;
        $junior->agent_level = 0;
        $junior->save();
        return $response->withJson([
            'ret' => 1,
            'msg' => ''
        ]);
    }
}
