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
            if($user->is_finance == 0 && $user->is_operation==0){
                return $response->withStatus(302)->withHeader('Location', '/user');
            }
            if ($user->is_finance == 1 && !in_array($request->getUri()->getPath(),[
                '/admin/finance/base',
                '/admin/agent/index',
                '/admin/finance/settle/index',
                '/admin/finance/settle/info',
                '/admin/finance/transfer',
                '/admin/finance/settle/create',
                '/admin/finance/settle/cancel'
            ])) {
                return $response->withStatus(302)->withHeader('Location', '/admin/finance/base');
            }
            if ($user->is_operation == 1 && !in_array($request->getUri()->getPath(),[
                    '/admin/finance/base',
                    '/admin/agent/index',
                    '/admin/finance/settle/index',
                    '/admin/finance/settle/info',
                    '/admin/finance/settle/create',
                    '/admin/finance/settle/cancel',
                    '/admin/operation/user/index',
                    '/admin/operation/user/info',
                    '/admin/operation/user/update',
                ])) {
                return $response->withStatus(302)->withHeader('Location', '/admin/finance/base');
            }
        }
        return $next($request, $response);
    }
}
