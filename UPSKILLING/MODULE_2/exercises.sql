-- Exercise 1

SELECT
    u.full_name,
    e.title,
    e.city,
    e.start_date
FROM Users u
JOIN Registrations r ON u.user_id = r.user_id
JOIN Events e ON r.event_id = e.event_id
WHERE e.status = 'upcoming'
    AND e.city = u.city
ORDER BY e.start_date;

-- Exercise 2

SELECT
    e.event_id,
    e.title,
    AVG(f.rating) AS average_rating,
    COUNT(f.feedback_id) AS feedback_count
FROM Events e
JOIN Feedback f
    ON e.event_id = f.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(f.feedback_id) >= 10
ORDER BY average_rating DESC;

-- Exercise 3

SELECT
    u.user_id,
    u.full_name,
    u.email
FROM Users u
WHERE NOT EXISTS (
    SELECT 1
    FROM Registrations r
    WHERE r.user_id = u.user_id
        AND r.registration_date >= CURDATE() - INTERVAL 90 DAY
);

-- Exercise 4

SELECT
    e.event_id,
    e.title,
    COUNT(s.session_id) AS session_count
FROM Events e
JOIN Sessions s
    ON e.event_id = s.event_id
WHERE TIME(s.start_time) < '12:00:00'
    AND TIME(s.end_time) > '10:00:00'
GROUP BY e.event_id, e.title;

-- Exercise 5

SELECT
    u.city,
    COUNT(DISTINCT r.user_id) AS total_registrations
FROM Users u
JOIN Registrations r
    ON u.user_id = r.user_id
GROUP BY u.city
ORDER BY total_registrations DESC
LIMIT 5;

-- Exercise 6

SELECT
    e.event_id,
    e.title,
    COUNT(CASE WHEN r.resource_type = 'pdf' THEN 1 END) AS pdf_count,
    COUNT(CASE WHEN r.resource_type = 'image' THEN 1 END) AS image_count,
    COUNT(CASE WHEN r.resource_type = 'link' THEN 1 END) AS link_count
FROM Events e
LEFT JOIN Resources r
    ON e.event_id = r.event_id
GROUP BY e.event_id, e.title;

-- Exercise 7

SELECT
    u.full_name,
    f.comments,
    e.title AS event_name,
    f.rating
FROM Feedback f
JOIN Users u
    ON f.user_id = u.user_id
JOIN Events e
    ON f.event_id = e.event_id
WHERE f.rating < 3;

-- Exercise 8

SELECT
    e.event_id,
    e.title,
    COUNT(s.session_id) AS session_count
FROM Events e
LEFT JOIN Sessions s
    ON e.event_id = s.event_id
WHERE e.status = 'upcoming'
GROUP BY e.event_id, e.title;

-- Exercise 9

SELECT
    u.user_id,
    u.full_name,
    e.status,
    COUNT(e.event_id) AS total_events
FROM Users u
JOIN Events e
    ON u.user_id = e.organizer_id
GROUP BY u.user_id, u.full_name, e.status
ORDER BY u.full_name;

-- Exercise 10

SELECT
    e.event_id,
    e.title
FROM Events e
WHERE EXISTS (
    SELECT 1
    FROM Registrations r
    WHERE r.event_id = e.event_id
)
AND NOT EXISTS (
    SELECT 1
    FROM Feedback f
    WHERE f.event_id = e.event_id
);

-- Exercise 11

SELECT
    registration_date,
    COUNT(user_id) AS user_count
FROM Users
WHERE registration_date >= CURDATE() - INTERVAL 7 DAY
GROUP BY registration_date
ORDER BY registration_date;

-- Exercise 12

SELECT
    e.event_id,
    e.title,
    COUNT(s.session_id) AS session_count
FROM Events e
JOIN Sessions s
    ON e.event_id = s.event_id
GROUP BY e.event_id, e.title
HAVING COUNT(s.session_id) = (
    SELECT MAX(session_total)
    FROM (
        SELECT COUNT(session_id) AS session_total
        FROM Sessions
        GROUP BY event_id
    ) AS session_counts
);

