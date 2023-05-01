CREATE DATABASE Breakdown_Company;
USE Breakdown_Company;


-- Task 1 - Create Tables, Fields, and Keys --

CREATE TABLE Members(memberID VARCHAR(10) PRIMARY KEY, MFName VARCHAR(20), MLName VARCHAR(20), MLocation VARCHAR(20));
CREATE TABLE Vehicle(VehReg VARCHAR(10) PRIMARY KEY, VehMake VARCHAR(10), VehModel VARCHAR(10), memberID VARCHAR(10));
CREATE TABLE Engineer(engID INT Primary Key, EFName VARCHAR(20), ELName VARCHAR(20));
CREATE TABLE EngVan(VanReg VARCHAR(10) PRIMARY KEY, VanMake VARCHAR(10), VanModel VARCHAR(10), engID INT, VMileage INT);
CREATE TABLE Breakdown(BDID INT(10) PRIMARY KEY, VehReg VARCHAR(10), VanReg VARCHAR(10), BDDate DATE, BDTime TIME, BDLocation VARCHAR(20));

ALTER TABLE Vehicle ADD FOREIGN KEY (MemberID) REFERENCES Members(MemberID);
ALTER TABLE EngVan  ADD FOREIGN KEY (EngID)    REFERENCES Engineer(EngID) ;
ALTER TABLE Breakdown ADD FOREIGN KEY (VehReg) REFERENCES Vehicle(VehReg), ADD FOREIGN KEY (VanReg) REFERENCES EngVan(VanReg);
ALTER TAble engvan drop foreign key engvan_ibfk_1;
SELECT *
FROM EngVan
LEFT JOIN Engineer
ON EngVan.engID = Engineer.engID
WHERE Engineer.engID IS NULL;
ALTER TABLE EngVan DROP FOREIGN KEY engvan_ibfk_1;
ALTER TABLE EngVan ADD CONSTRAINT EngVan_fk FOREIGN KEY (engID) REFERENCES Engineer (engID);






-- Task 2 - Input Data --
INSERT INTO Members(memberID, MFName, MLName, MLocation) VALUES ('L2345', 'Michael', 'Jones', 'Brent'),('L7890', 'Sophie', 'Taylor', 'Lambeth'),('L3456', 'David', 'Wilson', 'Tower Hamlets'),('L5678', 'Sarah', 'Roberts', 'Haringey'),('L9012', 'Daniel', 'Brown', 'Wandsworth'),('L8312', 'Jermaine', 'Kingston', 'Hackney'),
('L3821', 'Linda', 'Bellingham', 'Leyton'),('L7689', 'Raheem', 'Sterling', 'Brent')
;
INSERT INTO Vehicle(VehReg, VehMake, VehModel) VALUES ('AB12 CDE', 'Ford', 'Focus'),('FG34 HIJ', 'Volkswagen', 'Golf'),('KL56 MNO', 'Audi', 'A3'),('PQ78 RST', 'Toyota', 'Yaris'),('UV90 WXY', 'BMW', 'X5'),('CD23 EFG', 'Mercedes', 'C-Class'),('HI45 JKL', 'Honda', 'Civic'),('MN67 PQR', 'Nissan', 'Qashqai');
INSERT INTO Engineer(engID, EFName, ELName) VALUES ('678', 'James', 'Smith'),('345', 'Karen', 'Lee'),('123', 'Andrew', 'Wilson');
INSERT INTO EngVan(VanReg, VanMake, VanModel, VMileage) VALUES ('V123 ABC', 'Ford', 'Transit', 50000),('V456 DEF', 'Volkswagen', 'Kombi', 75000),('V789 GHI', 'Mercedes', 'Sprinter', 100000),('V012 JKL', 'Renault', 'Kangoo', 25000),('V345 MNO', 'Fiat', 'Ducato', 125000);
INSERT INTO Breakdown(BDID, VehReg, VanReg, BDDate, BDTime, BDLocation) VALUES
('301', 'AB12 CDE', 'HJ01 NUC', '2023-03-11', '09:00:00', 'High Street'),
('842', 'FG34 HIJ', 'CD32 AJE', '2023-03-17', '10:30:00', 'Station Road'),
('833', 'KL56 MNO', 'MN49 IJX', '2023-03-21', '12:00:00', 'London Road'),
('354', 'KL56 MNO', 'PQ88 ONE', '2023-04-24', '13:30:00', 'Main Street'),
('635', 'FG34 HIJ', 'V005 NDJ', '2023-04-25', '15:00:00', 'Park Avenue'),
('036', 'PQ78 RST', 'VZ74 RYZ', '2023-04-20', '09:00:00', 'Market Square'),
('007', 'AB12 CDE', 'JK39 HFZ', '2023-04-22', '10:30:00', 'Station Road'),
('173', 'FG34 HIJ', 'VF98 XYZ', '2023-05-25', '12:00:00', 'London Road'),
('897', 'CD23 EFG', 'FK23 XID', '2023-05-20', '13:30:00', 'Main Street'),
('570', 'KL56 MNO', 'CB34 NRU', '2023-05-25', '15:00:00', 'Park Avenue'),
('111', 'MN67 PQR', 'DI39 UWC', '2023-06-13', '09:00:00', 'High Street'),
('232', 'AB12 CDE', 'V012 OWH', '2023-06-19', '10:30:00', 'Station Road');

