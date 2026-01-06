INSERT INTO roles (name) VALUES ('ROLE_USER'), ('ROLE_ADMIN') ON CONFLICT (name) DO NOTHING;

INSERT INTO room_types (name, capacity, description)
VALUES ('Standard Room', 2, 'Cozy room with rustic wood decor.'),
       ('Deluxe Double Room', 2, 'Spacious room with private jacuzzi.'),
       ('Grand Mountain Suite', 4, 'Large luxury suite with mountain views.')
ON CONFLICT (name) DO NOTHING;

INSERT INTO amenities (name) VALUES ('WiFi'), ('TV'), ('Mini Bar'), ('AC')
ON CONFLICT (name) DO NOTHING;

INSERT INTO properties (name, address, city, country, description)
SELECT 'Pine Mountain Lodge', '742 Silver Pine Ridge', 'Timberline Peaks', 'Switzerland', 'An upscale mountain retreat offering cozy accommodations, stunning panoramic views, and direct access to outdoor adventures. Your home away from home in the mountains.'
WHERE NOT EXISTS (SELECT 1 FROM properties WHERE name = 'Grand Central Hotel');

INSERT INTO users (first_name, last_name, email, password, role_id)
SELECT 'admin', 'admin', 'admin@hotel.com', '$2a$12$QtamT9jty5/Eg0u5nkos9uEmn9JeawTHVstNOTGjFizak00wlLXU6', 2
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'admin@hotel.com');

INSERT INTO rooms (room_number, price_per_night, description, property_id, room_type_id)
VALUES
    ('101', 150.00, 'A charming mountain retreat featuring handcrafted wooden furniture, warm ambient lighting, and large windows offering a serene forest view.', 1, 1),
    ('102', 280.00, 'Premium double room blending rustic stone architecture with modern luxury, including a cozy fireplace, private jacuzzi, and a balcony overlooking the peaks.', 1, 2),
    ('201', 450.00, 'Our signature grand suite featuring an expansive living area, floor-to-ceiling panoramic windows, high timber ceilings, and bespoke mountain-inspired decor.', 1, 3)
ON CONFLICT DO NOTHING;

INSERT INTO room_images (room_id, url)
VALUES
    (1, 'https://res.cloudinary.com/dmzksxrlb/image/upload/v1767703071/standard_room_1_t89yqb.png'),
    (1, 'https://res.cloudinary.com/dmzksxrlb/image/upload/v1767703069/standard_room_2_z1xcls.png'),
    (1, 'https://res.cloudinary.com/dmzksxrlb/image/upload/v1767703072/standard_room_3_bx6yt1.png'),

    (2, 'https://res.cloudinary.com/dmzksxrlb/image/upload/v1767703262/double_1_roaqia.png'),
    (2, 'https://res.cloudinary.com/dmzksxrlb/image/upload/v1767703262/double_2_aqxsyi.png'),
    (2, 'https://res.cloudinary.com/dmzksxrlb/image/upload/v1767703260/double_3_okg23o.png'),

    (3, 'https://res.cloudinary.com/dmzksxrlb/image/upload/v1767703317/suite_1_aq02v9.png'),
    (3, 'https://res.cloudinary.com/dmzksxrlb/image/upload/v1767703317/suite_2_dcxpi4.png'),
    (3, 'https://res.cloudinary.com/dmzksxrlb/image/upload/v1767703317/suite_3_wlf7yd.png');

INSERT INTO room_amenities (room_id, amenity_id) VALUES (1, 1), (1, 2) ON CONFLICT DO NOTHING;
INSERT INTO room_amenities (room_id, amenity_id) VALUES (2, 1), (2, 2), (2, 4) ON CONFLICT DO NOTHING;
INSERT INTO room_amenities (room_id, amenity_id) VALUES (3, 1), (3, 2), (3, 3), (3, 4) ON CONFLICT DO NOTHING;

INSERT INTO reservations (check_in_date, check_out_date, status, total_price, user_id, room_id)
SELECT '2026-02-10', '2026-02-15', 'CONFIRMED', 1400.00, 1, 2
WHERE NOT EXISTS (SELECT 1 FROM reservations WHERE user_id = 1 AND room_id = 2);