-- Exercise 13

SELECT
    e.city,
    AVG(f.rating) AS average_rating
FROM Events e
JOIN Feedback f
    ON e.event_id = f.event_id
GROUP BY e.city;

-- Exercise 14

SELECT
    e.event_id,
    e.title,
    COUNT(r.registration_id) AS total_registrations
FROM Events e
JOIN Registrations r
    ON e.event_id = r.event_id
GROUP BY e.event_id, e.title
ORDER BY total_registrations DESC
LIMIT 3;

-- Exercise 15

SELECT
    s1.event_id,
    e.title AS event_name,
    s1.session_id AS session1_id,
    s1.title AS session1_title,
    s2.session_id AS session2_id,
    s2.title AS session2_title
FROM Sessions s1
JOIN Sessions s2
    ON s1.event_id = s2.event_id
    AND s1.session_id < s2.session_id
    AND s1.start_time < s2.end_time
    AND s1.end_time > s2.start_time
JOIN Events e
    ON s1.event_id = e.event_id;

-- Exercise 16

SELECT
    u.user_id,
    u.full_name,
    u.email,
    u.registration_date
FROM Users u
LEFT JOIN Registrations r
    ON u.user_id = r.user_id
WHERE u.registration_date >= CURDATE() - INTERVAL 30 DAY
    AND r.registration_id IS NULL;

-- Exercise 17

SELECT
    speaker_name,
    COUNT(session_id) AS total_sessions
FROM Sessions
GROUP BY speaker_name
HAVING COUNT(session_id) > 1;

-- Exercise 18

SELECT
    e.event_id,
    e.title
FROM Events e
LEFT JOIN Resources r
    ON e.event_id = r.event_id
WHERE r.resource_id IS NULL;

-- Exercise 19

SELECT
    e.event_id,
    e.title,
    COUNT(DISTINCT r.registration_id) AS total_registrations,
    AVG(f.rating) AS average_rating
FROM Events e
LEFT JOIN Registrations r
    ON e.event_id = r.event_id
LEFT JOIN Feedback f
    ON e.event_id = f.event_id
WHERE e.status = 'completed'
GROUP BY e.event_id, e.title;

-- Exercise 20

SELECT 
    u.user_id,
    u.full_name,
    COUNT(DISTINCT r.event_id) AS events_attended,
    COUNT(DISTINCT f.feedback_id) AS feedbacks_submitted
FROM Users u
LEFT JOIN Registrations r
    ON u.user_id = r.user_id
LEFT JOIN Feedback f
    ON u.user_id = f.user_id
GROUP BY u.user_id, u.full_name
ORDER BY events_attended DESC, feedbacks_submitted DESC;

-- Exercise 21

SELECT 
    u.user_id,
    u.full_name,
    COUNT(f.feedback_id) AS feedback_count
FROM Users u
JOIN Feedback f
    ON u.user_id = f.user_id
GROUP BY u.user_id, u.full_name
ORDER BY feedback_count DESC
LIMIT 5;

-- Exercise 22

SELECT 
    user_id,
    event_id,
    COUNT(*) AS registration_count
FROM Registrations
GROUP BY user_id, event_id
HAVING COUNT(*) > 1;

-- Exercise 23

SELECT 
    DATE_FORMAT(registration_date, '%Y-%m') AS month,
    COUNT(*) AS registration_count
FROM Registrations
WHERE registration_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY DATE_FORMAT(registration_date, '%Y-%m')
ORDER BY month;

-- Exercise 24

SELECT 
    e.event_id,
    e.title,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, s.start_time, s.end_time)), 2) AS avg_duration_minutes
FROM Events e
JOIN Sessions s
    ON e.event_id = s.event_id
GROUP BY e.event_id, e.title
ORDER BY avg_duration_minutes DESC;

-- Exercise 25

SELECT 
    e.event_id,
    e.title,
    e.city,
    e.start_date,
    e.status
FROM Events e
LEFT JOIN Sessions s
    ON e.event_id = s.event_id
WHERE s.session_id IS NULL;