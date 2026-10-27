-- Roles dictionary (mirrors enum Role in code: CLIENT, ADMIN, TECHNICIAN)
CREATE TABLE roles
(
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code        VARCHAR(30)  NOT NULL UNIQUE,
    name        VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    -- audit
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    created_by  BIGINT       REFERENCES users (id) ON DELETE SET NULL,
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_by  BIGINT       REFERENCES users (id) ON DELETE SET NULL,
    CONSTRAINT chk_roles_code CHECK (code IN ('CLIENT', 'ADMIN', 'TECHNICIAN'))
);