--  Task 3 - Peform Queries --

SELECT MFName, MLName, MLocation FROM MEMBERS WHERE MLocation = 'Haringey';
SELECT VehReg, VehMake, VehModel FROM Vehicle WHERE VehMake = 'Mercedes';
SELECT COUNT(engID) From Engineer;
SELECT COUNT(memberID) From Members;
SELECT BDID, VehReg, VanReg, BDDate, BDTime, BDLocation FROM Breakdown WHERE BDDate > '2023:04:20';
SELECT BDID, VehReg, VanReg, BDDate, BDTime, BDLocation FROM Breakdown WHERE BDDate >= '2023:04:25' AND BDDate <= '2023:05:05';
SELECT COUNT(vehReg) FROM Breakdown WHERE vehReg = 'CD23 EFG';
SELECT vehReg, COUNT(*) FROM Breakdown GROUP BY vehReg HAVING COUNT(*) > 1;

-- TASK 4 CREATE NEW TABLE, INPUT DATA --

CREATE TABLE MshipType(MTID INT PRIMARY KEY,MType VARCHAR(6),MPrice DECIMAL(4,2));
INSERT INTO MshipType(MTID,MType,MPrice) VALUES ('1','Gold','99.99'),('2','Silver','59.99'),('3','Bronze','39.99');

-- TASK 5 -- TASK 5 ALTER AND UPDATE TABLE --

ALTER TABLE vehicle ADD MTID INT NULL;
ALTER TABLE vehicle ADD FOREIGN KEY(MTID) REFERENCES mshiptype(MTID);


UPDATE vehicle SET MTID = 1 WHERE VehReg = 'AB12 CDE'; 
UPDATE vehicle SET MTID  = 2 WHERE VehReg = 'CD23 EFG'; 
UPDATE vehicle SET MTID  = 3 WHERE VehReg = 'FG34 HIJ'; 
UPDATE vehicle SET MTID  = 1 WHERE VehReg = 'HI45 JKL'; 
UPDATE vehicle SET MTID  = 2 WHERE VehReg = 'KL56 MNO'; 
UPDATE vehicle SET MTID  = 3 WHERE VehReg = 'MN67 PQR'; 
UPDATE vehicle SET MTID  = 2 WHERE VehReg = 'PQ78 RST'; 
UPDATE vehicle SET MTID = 1 WHERE VehReg = 'UV90 WXY'; 

