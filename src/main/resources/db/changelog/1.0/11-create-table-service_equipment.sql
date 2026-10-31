-- equipment covered by a given service (many-to-many)

CREATE TABLE service_equipment
(
    service_id        BIGINT      NOT NULL REFERENCES services (id) ON DELETE RESTRICT,
    equipment_id      BIGINT      NOT NULL REFERENCES equipment (id) ON DELETE RESTRICT,
    fault_description VARCHAR(4000),
    work_performed    VARCHAR(4000),
    -- audit
    created_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    created_by        varchar(100),
    updated_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_by        varchar(100),
    is_deleted        BOOLEAN     NOT NULL DEFAULT FALSE,
    deleted_at        TIMESTAMPTZ,
    deleted_by        varchar(100),
    PRIMARY KEY (service_id, equipment_id)
);
CREATE INDEX idx_service_equipment_eq ON service_equipment (equipment_id);
