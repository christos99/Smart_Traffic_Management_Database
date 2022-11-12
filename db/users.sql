-- users

DROP USER IF EXISTS 'admin'@'%';
CREATE USER 'admin'@'%' IDENTIFIED BY '12345';
GRANT ALL PRIVILEGES ON stm.* TO 'admin'@'%';

DROP USER IF EXISTS 'user'@'%';
CREATE USER 'user'@'%' IDENTIFIED BY '12345';
GRANT SELECT, INSERT, UPDATE ON stm.driver TO 'user'@'%';
GRANT SELECT, INSERT, UPDATE ON stm.vehicle TO 'user'@'%';
GRANT SELECT ON stm.route TO 'user'@'%';
GRANT SELECT ON stm.route_area TO 'user'@'%';
GRANT SELECT ON stm.area TO 'user'@'%';
GRANT SELECT ON stm.tolls TO 'user'@'%';
GRANT SELECT ON stm.`empty parking slots` TO 'user'@'%';
GRANT SELECT ON stm.`violators` TO 'user'@'%';

DROP USER IF EXISTS 'officer'@'%';
CREATE USER 'officer'@'%' IDENTIFIED BY '12345';
GRANT SELECT, INSERT, UPDATE, DELETE ON stm.violation TO 'officer'@'%';
GRANT SELECT ON stm.driver TO 'officer'@'%';
GRANT SELECT ON stm.vehicle TO 'officer'@'%';
GRANT SELECT ON stm.`violators` TO 'officer'@'%';

DROP USER IF EXISTS 'sensor'@'%';
CREATE USER 'sensor'@'%' IDENTIFIED BY '12345';
GRANT UPDATE(current_area_id) ON stm.vehicle TO 'sensor'@'%';
GRANT UPDATE(status) ON stm.parking_slot TO 'sensor'@'%';
GRANT UPDATE(status) ON stm.traffic_light TO 'sensor'@'%';
GRANT INSERT ON stm.violation TO 'sensor'@'%';

DROP USER IF EXISTS 'cloud'@'%';
CREATE USER 'cloud'@'%' IDENTIFIED BY '12345';
GRANT SELECT(current_area_id, destination_area_id, type) ON stm.vehicle TO 'cloud'@'%';
GRANT SELECT ON stm.area TO 'cloud'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON stm.route TO 'cloud'@'%';
GRANT SELECT ON stm.parking_slot TO 'cloud'@'%';
GRANT SELECT ON stm.traffic_light TO 'cloud'@'%';
GRANT SELECT ON stm.tolls TO 'cloud'@'%';
GRANT SELECT ON stm.neighboring_areas TO 'cloud'@'%';
GRANT SELECT, INSERT, DELETE ON stm.route_area TO 'cloud'@'%';
GRANT SELECT ON stm.`vehicle types per area` TO 'cloud'@'%';
GRANT SELECT ON stm.`empty parking slots` TO 'cloud'@'%';