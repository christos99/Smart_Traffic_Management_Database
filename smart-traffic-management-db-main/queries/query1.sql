-- locations of empty parking slots in 'Faliro'

SELECT location AS 'empty parking slots locations in Faliro'
FROM (
		(
			SELECT Area.id
			FROM Area
			WHERE Area.name = 'Faliro'
		 ) AS _Area
		 JOIN
		 (
			SELECT Parking_slot.area_id, Parking_slot.location
			FROM Parking_slot
			WHERE Parking_slot.status = 'EMPTY'
		 ) AS _Parking_slot
		 ON _Area.id = _Parking_slot.area_id
	 ) 
     