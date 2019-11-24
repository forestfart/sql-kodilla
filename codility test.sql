-- write your code in PostgreSQL 9.4
SELECT t2.id, t2.title, COALESCE(t1.sold_tickets, 0) FROM
    (SELECT movie_id, SUM(number_of_tickets)  AS sold_tickets FROM reservations
    GROUP BY movie_id) t1
FULL JOIN movies t2 ON t1.movie_id = t2.id
ORDER BY sold_tickets = 0, t1.sold_tickets DESC, t2.id ASC;


-- write your code in PostgreSQL 9.4
SELECT DISTINCT(joined.name),
    (SELECT COUNT(test_cases.group_name)
        FROM test_cases
        WHERE joined.name=group_name) AS all_test_cases,
    (SELECT COUNT(test_cases.group_name)
        FROM test_cases
        WHERE joined.name=group_name AND test_cases.status='OK') AS passed_test_cases,
    joined.test_value * (SELECT COUNT(test_cases.group_name)
        FROM test_cases
        WHERE joined.name=group_name AND test_cases.status='OK') AS total_value
FROM (SELECT test_groups.name,
        test_cases.group_name,
        test_cases.status,
        test_value
    FROM test_groups
    FULL OUTER JOIN test_cases ON test_cases.group_name=test_groups.name
    ORDER BY test_cases.group_name) joined
ORDER BY total_value DESC, joined.name ASC