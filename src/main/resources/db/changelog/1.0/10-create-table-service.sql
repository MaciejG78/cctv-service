-- services (service requests / tickets)

CREATE SEQUENCE service_number_seq;

CREATE TABLE services
(
    id                     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    service_number         VARCHAR(30)  NOT NULL UNIQUE
                                                 DEFAULT ('SRV-' || to_char(now(), 'YYYY') || '-' ||
                                                          lpad(nextval('service_number_seq')::text, 6, '0')),
    company_id             BIGINT       NOT NULL REFERENCES companies (id) ON DELETE RESTRICT,
    location_id            BIGINT REFERENCES locations (id) ON DELETE RESTRICT,
    requester_id           BIGINT       NOT NULL REFERENCES users (id) ON DELETE RESTRICT, -- CLIENT who reported
    assigned_technician_id BIGINT       REFERENCES users (id) ON DELETE SET NULL,          -- TECHNICIAN
    service_type           VARCHAR(20)  NOT NULL DEFAULT 'REPAIR',
    status                 VARCHAR(30)  NOT NULL DEFAULT 'NEW',
    priority               VARCHAR(10)  NOT NULL DEFAULT 'NORMAL',
    title                  VARCHAR(255) NOT NULL,
    description            TEXT,
    resolution_notes       TEXT,
    reported_at            TIMESTAMPTZ  NOT NULL DEFAULT now(),
    scheduled_at           TIMESTAMPTZ,
    started_at             TIMESTAMPTZ,
    resolved_at            TIMESTAMPTZ,
    cancelled_at           TIMESTAMPTZ,
    cancellation_reason    VARCHAR(1000),
    -- audit
    created_at             TIMESTAMPTZ  NOT NULL DEFAULT now(),
    created_by             varchar(100),
    updated_at             TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_by             varchar(100),
    is_deleted             BOOLEAN      NOT NULL DEFAULT FALSE,
    deleted_at             TIMESTAMPTZ,
    deleted_by             varchar(100),
    CONSTRAINT chk_services_status CHECK (status IN
                                          ('NEW', 'ACCEPTED', 'UNDER_VERIFICATION', 'UNDER_REPAIR', 'RESOLVED', 'CANCELLED')),
    CONSTRAINT chk_services_type CHECK (service_type IN
                                        ('REPAIR', 'MAINTENANCE', 'INSTALLATION', 'INSPECTION')),
    CONSTRAINT chk_services_priority CHECK (priority IN
                                            ('LOW', 'NORMAL', 'HIGH', 'CRITICAL')),
    CONSTRAINT chk_services_resolved CHECK (status <> 'RESOLVED' OR resolved_at IS NOT NULL),
    CONSTRAINT chk_services_cancelled CHECK (status <> 'CANCELLED' OR cancelled_at IS NOT NULL)
);

CREATE INDEX idx_services_company ON services (company_id);
CREATE INDEX idx_services_location ON services (location_id);
CREATE INDEX idx_services_requester ON services (requester_id);
CREATE INDEX idx_services_technician ON services (assigned_technician_id);
CREATE INDEX idx_services_status ON services (status);
CREATE INDEX idx_services_scheduled ON services (scheduled_at);