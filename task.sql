-- 1
SELECT users.*
    FROM users
        LEFT JOIN (SELECT tasks.created_by_id, COUNT(*) AS is_done
    FROM tasks WHERE tasks.status = 'done' GROUP BY 1) as t1 ON (users.id = t1.created_by_id)
        LEFT JOIN (SELECT tasks.created_by_id, COUNT(*) AS not_done
    FROM tasks WHERE tasks.status != 'done' GROUP BY 1) as t2 ON (users.id = t2.created_by_id)
    WHERE t1.is_done > t2.not_done;
-- 1.1
SELECT users.*
    FROM users
        LEFT JOIN tasks t ON users.id = t.created_by_id
    GROUP BY users.id
    HAVING SUM(case when t.status = 'done' then 1 end) > SUM(case when t.status != 'done' then 1 end);
-- 2
SELECT users.*
    FROM users
        LEFT JOIN (
            SELECT tasks.created_by_id, tasks.assignee_id, COUNT(*) AS in_progress
                FROM tasks WHERE tasks.status = 'in progress' GROUP BY 1, 2) as t1 ON (users.id = t1.created_by_id)
WHERE t1.in_progress > 1 AND users.admin = true;