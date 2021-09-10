CREATE TABLE IF NOT EXISTS `agent_wallets` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '代理 ID',
    `balance` decimal(10, 2)  NOT NULL DEFAULT 0.0 COMMENT '余额',
    `settled_amount` decimal(10, 2)  NOT NULL DEFAULT 0.0 COMMENT '已结算额',
    `sum_sale_amount` decimal(10, 2)  NOT NULL DEFAULT 0.0 COMMENT '总销售额',
    `now_month_sale_amount` decimal(10, 2)  NOT NULL DEFAULT 0.0 COMMENT '当月销售额',
    `yesterday_sale_amount` decimal(10, 2)  NOT NULL DEFAULT 0.0 COMMENT '昨日销售额',
    `today_sale_amount` decimal(10, 2)  NOT NULL DEFAULT 0.0 COMMENT '今日销售额',
    `created_at` timestamp NULL COMMENT '创建时间',
    `updated_at` timestamp NULL COMMENT '更新时间',
    `sale_amount_last_updated_at` timestamp NULL COMMENT '销售额最后更新时间',
    PRIMARY KEY (`id`),
    key user_id(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代理钱包表';

CREATE TABLE IF NOT EXISTS `agent_bills` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `agent_user_id` bigint(20) unsigned NOT NULL COMMENT '代理商 ID',
    `user_id` bigint(20) unsigned NOT NULL COMMENT '用户 ID',
    `amount` decimal(10, 2)  NOT NULL COMMENT '金额',
    `remark` text COMMENT '备注',
    `flow` enum('NORMAL', 'INPUT', 'OUTPUT') DEFAULT 'NORMAL' COMMENT '资金流向 NORMAL默认 INPUT存入 OUTPUT取出',
    `created_at` timestamp NULL COMMENT '创建时间',
    `updated_at` timestamp NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    key user_id(`user_id`),
    key agent_user_id(`agent_user_id`),
    key flow(`flow`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='代理账单表';
ALTER TABLE `user` ADD COLUMN `is_finance` tinyint(1) NULL AFTER `is_agent`;
