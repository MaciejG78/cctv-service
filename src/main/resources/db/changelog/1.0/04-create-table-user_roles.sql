CREATE TABLE user_roles
(
    user_id    BIGINT      NOT NULL REFERENCES users (id) ON DELETE RESTRICT,
    role_id    BIGINT      NOT NULL REFERENCES roles (id) ON DELETE RESTRICT,
    -- audit
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_by BIGINT REFERENCES users (id) ON DELETE RESTRICT,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_by BIGINT REFERENCES users (id) ON DELETE RESTRICT,
    is_deleted BOOLEAN     NOT NULL DEFAULT FALSE,
    deleted_at TIMESTAMPTZ,
    deleted_by BIGINT REFERENCES users (id) ON DELETE RESTRICT,
    PRIMARY KEY (user_id, role_id)
);

CREATE INDEX idx_user_roles_role ON user_roles (role_id);