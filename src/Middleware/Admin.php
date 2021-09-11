<?php

namespace App\Middleware;

use App\Services\Auth as AuthService;

class Admin
{
    /**
     * @param \Slim\Http\Request    $request
     * @param \Slim\Http\Response   $response
     * @param callable              $next
     *
     * @return \Slim\Http\Response
     */
    public function __invoke($request, $response, $next)
    {
        $user = AuthService::getUser();
        if (!$user->isLogin) {
            return $response->withStatus(302)->withHeader('Location', '/auth/login');
        }
        if (!$user->is_admin) {
            if($user->is_finance == 0){
                return $response->withStatus(302)->withHeader('Location', '/user');
            }
            if (!in_array($request->getUri()->getPath(),[
                '/admin/finance/base',
                '/admin/agent/index'
            ])) {
                return $response->withStatus(302)->withHeader('Location', '/admin/finance/base');
            }
        }
        return $next($request, $response);
    }
}
