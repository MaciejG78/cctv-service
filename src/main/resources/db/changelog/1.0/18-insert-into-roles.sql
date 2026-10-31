-- seed data

INSERT INTO roles (code, name, description)
VALUES ('CLIENT', 'Client', 'Customer reporting and tracking service requests'),
       ('ADMIN', 'Administrator', 'Full access to the system'),
       ('TECHNICIAN', 'Technician', 'Performs service work on equipment');
