<?php

namespace App\Models;

class AgentWallet extends Model
{
    protected $connection = 'default';
    protected $table = 'agent_wallets';

    public function getUser(): ?User
    {
        return User::find($this->attributes['user_id']);
    }
}
