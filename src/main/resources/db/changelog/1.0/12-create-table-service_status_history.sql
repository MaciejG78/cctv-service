-- status change history

CREATE TABLE service_status_history
(
    id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    service_id  BIGINT      NOT NULL REFERENCES services (id) ON DELETE RESTRICT,
    from_status VARCHAR(30),
    to_status   VARCHAR(30) NOT NULL,
    comment     VARCHAR(1000),
    changed_at      TIMESTAMPTZ  NOT NULL DEFAULT now(),
    -- audit
    created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_by  varchar(100),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_by  varchar(100),
    is_deleted  BOOLEAN     NOT NULL DEFAULT FALSE,
    deleted_at  TIMESTAMPTZ,
    deleted_by  varchar(100),
    CONSTRAINT chk_ssh_to CHECK (to_status IN
                                 ('NEW', 'ACCEPTED', 'UNDER_VERIFICATION', 'UNDER_REPAIR', 'RESOLVED', 'CANCELLED')),
    CONSTRAINT chk_ssh_from CHECK (from_status IS NULL OR from_status IN
                                                          ('NEW', 'ACCEPTED', 'UNDER_VERIFICATION', 'UNDER_REPAIR', 'RESOLVED', 'CANCELLED'))
);

CREATE INDEX idx_ssh_service ON service_status_history (service_id, changed_at);