-- attachments (photos, reports, manuals - metadata only, file in object storage)

CREATE TABLE attachments
(
    id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    service_id   BIGINT REFERENCES services (id) ON DELETE RESTRICT,
    equipment_id BIGINT REFERENCES equipment (id) ON DELETE RESTRICT,
    file_name    VARCHAR(255) NOT NULL,
    content_type VARCHAR(100) NOT NULL,
    size_bytes   BIGINT       NOT NULL,
    storage_key  VARCHAR(500) NOT NULL, -- path / key storage, disk etc.
    description  VARCHAR(500),
    -- audit
    created_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
    created_by   varchar(100),
    updated_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_by   varchar(100),
    is_deleted   BOOLEAN      NOT NULL DEFAULT FALSE,
    deleted_at   TIMESTAMPTZ,
    deleted_by   varchar(100),
    CONSTRAINT chk_attachments_owner CHECK (service_id IS NOT NULL OR equipment_id IS NOT NULL),
    CONSTRAINT chk_attachments_size CHECK (size_bytes >= 0)
);
CREATE INDEX idx_attachments_service ON attachments (service_id);
CREATE INDEX idx_attachments_equipment ON attachments (equipment_id);