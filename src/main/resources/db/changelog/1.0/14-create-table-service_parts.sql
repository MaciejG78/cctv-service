-- spare parts / materials used during a service

CREATE TABLE service_parts
(
    id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    service_id    BIGINT         NOT NULL REFERENCES services (id) ON DELETE RESTRICT,
    dictionary_id BIGINT         REFERENCES equipment_dictionary (id) ON DELETE SET NULL,
    description   VARCHAR(500)   NOT NULL,
    quantity      NUMERIC(10, 2) NOT NULL DEFAULT 1,
    unit_price    NUMERIC(12, 2),
    -- audit
    created_at    TIMESTAMPTZ    NOT NULL DEFAULT now(),
    created_by    varchar(100),
    updated_at    TIMESTAMPTZ    NOT NULL DEFAULT now(),
    updated_by    varchar(100),
    is_deleted    BOOLEAN        NOT NULL DEFAULT FALSE,
    deleted_at    TIMESTAMPTZ,
    deleted_by    varchar(100),
    CONSTRAINT chk_service_parts_qty CHECK (quantity > 0),
    CONSTRAINT chk_service_parts_price CHECK (unit_price IS NULL OR unit_price >= 0)
);
CREATE INDEX idx_service_parts_service ON service_parts (service_id);
