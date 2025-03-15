-- [你画我猜]-问题表
CREATE TABLE IF NOT EXISTS draw_question (
    id INTEGER PRIMARY KEY,
    answer TEXT NOT NULL UNIQUE,
    tips TEXT NOT NULL
);

-- 用户表
CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    avatar TEXT,
    email TEXT UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 角色表
CREATE TABLE IF NOT EXISTS roles (
    role_id INTEGER PRIMARY KEY,
    role_name TEXT NOT NULL UNIQUE,
    description TEXT
);

-- 权限表
CREATE TABLE IF NOT EXISTS permissions (
    permission_id INTEGER PRIMARY KEY,
    permission_name TEXT NOT NULL UNIQUE,
    description TEXT
);

-- 用户-角色关联表（多对多）
CREATE TABLE IF NOT EXISTS user_roles (
    user_id INTEGER,
    role_id INTEGER,
    PRIMARY KEY (user_id, role_id)
);

-- 角色-权限关联表（多对多）
CREATE TABLE IF NOT EXISTS role_permissions (
    role_id INTEGER,
    permission_id INTEGER,
    PRIMARY KEY (role_id, permission_id)
);