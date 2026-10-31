-- user roles - table for Many-to-Many connections between users and roles

CREATE TABLE user_roles
(
    user_id    BIGINT      NOT NULL REFERENCES users (id) ON DELETE RESTRICT,
    role_id    BIGINT      NOT NULL REFERENCES roles (id) ON DELETE RESTRICT,
    -- audit
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_by varchar(100),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_by varchar(100),
    is_deleted BOOLEAN     NOT NULL DEFAULT FALSE,
    deleted_at TIMESTAMPTZ,
    deleted_by varchar(100),
    PRIMARY KEY (user_id, role_id)
);

CREATE INDEX idx_user_roles_role ON user_roles (role_id);