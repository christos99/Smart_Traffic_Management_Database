-- mobile number of driver who commited the violation with id = 'SA9312IK54'

SELECT mobile_number AS 'mobile number of driver who commited violation SA9312IK54'
FROM (
		(
			SELECT Driver.id, Driver.mobile_number
			FROM Driver
		) AS _Driver
		JOIN
		(
			SELECT Violation.driver_id
			FROM Violation
			WHERE Violation.id = 'SA9312IK54'
		) AS _Violation
		ON _Driver.id = _Violation.driver_id
	)