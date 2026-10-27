-- Concrete equipment units installed at locations

CREATE TABLE equipment
(
    id                      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    equipment_dictionary_id BIGINT       NOT NULL REFERENCES equipment_dictionary (id) ON DELETE RESTRICT,
    company_id              BIGINT       NOT NULL REFERENCES companies (id) ON DELETE RESTRICT,
    location_id             BIGINT       REFERENCES locations (id) ON DELETE RESTRICT,
    parent_equipment_id     BIGINT       REFERENCES equipment (id) ON DELETE RESTRICT, -- camera -> switch/recorder
    name                    VARCHAR(150),                                              -- e.g. "Entrance camera 1"
    serial_number           VARCHAR(100) NOT NULL,
    inventory_number        VARCHAR(100),
    mac_address             MACADDR,
    ip_address              INET,
    firmware_version        VARCHAR(50),
    operational_status      VARCHAR(20)  NOT NULL DEFAULT 'ACTIVE',
    installed_at            DATE,
    warranty_end_date       DATE,
    last_service_date       DATE,
    notes                   VARCHAR(2000),
    -- audit
    created_at              TIMESTAMPTZ  NOT NULL DEFAULT now(),
    created_by              BIGINT REFERENCES users (id) ON DELETE RESTRICT,
    updated_at              TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_by              BIGINT REFERENCES users (id) ON DELETE RESTRICT,
    is_deleted              BOOLEAN      NOT NULL DEFAULT FALSE,
    deleted_at              TIMESTAMPTZ,
    deleted_by              BIGINT REFERENCES users (id) ON DELETE RESTRICT,
    CONSTRAINT chk_equipment_status CHECK (operational_status IN
                                           ('ACTIVE', 'INACTIVE', 'FAULTY', 'DECOMMISSIONED')),
    CONSTRAINT chk_equipment_parent CHECK (parent_equipment_id IS NULL OR parent_equipment_id <> id),
    CONSTRAINT uq_equipment_serial UNIQUE (equipment_dictionary_id, serial_number)
);
CREATE INDEX idx_equipment_company ON equipment (company_id);
CREATE INDEX idx_equipment_location ON equipment (location_id);
CREATE INDEX idx_equipment_parent ON equipment (parent_equipment_id);
CREATE INDEX idx_equipment_warranty ON equipment (warranty_end_date);