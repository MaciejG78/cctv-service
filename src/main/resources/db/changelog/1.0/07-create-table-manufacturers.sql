-- manufacturers for equipment

CREATE TABLE manufacturers
(
    id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name          VARCHAR(150) NOT NULL UNIQUE,
    website       VARCHAR(255),
    support_email CITEXT,
    support_phone VARCHAR(30),
    -- audit
    created_at    TIMESTAMPTZ  NOT NULL DEFAULT now(),
    created_by    varchar(100),
    updated_at    TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_by    varchar(100),
    is_deleted    BOOLEAN      NOT NULL DEFAULT FALSE,
    deleted_at    TIMESTAMPTZ,
    deleted_by    varchar(100)
);