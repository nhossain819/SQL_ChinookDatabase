Database: https://cdn.sqlitetutorial.net/wp-content/uploads/2018/03/chinook.zip
Database Schema: https://cdn.sqlitetutorial.net/wp-content/uploads/2018/03/sqlite-sample-database-diagram-color.pdf

-- Find all invoices for the salesman who yielded the greatest profit.

SELECT *
FROM invoices AS i
	LEFT JOIN customers AS c
		ON i.CustomerId = c.CustomerId
	LEFT JOIN employees AS e
		ON e.EmployeeId = c.SupportRepId
WHERE e.EmployeeId =
	(
		WITH top_employee AS
		(
			SELECT e.EmployeeId
				, e.FirstName
				, e.LastName
				, SUM(i.total) as total_sales
			FROM invoices AS i
				LEFT JOIN customers AS c
					ON i.CustomerId = c.CustomerId
				LEFT JOIN employees AS e
					ON e.EmployeeId = c.SupportRepId
			GROUP BY e.EmployeeId
			ORDER BY total_sales DESC
			LIMIT 1
		)
		SELECT EmployeeId
		FROM top_employee
	)
;
