-- roles dictionary (mirrors enum Role in code: CLIENT, ADMIN, TECHNICIAN)

CREATE TABLE roles
(
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    code        VARCHAR(30)  NOT NULL UNIQUE,
    name        VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    -- audit
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    created_by  varchar(100),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_by  varchar(100),
    is_deleted  BOOLEAN      NOT NULL DEFAULT FALSE,
    deleted_at  TIMESTAMPTZ,
    deleted_by  varchar(100)
);