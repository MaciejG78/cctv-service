-- Roles dictionary (mirrors enum Role in code: CLIENT, ADMIN, TECHNICIAN)
CREATE TABLE roles
(
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code        VARCHAR(30)  NOT NULL UNIQUE,
    name        VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    -- audit
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    created_by  BIGINT REFERENCES users (id) ON DELETE RESTRICT,
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_by  BIGINT REFERENCES users (id) ON DELETE RESTRICT,
    is_deleted  BOOLEAN      NOT NULL DEFAULT FALSE,
    deleted_at  TIMESTAMPTZ,
    deleted_by  BIGINT REFERENCES users (id) ON DELETE RESTRICT,
    CONSTRAINT chk_roles_code CHECK (code IN ('CLIENT', 'ADMIN', 'TECHNICIAN'))
);