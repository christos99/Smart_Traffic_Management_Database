DROP DATABASE IF EXISTS stm;
CREATE DATABASE IF NOT EXISTS stm;
USE stm;


-- create tables

CREATE TABLE Driver
	(id CHAR(10) NOT NULL,
	name VARCHAR(30) NOT NULL,
	age INT NOT NULL,
	gender ENUM('MALE', 'FEMALE') NOT NULL,
	mobile_number CHAR(10) NOT NULL UNIQUE,
	PRIMARY KEY (id));

CREATE TABLE Area 	           
	(id CHAR(10),
	name VARCHAR(30) NOT NULL,
	traffic_metric ENUM('VERY_LOW', 'LOW', 'MEDIUM', 'HIGH', 'VERY_HIGH'),
	PRIMARY KEY (id));
    
CREATE TABLE Route 	 		   
	(id CHAR(10),
	duration_in_min INT,
	PRIMARY KEY (id));
    
CREATE TABLE Vehicle 		   
	(licence_plate CHAR(10),
	type ENUM('CAR', 'MOTORCYCLE', 'TRUCK') NOT NULL,
	driver_id CHAR(10) NOT NULL,
	route_id CHAR(10),
	current_area_id CHAR(10),
	starting_area_id CHAR(10),
	destination_area_id CHAR(10),
	PRIMARY KEY (licence_plate, driver_id),
	FOREIGN KEY (driver_id) REFERENCES Driver(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (route_id) REFERENCES Route(id) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (current_area_id) REFERENCES Area(id) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (starting_area_id) REFERENCES Area(id) ON DELETE SET NULL ON UPDATE CASCADE,
	FOREIGN KEY (destination_area_id) REFERENCES Area(id) ON DELETE SET NULL ON UPDATE CASCADE);

CREATE TABLE Violation  	   
	(id CHAR(10),
	type ENUM('TRAFFIC_LIGHT', 'SPEED_LIMIT', 'TRAFFIC_SIGN'),
	fee_in_euros FLOAT,
	driver_id CHAR(10) NOT NULL,
	PRIMARY KEY (id, driver_id),
	FOREIGN KEY (driver_id) REFERENCES Driver(id) ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE Traffic_light 	   
	(id CHAR(10),
	status ENUM('GREEN', 'RED'),
	duration_in_sec INT,
	location CHAR(24) NOT NULL,
	area_id CHAR(10) NOT NULL,
	PRIMARY KEY (id, area_id),
	FOREIGN KEY (area_id) REFERENCES Area(id) ON DELETE CASCADE ON UPDATE CASCADE);
                        
CREATE TABLE Parking_slot 	   
	(id CHAR(10) NOT NULL UNIQUE,
	status ENUM('EMPTY', 'NOT_EMPTY'),
	location CHAR(24) NOT NULL,
	area_id CHAR(10) NOT NULL,
	PRIMARY KEY (id, area_id),
	FOREIGN KEY (area_id) REFERENCES Area(id) ON DELETE CASCADE ON UPDATE CASCADE);   
                           
CREATE TABLE Tolls 			   
	(id CHAR(10) NOT NULL UNIQUE,
	toll_in_euros FLOAT,
	location CHAR(24) NOT NULL,
	area_id CHAR(10) NOT NULL,
	PRIMARY KEY (id, area_id),
	FOREIGN KEY (area_id) REFERENCES Area(id) ON DELETE CASCADE ON UPDATE CASCADE);                           

CREATE TABLE Route_Area        
	(route_id CHAR(10),
	area_id CHAR(10),
	PRIMARY KEY (route_id, area_id),
	FOREIGN KEY (route_id) REFERENCES Route(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (area_id) REFERENCES Area(id) ON DELETE CASCADE ON UPDATE CASCADE);                  

CREATE TABLE Neighboring_Areas 
	(area1_id CHAR(10),
	area2_id CHAR(10),
	PRIMARY KEY (area1_id, area2_id),
	FOREIGN KEY (area1_id) REFERENCES Area(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (area2_id) REFERENCES Area(id) ON DELETE CASCADE ON UPDATE CASCADE);
    
    
-- create triggers
    
DELIMITER $$
CREATE TRIGGER `driver_BEFORE_INSERT` BEFORE INSERT ON `driver` FOR EACH ROW BEGIN
	IF NEW.age < 18 OR NEW.age > 100 THEN
		SIGNAL SQLSTATE '10000' SET MESSAGE_TEXT = 'Invalid driver age';
    END IF;
END $$
DELIMITER ;   

DELIMITER $$
CREATE TRIGGER `driver_BEFORE_UPDATE` BEFORE UPDATE ON `driver` FOR EACH ROW BEGIN
	IF NEW.age < 18 OR NEW.age > 100 THEN
		SIGNAL SQLSTATE '15000' SET MESSAGE_TEXT = 'Invalid driver age';
    END IF;
END  $$
DELIMITER ; 

DELIMITER $$
CREATE TRIGGER `violation_BEFORE_INSERT` BEFORE INSERT ON `violation` FOR EACH ROW BEGIN
	IF NEW.fee_in_euros < 0 THEN
		SIGNAL SQLSTATE '20000' SET MESSAGE_TEXT = 'Invalid violation fee';
    END IF;
END $$
DELIMITER ; 

DELIMITER $$
CREATE TRIGGER `violation_BEFORE_UPDATE` BEFORE UPDATE ON `violation` FOR EACH ROW BEGIN
	IF NEW.fee_in_euros < 0 THEN
		SIGNAL SQLSTATE '25000' SET MESSAGE_TEXT = 'Invalid violation fee';
    END IF;
END $$
DELIMITER ; 

DELIMITER $$
CREATE TRIGGER `route_BEFORE_INSERT` BEFORE INSERT ON `route` FOR EACH ROW BEGIN
	IF NEW.duration_in_min < 0 THEN
		SIGNAL SQLSTATE '30000' SET MESSAGE_TEXT = 'Invalid route duration';
    END IF;
END $$
DELIMITER ; 

DELIMITER $$
CREATE TRIGGER `route_BEFORE_UPDATE` BEFORE UPDATE ON `route` FOR EACH ROW BEGIN
	IF NEW.duration_in_min < 0 THEN
		SIGNAL SQLSTATE '35000' SET MESSAGE_TEXT = 'Invalid route duration';
    END IF;
END $$
DELIMITER ; 

DELIMITER $$
CREATE TRIGGER `tolls_BEFORE_INSERT` BEFORE INSERT ON `tolls` FOR EACH ROW BEGIN
	IF NEW.toll_in_euros < 0 THEN
		SIGNAL SQLSTATE '40000' SET MESSAGE_TEXT = 'Invalid toll';
    END IF;
END $$
DELIMITER ; 

DELIMITER $$
CREATE TRIGGER `tolls_BEFORE_UPDATE` BEFORE UPDATE ON `tolls` FOR EACH ROW BEGIN
	IF NEW.toll_in_euros < 0 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid toll';
    END IF;
END $$
DELIMITER ; 

DELIMITER $$
CREATE TRIGGER `neighboring_areas_BEFORE_INSERT` BEFORE INSERT ON `neighboring_areas` FOR EACH ROW BEGIN
	IF NEW.area1_id = NEW.area2_id THEN
		SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = 'Invalid neighboring areas';
    END IF;
END $$
DELIMITER ; 

DELIMITER $$
CREATE TRIGGER `neighboring_areas_BEFORE_UPDATE` BEFORE UPDATE ON `neighboring_areas` FOR EACH ROW BEGIN
	IF NEW.area1_id = NEW.area2_id THEN
		SIGNAL SQLSTATE '55000' SET MESSAGE_TEXT = 'Invalid neighboring areas';
    END IF;
END $$
DELIMITER ; 


-- create views

CREATE VIEW `Empty Parking Slots` AS
SELECT name AS 'area name', area_id AS 'area id', location AS 'parking location'
FROM (
		( 
			SELECT name, id
			FROM Area
		) AS _Area
		JOIN
		(
			SELECT area_id, location
			FROM Parking_slot
			WHERE status = 'EMPTY'
		) AS _Parking_slot
		ON _Area.id = _Parking_slot.area_id
     )
     ORDER BY _Area.name;
     
CREATE VIEW `Violators` AS
SELECT Driver.id AS 'driver id', Driver.name AS 'name', Driver.age AS 'age', Driver.gender AS 'gender', Driver.mobile_number AS 'mobile number', Violation.type AS 'violation type', Violation.fee_in_euros AS 'fee'
FROM (
		Driver
		JOIN
		Violation
		ON Driver.id = Violation.driver_id
     )
     ORDER BY Driver.id;
     
CREATE VIEW `Vehicle types per area` AS
SELECT Area.id AS 'area id', Area.name AS 'area name', Vehicle.type AS 'vehicle type' 
FROM
(
	Area JOIN Vehicle ON Area.id = Vehicle.current_area_id
) ORDER BY Area.name;

     
-- INSERT DATA

-- Area
INSERT INTO Area VALUES ('THKE835612', 'Center', 'VERY_HIGH');
INSERT INTO Area VALUES ('THPA237310', 'Panorama', 'LOW');
INSERT INTO Area VALUES ('THTO920993', 'Toumpa', 'HIGH');
INSERT INTO Area VALUES ('THFA021224', 'Faliro', 'MEDIUM');
INSERT INTO Area VALUES ('THPO651209', 'Polichni', 'VERY_LOW');

-- Route
INSERT INTO Route VALUES ('THPAFA3163', '20');
INSERT INTO Route VALUES ('THPOTO0912', '25');
INSERT INTO Route VALUES ('THKETO3441', '15');
INSERT INTO Route VALUES ('THPOPA0121', '30');
INSERT INTO Route VALUES ('THKEPO9884', '15');

-- Driver
INSERT INTO Driver VALUES ('AI05069901', 'Jim Brooks', '32', 'MALE', '6972461286');
INSERT INTO Driver VALUES ('IK13114254', 'Steve Smith', '26', 'MALE', '6921673161');
INSERT INTO Driver VALUES ('KE01019933', 'Chloe Brown', '36', 'FEMALE', '6981620227');
INSERT INTO Driver VALUES ('BN08028872', 'John Davis', '52', 'MALE', '6915623763');
INSERT INTO Driver VALUES ('OM27126296', 'Marie Miller', '21', 'FEMALE', '6993357512');

-- Vehicle
INSERT INTO Vehicle VALUES('GRTH639633', 'CAR', 'AI05069901', 'THPAFA3163', 'THTO920993', 'THPA237310', 'THFA021224');
INSERT INTO Vehicle VALUES('GRTH699821', 'CAR', 'IK13114254', 'THPOTO0912', 'THFA021224', 'THPO651209', 'THTO920993');
INSERT INTO Vehicle VALUES('GRTH098331', 'MOTORCYCLE', 'KE01019933', 'THKETO3441', 'THKE835612', 'THKE835612', 'THTO920993');
INSERT INTO Vehicle VALUES('GRTH707342', 'TRUCK', 'BN08028872', 'THPOPA0121', 'THPO651209', 'THPO651209', 'THPA237310');
INSERT INTO Vehicle VALUES('GRTH788242', 'CAR', 'OM27126296', 'THKEPO9884', 'THKE835612', 'THKE835612', 'THPO651209');

-- Violation
INSERT INTO Violation VALUES ('PP3781AI01', 'TRAFFIC_SIGN', '20', 'KE01019933');
INSERT INTO Violation VALUES ('SA9312IK54', 'TRAFFIC_LIGHT', '300', 'IK13114254');
INSERT INTO Violation VALUES ('KF9571KE33', 'SPEED_LIMIT', '90', 'KE01019933');
INSERT INTO Violation VALUES ('YT1267BN72', 'SPEED_LIMIT', '60', 'OM27126296');
INSERT INTO Violation VALUES ('EZ5205OM96', 'TRAFFIC_SIGN', '40', 'OM27126296');

-- Parking_slot
INSERT INTO Parking_slot VALUES ('THKE412320', 'EMPTY', '41.427462,23.652820', 'THPA237310');
INSERT INTO Parking_slot VALUES ('THPA292425', 'NOT_EMPTY', '39.523312,24.535225', 'THPA237310');
INSERT INTO Parking_slot VALUES ('THTO421920', 'NOT_EMPTY', '42.327402,19.865920', 'THTO920993');
INSERT INTO Parking_slot VALUES ('THFA402225', 'EMPTY', '40.623412,22.955825', 'THFA021224');
INSERT INTO Parking_slot VALUES ('THPO282225', 'NOT_EMPTY', '38.628712,22.005225', 'THTO920993');

-- Traffic_light
INSERT INTO Traffic_light VALUES ('THKETL3267', 'GREEN', '35', '40.424462,22.654820', 'THKE835612');
INSERT INTO Traffic_light VALUES ('THPATL2572', 'RED', '25', '40.887462,21.692820', 'THPA237310');
INSERT INTO Traffic_light VALUES ('THTOTL1903', 'RED', '20', '39.426662,22.677820', 'THTO920993');
INSERT INTO Traffic_light VALUES ('THFATL0212', 'RED', '5', '42.427462,24.652880', 'THFA021224');
INSERT INTO Traffic_light VALUES ('THPOTL9032', 'GREEN', '30', '40.400062,23.699920', 'THPO651209');

-- Tolls
INSERT INTO Tolls VALUES ('THKET95127', '1.2', '41.488462,21.659920', 'THKE835612');
INSERT INTO Tolls VALUES ('THPAT09978', '0.7', '40.517462,21.882820', 'THPA237310');
INSERT INTO Tolls VALUES ('THTOT12842', '1.0', '39.462662,22.677820', 'THTO920993');
INSERT INTO Tolls VALUES ('THFAT09051', '1.1', '42.429962,24.611880', 'THFA021224');
INSERT INTO Tolls VALUES ('THPOT65481', '0.9', '41.473062,23.699920', 'THPO651209');

-- Neightboring_Areas
INSERT INTO Neighboring_Areas VALUES ('THPA237310', 'THTO920993');
INSERT INTO Neighboring_Areas VALUES ('THTO920993', 'THFA021224');
INSERT INTO Neighboring_Areas VALUES ('THPO651209', 'THFA021224');
INSERT INTO Neighboring_Areas VALUES ('THFA021224', 'THTO920993');
INSERT INTO Neighboring_Areas VALUES ('THKE835612', 'THTO920993');
INSERT INTO Neighboring_Areas VALUES ('THPO651209', 'THPA237310');
INSERT INTO Neighboring_Areas VALUES ('THKE835612', 'THPO651209');

-- Route_Area
INSERT INTO Route_Area VALUES ('THPAFA3163', 'THFA021224');
INSERT INTO Route_Area VALUES ('THPAFA3163', 'THPA237310');
INSERT INTO Route_Area VALUES ('THPAFA3163', 'THTO920993');
INSERT INTO Route_Area VALUES ('THPOTO0912', 'THPO651209');
INSERT INTO Route_Area VALUES ('THPOTO0912', 'THTO920993');
INSERT INTO Route_Area VALUES ('THPOTO0912', 'THFA021224');
INSERT INTO Route_Area VALUES ('THKETO3441', 'THKE835612');
INSERT INTO Route_Area VALUES ('THKETO3441', 'THTO920993');
INSERT INTO Route_Area VALUES ('THPOPA0121', 'THPO651209');
INSERT INTO Route_Area VALUES ('THPOPA0121', 'THPA237310');
INSERT INTO Route_Area VALUES ('THKEPO9884', 'THKE835612');
INSERT INTO Route_Area VALUES ('THKEPO9884', 'THPO651209');


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
     