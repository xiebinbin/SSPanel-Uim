CREATE TABLE IF NOT EXISTS `operation_logs` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `user_id` bigint(20) unsigned NOT NULL DEFAULT 0 COMMENT '运营 ID',
    `content` text NULL COMMENT '操作内容',
    `created_at` timestamp NULL COMMENT '创建时间',
    `updated_at` timestamp NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    key user_id(`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='运营日志';

ALTER TABLE `user` ADD COLUMN `is_operation` tinyint(1) NULL COMMENT "是否为运营" AFTER `is_finance`;
ALTER TABLE `announcement` ADD COLUMN `sort` int(11) NULL COMMENT "排序";
