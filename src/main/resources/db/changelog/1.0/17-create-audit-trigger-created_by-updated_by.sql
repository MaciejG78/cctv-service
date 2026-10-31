-- audit trigger (created_at/by, updated_at/by)

CREATE OR REPLACE FUNCTION set_audit_fields() RETURNS trigger AS $$
DECLARE
    v_user_name VARCHAR := NULLIF(current_setting('app.current_user_name', true), '')::VARCHAR;
BEGIN
    IF TG_OP = 'INSERT' THEN
        NEW.created_at := now();
        NEW.created_by := COALESCE(v_user_name, NEW.created_by);
        NEW.updated_at := NEW.created_at;
        NEW.updated_by := NEW.created_by;
    ELSE
        NEW.created_at := OLD.created_at;      -- immutable
        NEW.created_by := OLD.created_by;
        NEW.updated_at := now();
        NEW.updated_by := COALESCE(v_user_name, NEW.updated_by);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE t TEXT;
BEGIN
    FOREACH t IN ARRAY ARRAY[
        'users','roles','user_roles','companies','locations','manufacturers',
        'equipment_dictionary','equipment','services','service_equipment',
        'service_status_history','service_comments','service_parts',
        'attachments','notifications'
    ] LOOP
        EXECUTE format(
            'CREATE TRIGGER trg_%1$s_audit BEFORE INSERT OR UPDATE ON %1$I
             FOR EACH ROW EXECUTE FUNCTION set_audit_fields()', t);
    END LOOP;
END $$;
