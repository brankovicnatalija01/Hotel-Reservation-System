INSERT INTO roles (name) VALUES ('ROLE_USER'), ('ROLE_ADMIN') ON CONFLICT (name) DO NOTHING;

INSERT INTO room_types (name, capacity, description)
VALUES ('Standard Single', 1, 'Cozy room for one person'),
       ('Deluxe Double', 2, 'Spacious room for couples')
ON CONFLICT (name) DO NOTHING;

INSERT INTO amenities (name) VALUES ('WiFi'), ('TV'), ('Mini Bar'), ('AC')
ON CONFLICT (name) DO NOTHING;

INSERT INTO properties (name, address, city, country, description)
SELECT 'Pine Mountain Lodge', 'Zlatiborska 5', 'Zlatibor', 'Serbia', 'An upscale mountain retreat offering cozy accommodations, stunning panoramic views, and direct access to outdoor adventures. Your home away from home in the mountains.'
WHERE NOT EXISTS (SELECT 1 FROM properties WHERE name = 'Grand Central Hotel');

INSERT INTO users (first_name, last_name, email, password, role_id)
SELECT 'admin', 'admin', 'admin@hotel.com', '$2a$10$8.UnVuG9HHgffUDAlk8qfOuVGkqRzgVymGe07xd00DMxs.TVuHOnu', 2
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'admin@hotel.com');

INSERT INTO rooms (room_number, price_per_night, description, property_id, room_type_id)
VALUES
    ('101', 150.00, 'Cozy single room with a forest view.', 1, 1),
    ('102', 280.00, 'Deluxe double room with a stone fireplace and mountain view.', 1, 2),
    ('201', 450.00, 'Luxury suite with a private balcony and jacuzzi.', 1, 2)
ON CONFLICT DO NOTHING;

INSERT INTO room_amenities (room_id, amenity_id) VALUES (1, 1), (1, 2) ON CONFLICT DO NOTHING;
INSERT INTO room_amenities (room_id, amenity_id) VALUES (2, 1), (2, 2), (2, 4) ON CONFLICT DO NOTHING;
INSERT INTO room_amenities (room_id, amenity_id) VALUES (3, 1), (3, 2), (3, 3), (3, 4) ON CONFLICT DO NOTHING;

INSERT INTO reservations (check_in_date, check_out_date, status, total_price, user_id, room_id)
SELECT '2026-02-10', '2026-02-15', 'CONFIRMED', 1400.00, 1, 2
WHERE NOT EXISTS (SELECT 1 FROM reservations WHERE user_id = 1 AND room_id = 2);
