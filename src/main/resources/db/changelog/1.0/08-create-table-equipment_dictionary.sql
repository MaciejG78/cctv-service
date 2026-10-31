-- dictionary of equipment models (dictionary equipment)

CREATE TABLE equipment_dictionary
(
    id              BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    manufacturer_id BIGINT       NOT NULL REFERENCES manufacturers (id) ON DELETE RESTRICT,
    equipment_type  VARCHAR(50)  NOT NULL,                     -- enum EquipmentType in code
    model_name      VARCHAR(150) NOT NULL,
    part_number     VARCHAR(100),
    description     VARCHAR(1000),
    specification   JSONB        NOT NULL DEFAULT '{}'::jsonb, -- resolution, lens, ports, PoE...
    warranty_months INTEGER,
    is_active       BOOLEAN      NOT NULL DEFAULT TRUE,
    -- audit
    created_at      TIMESTAMPTZ  NOT NULL DEFAULT now(),
    created_by      varchar(100),
    updated_at      TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_by      varchar(100),
    is_deleted      BOOLEAN      NOT NULL DEFAULT FALSE,
    deleted_at      TIMESTAMPTZ,
    deleted_by      varchar(100),
    CONSTRAINT chk_eqdict_type CHECK (equipment_type IN
                                      ('CAMERA', 'MONITOR', 'SERVER', 'SWITCH', 'ROUTER', 'ACCESS_POINT', 'OTHER')),
    CONSTRAINT chk_eqdict_warranty CHECK (warranty_months IS NULL OR warranty_months >= 0),
    CONSTRAINT uq_eqdict_model UNIQUE (manufacturer_id, model_name)
);
CREATE INDEX idx_eqdict_type ON equipment_dictionary (equipment_type);