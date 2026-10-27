-- COMPANIES (customers) - owners of locations and equipment

CREATE TABLE companies
(
    id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name         VARCHAR(255) NOT NULL,
    tax_id       VARCHAR(30),
    email        CITEXT,
    phone        VARCHAR(30),
    street       VARCHAR(255),
    building_no  VARCHAR(20),
    apartment_no VARCHAR(20),
    postal_code  VARCHAR(20),
    city         VARCHAR(100),
    country_code CHAR(2)      NOT NULL DEFAULT 'PL',
    is_active    BOOLEAN      NOT NULL DEFAULT TRUE,
    -- audit
    created_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
    created_by   BIGINT       REFERENCES users (id) ON DELETE SET NULL,
    updated_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_by   BIGINT       REFERENCES users (id) ON DELETE SET NULL
);
CREATE UNIQUE INDEX uq_companies_tax_id ON companies (tax_id) WHERE tax_id IS NOT NULL;

ALTER TABLE users
    ADD CONSTRAINT fk_users_company FOREIGN KEY (company_id)
        REFERENCES companies (id);