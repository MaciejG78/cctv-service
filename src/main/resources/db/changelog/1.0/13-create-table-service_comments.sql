-- comments / communication on a service

CREATE TABLE service_comments
(
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    service_id  BIGINT      NOT NULL REFERENCES services (id) ON DELETE RESTRICT,
    author_id   BIGINT      NOT NULL REFERENCES users (id) ON DELETE RESTRICT,
    body        TEXT        NOT NULL,
    is_internal BOOLEAN     NOT NULL DEFAULT FALSE, -- visible only to ADMIN/TECHNICIAN
    -- audit
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_by  varchar(100),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_by  varchar(100),
    is_deleted  BOOLEAN     NOT NULL DEFAULT FALSE,
    deleted_at  TIMESTAMPTZ,
    deleted_by  varchar(100)
);

CREATE INDEX idx_service_comments_service ON service_comments (service_id, created_at);