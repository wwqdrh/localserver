DELETE FROM draw_question;

-- 删除角色-权限关联
DELETE FROM role_permissions;
DELETE FROM sqlite_sequence WHERE name='role_permissions';

-- 删除用户-角色关联
DELETE FROM user_roles;
DELETE FROM sqlite_sequence WHERE name='user_roles';

-- 删除权限
DELETE FROM permissions;
DELETE FROM sqlite_sequence WHERE name='permissions';

-- 删除角色
DELETE FROM roles;
DELETE FROM sqlite_sequence WHERE name='roles';

-- 删除用户
DELETE FROM users;
DELETE FROM sqlite_sequence WHERE name='users';
