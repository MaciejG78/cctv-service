-- LOCATIONS (with geolocation for map display)
-- If we upgrade Postgres with PostGIS we can use geometry type -> geometry(Point, 4326) + GIST index for radius query

CREATE TABLE locations
(
    id                 BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    company_id         BIGINT       NOT NULL REFERENCES companies (id) ON DELETE RESTRICT,
    parent_location_id BIGINT REFERENCES locations (id) ON DELETE RESTRICT, -- site > building > room
    name               VARCHAR(255) NOT NULL,
    description        VARCHAR(1000),
    street             VARCHAR(255),
    building_no        VARCHAR(20),
    apartment_no       VARCHAR(20),
    postal_code        VARCHAR(20),
    city               VARCHAR(100),
    country_code       CHAR(2)      NOT NULL DEFAULT 'PL',
    latitude           NUMERIC(9, 6),                                       -- WGS84
    longitude          NUMERIC(9, 6),
    contact_person     VARCHAR(200),
    contact_phone      VARCHAR(30),
    access_notes       VARCHAR(1000),
    is_active          BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at         TIMESTAMPTZ  NOT NULL DEFAULT now(),
    created_by         BIGINT REFERENCES users (id) ON DELETE RESTRICT,
    updated_at         TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_by         BIGINT REFERENCES users (id) ON DELETE RESTRICT,
    is_deleted         BOOLEAN      NOT NULL DEFAULT FALSE,
    deleted_at         TIMESTAMPTZ,
    deleted_by         BIGINT REFERENCES users (id) ON DELETE RESTRICT,
    CONSTRAINT chk_locations_lat CHECK (latitude IS NULL OR latitude BETWEEN -90 AND 90),
    CONSTRAINT chk_locations_lon CHECK (longitude IS NULL OR longitude BETWEEN -180 AND 180),
    CONSTRAINT chk_locations_latlon CHECK ((latitude IS NULL) = (longitude IS NULL)),
    CONSTRAINT chk_locations_parent CHECK (parent_location_id IS NULL OR parent_location_id <> id)
);
CREATE INDEX idx_locations_company ON locations (company_id);
CREATE INDEX idx_locations_parent ON locations (parent_location_id);
CREATE INDEX idx_locations_geo ON locations (latitude, longitude) WHERE latitude IS NOT NULL;