-- TASK 6 PEFORM QUERIES --
UPDATE Vehicle SET memberID = 'L2345' WHERE VehReg = 'AB12 CDE';
UPDATE Vehicle SET memberID = 'L3456' WHERE VehReg = 'CD23 EFG';
UPDATE Vehicle SET memberID = 'L3821' WHERE VehReg = 'FG34 HIJ';
UPDATE Vehicle SET memberID = 'L5678' WHERE VehReg = 'HI45 JKL';
UPDATE Vehicle SET memberID = 'L7890' WHERE VehReg = 'KL56 MNO';
UPDATE Vehicle SET memberID = 'L8312' WHERE VehReg = 'MN67 PQR';
UPDATE Vehicle SET memberID = 'L9012' WHERE VehReg = 'PQ78 RST';
UPDATE Vehicle SET memberID = 'L7689' WHERE VehReg = 'UV90 WXY';


SELECT VehReg AS Jermaine_Kingston_Vehicles FROM Vehicle WHERE memberID = 'L8312';
SELECT memberID, COUNT(*) AS memberNumOfVehicles FROM Vehicle GROUP By memberID ORDER By memberNumOfVehicles DESC;  

UPDATE EngVan SET engID = '123' WHERE VanReg = 'V012 JKL';
UPDATE EngVan SET engID = '345' WHERE VanReg = 'V123 ABC';
UPDATE EngVan SET engID = '678' WHERE VanReg = 'V345 MNO';
UPDATE EngVan SET engID = '123' WHERE VanReg = 'V456 DEF';
UPDATE EngVan SET engID = '345' WHERE VanReg = 'V789 GHI';

SELECT engID, Count(*) As EngineerNumOfVans FROM EngVan WHERE engID = '12';

SELECT Breakdown.BDID, Breakdown.BDLocation, Breakdown.VehReg, Vehicle.memberID, Members.MFName, Members.MLName, Members.MLocation 
FROM ((Breakdown 
INNER JOIN Vehicle ON Breakdown.VehReg = Vehicle.VehReg) 
INNER JOIN Members ON Vehicle.memberID = Members.memberID) 
WHERE Breakdown.BDLocation = 'Park Avenue';

SELECT Breakdown.BDID, Breakdown.BDLocation, Breakdown.VehReg, Vehicle.memberID, Members.MFName, Members.MLName, Members.MLocation, Breakdown.VanReg, EngVan.engID, Engineer.EFName, Engineer.ELName
From Breakdown 
INNER JOIN EngVan ON Breakdown.VanReg = EngVan.VanReg 
INNER JOIN Engineer ON EngVan.engID = Engineer.engID
INNER JOIN Vehicle ON Breakdown.VehReg = Vehicle.VehReg 
INNER JOIN Members ON Vehicle.memberID = Members.memberID;

SELECT Breakdown.BDID, Breakdown.BDLocation, Breakdown.BDDate, Breakdown.VehReg, Vehicle.memberID, Members.MFName, Members.MLName, Members.MLocation, Breakdown.VanReg, EngVan.engID, Engineer.EFName, Engineer.ELName
FROM Breakdown 
INNER JOIN EngVan ON Breakdown.VanReg = EngVan.VanReg 
INNER JOIN Engineer ON EngVan.engID = Engineer.engID
INNER JOIN Vehicle ON Breakdown.VehReg = Vehicle.VehReg 
INNER JOIN MemberS ON Vehicle.memberID = Members.memberID
WHERE  Breakdown.BDDate >= '2023:04:01' AND Breakdown.BDDate <= '2023:05:01';
-- Members Membership information and car information --
SELECT Vehicle.VehReg, Vehicle.VehMake, Vehicle.VehModel, MshipType.MTID, MshipType.MType, MshipType.MPrice
FROM Vehicle
LEFT JOIN MshipType 
ON Vehicle.MTID = MshipType.MTID
ORDER BY Vehicle.VehReg;

