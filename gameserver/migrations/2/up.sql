-- 插入示例数据
-- 插入draw-question
INSERT INTO draw_question (answer, tips) VALUES
('小鸡', '2个字，动物'),
('小鸡吃米图', '5个字，名画'),
('凤凰神鸟图', '5个字，也是名画');


-- 插入用户
INSERT INTO users (username, password, email) VALUES
('admin', 'admin123', 'admin@example.com'),
('user1', 'pass123', 'user1@example.com'),
('user2', 'pass456', 'user2@example.com');

-- 插入角色
INSERT INTO roles (role_name, description) VALUES
('管理员', '系统管理员，拥有所有权限'),
('编辑', '可以编辑和发布内容'),
('访客', '只有查看权限');

-- 插入权限
INSERT INTO permissions (permission_name, description) VALUES
('创建用户', '创建新用户账号的权限'),
('编辑用户', '编辑现有用户信息的权限'),
('删除用户', '删除用户账号的权限'),
('查看内容', '查看系统内容的权限'),
('编辑内容', '编辑系统内容的权限'),
('发布内容', '发布新内容的权限');

-- 关联用户和角色
INSERT INTO user_roles (user_id, role_id) VALUES
(1, 1),  -- admin 是管理员
(2, 2),  -- user1 是编辑
(3, 3),  -- user2 是访客
(2, 3);  -- user1 同时也是访客

-- 关联角色和权限
INSERT INTO role_permissions (role_id, permission_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6),  -- 管理员拥有所有权限
(2, 4), (2, 5), (2, 6),  -- 编辑可以查看、编辑和发布内容
(3, 4);  -- 访客只能查看内容