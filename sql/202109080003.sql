ALTER TABLE `user` ADD COLUMN `is_agent` tinyint(1) NULL AFTER `is_admin`;
ALTER TABLE `user` ADD COLUMN `agent_level` tinyint(1) NULL AFTER `is_agent`;
