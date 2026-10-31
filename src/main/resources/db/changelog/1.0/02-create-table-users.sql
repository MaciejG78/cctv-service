-- users - application users

CREATE TABLE users
(
    id                       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    company_id               BIGINT,      -- FK added after companies is created
    login                    varchar(100) NOT NULL UNIQUE,
    email                    citext       NOT NULL UNIQUE,
    password_hash            VARCHAR(255) NOT NULL,
    first_name               VARCHAR(100) NOT NULL,
    last_name                VARCHAR(100) NOT NULL,
    phone                    VARCHAR(30), -- landline
    mobile_phone             VARCHAR(30), -- used for MOBILE / SMS
    notes                    TEXT,
    preferred_contact_method VARCHAR(10)  NOT NULL DEFAULT 'EMAIL',
    language_code            VARCHAR(5)   NOT NULL DEFAULT 'pl',
    is_active                BOOLEAN      NOT NULL DEFAULT TRUE,
    last_login_at            TIMESTAMPTZ,
    deactivated_at           TIMESTAMPTZ,
    -- audit
    created_at               TIMESTAMPTZ  NOT NULL DEFAULT now(),
    created_by               varchar(100),
    updated_at               TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_by               varchar(100),
    is_deleted               BOOLEAN      NOT NULL DEFAULT FALSE,
    deleted_at               TIMESTAMPTZ,
    deleted_by               varchar(100),
    CONSTRAINT chk_users_contact_method
        CHECK (preferred_contact_method IN ('MOBILE', 'SMS', 'EMAIL', 'PHONE', 'POST')),
    CONSTRAINT chk_users_contact_data CHECK (
        (preferred_contact_method NOT IN ('MOBILE', 'SMS') OR mobile_phone IS NOT NULL) AND
        (preferred_contact_method <> 'PHONE' OR (phone IS NOT NULL OR mobile_phone IS NOT NULL))
        )
);

CREATE INDEX idx_users_company ON users (company_id);
