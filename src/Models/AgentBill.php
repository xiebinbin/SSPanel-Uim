<?php

namespace App\Models;

class AgentBill extends Model
{
    protected $connection = 'default';
    protected $table = 'agent_bills';

    public function getUser(): ?User
    {
        return User::find($this->attributes['user_id']);
    }
    public function getAgent(): ?User
    {
        return User::find($this->attributes['agent_user_id']);
    }
}
