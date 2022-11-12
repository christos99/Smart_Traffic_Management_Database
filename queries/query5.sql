-- number of Vehicles that are currently located in Area with id = THKE835612, but are not motorcycles

SELECT COUNT(licence_plate) AS 'number of vehicle'
FROM Vehicle
WHERE current_area_id = 'THKE835612' AND type != 'MOTORCYCLE'