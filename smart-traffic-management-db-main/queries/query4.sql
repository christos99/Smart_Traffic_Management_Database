-- types of the Vehicles that are currently located in Area with id = 'THKE835612' and are heading to Area with id = 'THTO920993'

SELECT Vehicle.type AS 'types of the vehicles'
FROM Vehicle
WHERE current_area_id = 'THKE835612' AND destination_area_id =  'THTO920993'