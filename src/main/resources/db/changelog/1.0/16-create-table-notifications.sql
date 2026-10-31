-- notifications (respecting users.preferred_contact_method)

CREATE TABLE notifications
(
    id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id       BIGINT      NOT NULL REFERENCES users (id) ON DELETE RESTRICT,
    service_id    BIGINT      REFERENCES services (id) ON DELETE SET NULL,
    channel       VARCHAR(10) NOT NULL, -- same values as contact method
    subject       VARCHAR(255),
    body          TEXT        NOT NULL,
    status        VARCHAR(10) NOT NULL DEFAULT 'PENDING',
    sent_at       TIMESTAMPTZ,
    error_message VARCHAR(1000),
    -- audit
    created_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
    created_by   varchar(100),
    updated_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_by   varchar(100),
    is_deleted   BOOLEAN      NOT NULL DEFAULT FALSE,
    deleted_at   TIMESTAMPTZ,
    deleted_by   varchar(100),
    CONSTRAINT chk_notifications_channel CHECK (channel IN ('MOBILE', 'SMS', 'EMAIL', 'PHONE', 'POST')),
    CONSTRAINT chk_notifications_status CHECK (status IN ('PENDING', 'SENT', 'FAILED'))
);
CREATE INDEX idx_notifications_user ON notifications (user_id);
CREATE INDEX idx_notifications_status ON notifications (status) WHERE status = 'PENDING';