-- the count of vehicles grouped by their Make and Model --
SELECT VehMake, VehModel, COUNT(*) as VehicleCount
FROM Vehicle
GROUP BY VehMake, VehModel
ORDER BY VehicleCount DESC;
-- Location with the highest amount of breakdowns
SELECT BDLocation, COUNT(*) as breakdown_count
FROM Breakdown
GROUP BY BDLocation
ORDER BY breakdown_count DESC;

-- task 7 Avg, Max, Min, Sum functions --

CREATE DATABASE Clapton_RangersFC;
USE Clapton_RangersFC;

CREATE TABLE Season (player_id INT,player_name VARCHAR(255),positions VARCHAR(255),appearances INT,goals_scored INT,assists INT,yellow_cards INT,red_cards INT,clean_sheets INT);
INSERT INTO Season (player_id, player_name, positions, appearances, goals_scored, assists, yellow_cards, red_cards, clean_sheets) VALUES
  (1, 'John Smith', 'Forward', 20, 20, 5, 2, 1, 4),
  (2, 'Mark Johnson', 'Midfielder', 16, 2, 8, 3, 0, 8),
  (3, 'David Brown', 'Defender', 17, 1, 1, 4, 2, 8),
  (4, 'Michael Davis', 'Goalkeeper', 18, 0, 0, 1, 0, 10),
  (5, 'Robert Wilson', 'Forward', 14, 5, 3, 0, 1, 3),
  (6, 'James Lee', 'Midfielder', 20, 3, 2, 2, 0, 4),
  (7, 'Christopher Taylor', 'Defender', 19, 0, 1, 3, 1, 7),
  (8, 'Daniel Clark', 'Midfielder', 13, 1, 4, 2, 0, 8),
  (9, 'Richard Adams', 'Defender', 11, 0, 0, 1, 0, 10),
  (10, 'William Green', 'Forward', 20, 8, 2, 0, 0, 8),
  (11, 'Edward Black', 'Goalkeeper', 5, 0, 0, 0, 0, 2),
  (12, 'Thomas White', 'Defender', 8, 0, 0, 1, 0, 4),
  (13, 'George Brown', 'Midfielder', 6, 0, 1, 0, 0, 2),
  (14, 'Andrew Clark', 'Forward', 9, 1, 1, 0, 0, 3),
  (15, 'Matthew Wilson', 'Defender', 9, 0, 2, 2, 0, 3),
  (16, 'Benjamin Lee', 'Midfielder', 10, 2, 1, 1, 0, 3),
  (17, 'Samuel Taylor', 'Defender', 12, 0, 0, 4, 0, 5),
  (18, 'Anthony Davis', 'Forward', 11, 4, 0, 1, 0, 5),
  (19, 'Timothy Green', 'Midfielder', 14, 0, 3, 3, 0, 2),
  (20, 'Joseph Smith', 'Goalkeeper', 3, 0, 0, 0, 0, 1);

SELECT * FROM SEASON;

SELECT AVG (goals_scored) FROM season;

SELECT MAX(appearances) FROM season;

SELECT MIN(assists) FROM season;

SELECT SUM(yellow_cards) FROM season;
                                            -- TASK 8 --

USE Breakdown_Company;
SELECT memberID,
IF (Count(memberID) >= 2, 'MultiCar Policy', 'Single Car Policy') AS 'Policy Type'
FROM Vehicle GROUP BY memberID;

SELECT VehReg, 
CASE
	WHEN COUNT(Vehreg) > 2 THEN 'Premium increase by 10%'
    WHEN COUNT(Vehreg) = 2 THEN 'Premium increase by 5%'
    WHEN COUNT(Vehreg) = 1 THEN 'No increase'
    ELSE '10% discount'
END AS 'premium Increase / discount'
FROM Breakdown GROUP BY Vehreg;



































