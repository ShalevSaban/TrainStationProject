CREATE SCHEMA trainDataBase;
use trainDataBase;

CREATE TABLE Train_Station (
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    PRIMARY KEY (Name)
)  ENGINE=INNODB;

CREATE TABLE Platform (
    Platform_Num INT NOT NULL,
    Train_Station_Name VARCHAR(100) NOT NULL,
    PRIMARY KEY (Platform_Num , Train_Station_Name),
    CONSTRAINT fk_tsn FOREIGN KEY (Train_Station_Name)
        REFERENCES Train_Station (Name)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB;


CREATE TABLE Route (
    Route_Num INT NOT NULL,
    Origin VARCHAR(100) NOT NULL,
    Destination VARCHAR(100) NOT NULL,
    Day VARCHAR(100) NOT NULL,
    Time TIME NOT NULL,
    PRIMARY KEY (Route_Num)
)  ENGINE=INNODB;

CREATE TABLE Train (
    Train_Num INT NOT NULL,
    Type VARCHAR(100) NOT NULL,
    PRIMARY KEY (Train_Num)
)  ENGINE=INNODB;

CREATE TABLE Wagon (
    Wagon_Num INT NOT NULL,
    Train_Num INT NOT NULL,
    Capacity INT,
    Type VARCHAR(100) NOT NULL,
    PRIMARY KEY (Wagon_Num , Train_Num),
    CONSTRAINT fk_wgn FOREIGN KEY (Train_Num)
        REFERENCES Train (Train_Num)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB;

CREATE TABLE Actual_Route (
    Route_Num INT NOT NULL,
    Train_Num INT NOT NULL,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Passengers_Num INT,
    PRIMARY KEY (Route_Num , Train_Num,Date,Time),
    CONSTRAINT fk_actRouteNum FOREIGN KEY (Route_Num)
        REFERENCES Route (Route_Num)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    CONSTRAINT fk_actRouteTrain FOREIGN KEY (Train_Num)
        REFERENCES Train (Train_Num)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB;

CREATE TABLE Ticket (
    Ticket_Num INT NOT NULL,
    Route_Num INT NOT NULL,
    Type VARCHAR(100) NOT NULL,
    Price FLOAT4,
    PRIMARY KEY (Ticket_Num , Route_Num),
    CONSTRAINT fk_tckt FOREIGN KEY (Route_Num)
        REFERENCES Actual_Route (Route_Num)
        ON UPDATE CASCADE ON DELETE NO ACTION
)  ENGINE=INNODB;

delimiter $
CREATE TRIGGER add_ticket AFTER INSERT ON Ticket
FOR EACH ROW
BEGIN
UPDATE actual_route SET Passengers_Num =Passengers_Num+1  WHERE Route_Num=new.Route_Num ;
END$



create table Employee
(
Id int NOT NULL,
Name varchar(100) NOT NULL,
DOB date NOT NULL,
PRIMARY KEY(Id)
)
ENGINE=InnoDB;

create table Conductor 
(
Id int NOT NULL,
Checked_Tickets_Num int NOT NULL,
PRIMARY KEY(Id),
constraint fk_cond foreign key(Id) references Employee(Id)
on update cascade
on delete no action
)
ENGINE=InnoDB;

create table Train_Driver
(
Id int NOT NULL,
Years_Of_Exp int,
PRIMARY KEY(Id),
constraint fk_driEmp foreign key(Id) references Employee(Id)
on update cascade
on delete no action
)
ENGINE=InnoDB;



create table Stopover
(
Train_Station_Name varchar(100) NOT NULL,
Route_Num int NOT NULL,
constraint fk_stpStationName foreign key(Train_Station_Name) references Train_Station(Name)
on update cascade
on delete no action,
constraint fk_stpRouteNum foreign key(Route_Num) references Route(Route_Num)
on update cascade
on delete no action
)
ENGINE=InnoDB;

create table Crew
(
Employee_Id int NOT NULL,
Route_Num int NOT NULL,
constraint fk_crewEmp foreign key(Employee_Id) references Employee(Id)
on update cascade
on delete no action,
constraint fk_crewRoute foreign key(Route_Num) references Actual_Route(Route_Num)
on update cascade
on delete no action
)
ENGINE=InnoDB;

Insert into  Train_Station Values
('Ashkelon','Power Center'),
('Ashdod','Ashdod Ad Halom Junction'),
('Beer Sheva Merkaz','Ben Zvi 8'),
('Jerusalem Malha','Izhak Modai 1'),
('Rishon LeZion Harishonim','Herzel 149'),
('Lod','Yoseftal 5'),
('Rosh HaAyin Tzafon','Kesem Junction'),
('Tel-Aviv University','Izik Ramba,Merkaz HaYeridim'),
('Tel-Aviv HaShalom','Givat HaTahmoshet 10'),
('Netanya','Dereh Harakevet 5'),
('Beit Shean','Road 71,In Front Of Kibutz Sde Nahum'),
('Haifa Hof HaCarmel','Andrey Saharov'),
('Haifa Bat Galim','Aliat HaNoar'),
('Naharia','HaGaaton 1');

Insert into  Platform Values
(1, (SELECT Name from Train_Station WHERE Name='Ashkelon')),
(2, (SELECT Name from Train_Station WHERE Name='Ashkelon')),
(1, (SELECT Name from Train_Station WHERE Name='Ashdod')),
(2, (SELECT Name from Train_Station WHERE Name='Ashdod')),
(1, (SELECT Name from Train_Station WHERE Name='Beer Sheva Merkaz')),
(2, (SELECT Name from Train_Station WHERE Name='Beer Sheva Merkaz')),
(3, (SELECT Name from Train_Station WHERE Name='Beer Sheva Merkaz')),
(4, (SELECT Name from Train_Station WHERE Name='Beer Sheva Merkaz')),
(1, (SELECT Name from Train_Station WHERE Name='Jerusalem Malha')),
(2, (SELECT Name from Train_Station WHERE Name='Jerusalem Malha')),
(3, (SELECT Name from Train_Station WHERE Name='Jerusalem Malha')),
(4, (SELECT Name from Train_Station WHERE Name='Jerusalem Malha')),
(1, (SELECT Name from Train_Station WHERE Name='Rishon LeZion Harishonim')),
(2, (SELECT Name from Train_Station WHERE Name='Rishon LeZion Harishonim')),
(1, (SELECT Name from Train_Station WHERE Name='Lod')),
(2, (SELECT Name from Train_Station WHERE Name='Lod')),
(3, (SELECT Name from Train_Station WHERE Name='Lod')),
(4, (SELECT Name from Train_Station WHERE Name='Lod')),
(1, (SELECT Name from Train_Station WHERE Name='Rosh HaAyin Tzafon')),
(2, (SELECT Name from Train_Station WHERE Name='Rosh HaAyin Tzafon')),
(1, (SELECT Name from Train_Station WHERE Name='Tel-Aviv University')),
(2, (SELECT Name from Train_Station WHERE Name='Tel-Aviv University')),
(3, (SELECT Name from Train_Station WHERE Name='Tel-Aviv University')),
(4, (SELECT Name from Train_Station WHERE Name='Tel-Aviv University')),
(1, (SELECT Name from Train_Station WHERE Name='Tel-Aviv HaShalom')),
(2, (SELECT Name from Train_Station WHERE Name='Tel-Aviv HaShalom')),
(3, (SELECT Name from Train_Station WHERE Name='Tel-Aviv HaShalom')),
(4, (SELECT Name from Train_Station WHERE Name='Tel-Aviv HaShalom')),
(1, (SELECT Name from Train_Station WHERE Name='Netanya')),
(2, (SELECT Name from Train_Station WHERE Name='Netanya')),
(1, (SELECT Name from Train_Station WHERE Name='Beit Shean')),
(2, (SELECT Name from Train_Station WHERE Name='Beit Shean')),
(1, (SELECT Name from Train_Station WHERE Name='Haifa Hof HaCarmel')),
(2, (SELECT Name from Train_Station WHERE Name='Haifa Hof HaCarmel')),
(3, (SELECT Name from Train_Station WHERE Name='Haifa Hof HaCarmel')),
(4, (SELECT Name from Train_Station WHERE Name='Haifa Hof HaCarmel')),
(1, (SELECT Name from Train_Station WHERE Name='Haifa Bat Galim')),
(2, (SELECT Name from Train_Station WHERE Name='Haifa Bat Galim')),
(3, (SELECT Name from Train_Station WHERE Name='Haifa Bat Galim')),
(4, (SELECT Name from Train_Station WHERE Name='Haifa Bat Galim')),
(1, (SELECT Name from Train_Station WHERE Name='Naharia')),
(2, (SELECT Name from Train_Station WHERE Name='Naharia'));


Insert into  Route Values
(100,'Beer Sheva Merkaz','Naharia','Sunday','10:30'),
(200,'Naharia','Beer Sheva Merkaz','Sunday','18:30'),
(101,'Haifa Hof HaCarmel','Jerusalem Malha','Monday','06:30'),
(201,'Jerusalem Malha','Haifa Hof HaCarmel','Thursday','7:40'),
(102,'Beit Shean','Ashkelon','Friday','10:30'),
(202,'Ashkelon','Beit Shean','Wednesday','10:30'),
(103,'Ashdod','Haifa Bat Galim','Thursday','16:26'),
(203,'Haifa Bat Galim','Ashdod','Monday','20:18'),
(104,'Tel-Aviv University','Beer Sheva Merkaz','Saturday','21:40'),
(204,'Beer Sheva Merkaz','Tel-Aviv University','Thursday','12:55'),
(105,'Jerusalem Malha','Naharia','Friday','11:49'),
(205,'Naharia','Jerusalem Malha','Sunday','17:34'),
(106,'Jerusalem Malha','Tel-Aviv HaShalom','Monday','14:08'),
(206,'Tel-Aviv HaShalom','Jerusalem Malha','Thursday','19:44');

Insert into Train Values
(1000,'Electric'),
(1001,'Steam'),
(1002,'Diesel'),
(1003,'Diesel'),
(1004,'Diesel'),
(1005,'Electric'),
(1006,'Steam'),
(1007,'Steam'),
(1008,'Electric'),
(1009,'Diesel'),
(1010,'Steam'),
(1011,'Diesel'),
(1012,'Steam'),
(1013,'Electric');

Insert into Wagon Values
(5001,(SELECT Train_Num from Train WHERE Train_Num='1000'),50,'One floor'),
(5002,(SELECT Train_Num from Train WHERE Train_Num='1000'),50,'One floor'),
(5003,(SELECT Train_Num from Train WHERE Train_Num='1000'),50,'One floor'),
(5004,(SELECT Train_Num from Train WHERE Train_Num='1000'),50,'One floor'),
(5005,(SELECT Train_Num from Train WHERE Train_Num='1000'),20,'Accessible to the disabled'),
(5006,(SELECT Train_Num from Train WHERE Train_Num='1001'),100,'Two floor'),
(5007,(SELECT Train_Num from Train WHERE Train_Num='1001'),100,'Two floor'),
(5008,(SELECT Train_Num from Train WHERE Train_Num='1001'),100,'Two floor'),
(5009,(SELECT Train_Num from Train WHERE Train_Num='1001'),100,'Two floor'),
(5010,(SELECT Train_Num from Train WHERE Train_Num='1001'),20,'Accessible to the disabled'),
(5011,(SELECT Train_Num from Train WHERE Train_Num='1002'),50,'One floor'),
(5012,(SELECT Train_Num from Train WHERE Train_Num='1002'),50,'One floor'),
(5013,(SELECT Train_Num from Train WHERE Train_Num='1002'),50,'One floor'),
(5014,(SELECT Train_Num from Train WHERE Train_Num='1002'),50,'One floor'),
(5015,(SELECT Train_Num from Train WHERE Train_Num='1002'),20,'Accessible to the disabled'),
(5016,(SELECT Train_Num from Train WHERE Train_Num='1003'),50,'One floor'),
(5017,(SELECT Train_Num from Train WHERE Train_Num='1003'),50,'One floor'),
(5018,(SELECT Train_Num from Train WHERE Train_Num='1003'),50,'One floor'),
(5019,(SELECT Train_Num from Train WHERE Train_Num='1003'),50,'One floor'),
(5020,(SELECT Train_Num from Train WHERE Train_Num='1003'),20,'Accessible to the disabled'),
(5021,(SELECT Train_Num from Train WHERE Train_Num='1004'),100,'Two floor'),
(5022,(SELECT Train_Num from Train WHERE Train_Num='1004'),100,'Two floor'),
(5023,(SELECT Train_Num from Train WHERE Train_Num='1004'),100,'Two floor'),
(5024,(SELECT Train_Num from Train WHERE Train_Num='1004'),100,'Two floor'),
(5025,(SELECT Train_Num from Train WHERE Train_Num='1004'),20,'Reserved seats'),
(5026,(SELECT Train_Num from Train WHERE Train_Num='1005'),50,'One floor'),
(5027,(SELECT Train_Num from Train WHERE Train_Num='1005'),50,'One floor'),
(5028,(SELECT Train_Num from Train WHERE Train_Num='1005'),50,'One floor'),
(5029,(SELECT Train_Num from Train WHERE Train_Num='1005'),50,'One floor'),
(5030,(SELECT Train_Num from Train WHERE Train_Num='1005'),20,'Reserved seats'),
(5031,(SELECT Train_Num from Train WHERE Train_Num='1006'),50,'One floor'),
(5032,(SELECT Train_Num from Train WHERE Train_Num='1006'),50,'One floor'),
(5033,(SELECT Train_Num from Train WHERE Train_Num='1006'),50,'One floor'),
(5034,(SELECT Train_Num from Train WHERE Train_Num='1006'),50,'One floor'),
(5035,(SELECT Train_Num from Train WHERE Train_Num='1006'),20,'Reserved seats'),
(5036,(SELECT Train_Num from Train WHERE Train_Num='1007'),100,'Two floor'),
(5037,(SELECT Train_Num from Train WHERE Train_Num='1007'),100,'Two floor'),
(5038,(SELECT Train_Num from Train WHERE Train_Num='1007'),100,'Two floor'),
(5039,(SELECT Train_Num from Train WHERE Train_Num='1007'),100,'Two floor'),
(5040,(SELECT Train_Num from Train WHERE Train_Num='1007'),20,'Accessible to the disabled'),
(5041,(SELECT Train_Num from Train WHERE Train_Num='1008'),50,'One floor'),
(5042,(SELECT Train_Num from Train WHERE Train_Num='1008'),50,'One floor'),
(5043,(SELECT Train_Num from Train WHERE Train_Num='1008'),50,'One floor'),
(5044,(SELECT Train_Num from Train WHERE Train_Num='1008'),50,'One floor'),
(5045,(SELECT Train_Num from Train WHERE Train_Num='1008'),20,'Accessible to the disabled'),
(5046,(SELECT Train_Num from Train WHERE Train_Num='1009'),100,'Two floor'),
(5047,(SELECT Train_Num from Train WHERE Train_Num='1009'),100,'Two floor'),
(5048,(SELECT Train_Num from Train WHERE Train_Num='1009'),100,'Two floor'),
(5049,(SELECT Train_Num from Train WHERE Train_Num='1009'),100,'Two floor'),
(5050,(SELECT Train_Num from Train WHERE Train_Num='1009'),20,'Reserved seats'),
(5051,(SELECT Train_Num from Train WHERE Train_Num='1010'),50,'One floor'),
(5052,(SELECT Train_Num from Train WHERE Train_Num='1010'),50,'One floor'),
(5053,(SELECT Train_Num from Train WHERE Train_Num='1010'),50,'One floor'),
(5054,(SELECT Train_Num from Train WHERE Train_Num='1010'),50,'One floor'),
(5055,(SELECT Train_Num from Train WHERE Train_Num='1010'),20,'Accessible to the disabled'),
(5056,(SELECT Train_Num from Train WHERE Train_Num='1011'),100,'Two floor'),
(5057,(SELECT Train_Num from Train WHERE Train_Num='1011'),100,'Two floor'),
(5058,(SELECT Train_Num from Train WHERE Train_Num='1011'),100,'Two floor'),
(5059,(SELECT Train_Num from Train WHERE Train_Num='1011'),100,'Two floor'),
(5060,(SELECT Train_Num from Train WHERE Train_Num='1011'),20,'Reserved seats'),
(5061,(SELECT Train_Num from Train WHERE Train_Num='1012'),50,'One floor'),
(5062,(SELECT Train_Num from Train WHERE Train_Num='1012'),50,'One floor'),
(5063,(SELECT Train_Num from Train WHERE Train_Num='1012'),50,'One floor'),
(5064,(SELECT Train_Num from Train WHERE Train_Num='1012'),50,'One floor'),
(5065,(SELECT Train_Num from Train WHERE Train_Num='1012'),20,'Reserved seats'),
(5066,(SELECT Train_Num from Train WHERE Train_Num='1013'),100,'Two floor'),
(5067,(SELECT Train_Num from Train WHERE Train_Num='1013'),100,'Two floor'),
(5068,(SELECT Train_Num from Train WHERE Train_Num='1013'),100,'Two floor'),
(5069,(SELECT Train_Num from Train WHERE Train_Num='1013'),100,'Two floor'),
(5070,(SELECT Train_Num from Train WHERE Train_Num='1013'),20,'Accessible to the disabled');


Insert into  Actual_Route Values
((SELECT Route_Num from Route WHERE Route_Num='100'),(SELECT Train_Num from Train WHERE Train_Num='1000'),'2021-05-23','10:36',0),
((SELECT Route_Num from Route WHERE Route_Num='200'),(SELECT Train_Num from Train WHERE Train_Num='1001'),'2021-05-23','18:32',0),
((SELECT Route_Num from Route WHERE Route_Num='101'),(SELECT Train_Num from Train WHERE Train_Num='1002'),'2021-05-24','06:41',0),
((SELECT Route_Num from Route WHERE Route_Num='201'),(SELECT Train_Num from Train WHERE Train_Num='1003'),'2021-05-27','07:44',0),
((SELECT Route_Num from Route WHERE Route_Num='102'),(SELECT Train_Num from Train WHERE Train_Num='1004'),'2021-05-28','10:31',0),
((SELECT Route_Num from Route WHERE Route_Num='202'),(SELECT Train_Num from Train WHERE Train_Num='1005'),'2021-05-26','10:30',0),
((SELECT Route_Num from Route WHERE Route_Num='103'),(SELECT Train_Num from Train WHERE Train_Num='1006'),'2021-05-27','16:28',0),
((SELECT Route_Num from Route WHERE Route_Num='203'),(SELECT Train_Num from Train WHERE Train_Num='1007'),'2021-05-24','20:19',0),
((SELECT Route_Num from Route WHERE Route_Num='104'),(SELECT Train_Num from Train WHERE Train_Num='1008'),'2021-05-29','21:40',0),
((SELECT Route_Num from Route WHERE Route_Num='204'),(SELECT Train_Num from Train WHERE Train_Num='1009'),'2021-05-27','12:55',0),
((SELECT Route_Num from Route WHERE Route_Num='105'),(SELECT Train_Num from Train WHERE Train_Num='1010'),'2021-05-28','11:50',0),
((SELECT Route_Num from Route WHERE Route_Num='205'),(SELECT Train_Num from Train WHERE Train_Num='1011'),'2021-05-23','17:39',0),
((SELECT Route_Num from Route WHERE Route_Num='106'),(SELECT Train_Num from Train WHERE Train_Num='1012'),'2021-05-24','14:08',0),
((SELECT Route_Num from Route WHERE Route_Num='206'),(SELECT Train_Num from Train WHERE Train_Num='1013'),'2021-05-27','19:46',0);

Insert into  Ticket Values
(9000,(SELECT Route_Num from Route WHERE Route_Num='100'),'Regular',64.50),
(9200,(SELECT Route_Num from Route WHERE Route_Num='100'),'Student',32.00),
(9400,(SELECT Route_Num from Route WHERE Route_Num='100'),'Pensioner',32.00),
(9600,(SELECT Route_Num from Route WHERE Route_Num='100'),'Disabled',64.50),
(9001,(SELECT Route_Num from Route WHERE Route_Num='200'),'Regular',64.50),
(9201,(SELECT Route_Num from Route WHERE Route_Num='200'),'Student',32.00),
(9401,(SELECT Route_Num from Route WHERE Route_Num='200'),'Pensioner',32.00),
(9601,(SELECT Route_Num from Route WHERE Route_Num='200'),'Disabled',64.50),
(9002,(SELECT Route_Num from Route WHERE Route_Num='101'),'Regular',42.00),
(9202,(SELECT Route_Num from Route WHERE Route_Num='101'),'Student',21.00),
(9402,(SELECT Route_Num from Route WHERE Route_Num='101'),'Pensioner',21.00),
(9602,(SELECT Route_Num from Route WHERE Route_Num='101'),'Disabled',42.00),
(9003,(SELECT Route_Num from Route WHERE Route_Num='201'),'Regular',42.00),
(9203,(SELECT Route_Num from Route WHERE Route_Num='201'),'Student',21.00),
(9403,(SELECT Route_Num from Route WHERE Route_Num='201'),'Pensioner',21.00),
(9603,(SELECT Route_Num from Route WHERE Route_Num='201'),'Disabled',42.00),
(9004,(SELECT Route_Num from Route WHERE Route_Num='102'),'Regular',56.00),
(9204,(SELECT Route_Num from Route WHERE Route_Num='102'),'Student',28.00),
(9404,(SELECT Route_Num from Route WHERE Route_Num='102'),'Pensioner',28.00),
(9604,(SELECT Route_Num from Route WHERE Route_Num='102'),'Disabled',56.00),
(9005,(SELECT Route_Num from Route WHERE Route_Num='202'),'Regular',56.00),
(9205,(SELECT Route_Num from Route WHERE Route_Num='202'),'Student',28.00),
(9405,(SELECT Route_Num from Route WHERE Route_Num='202'),'Pensioner',28.00),
(9605,(SELECT Route_Num from Route WHERE Route_Num='202'),'Disabled',56.00),
(9006,(SELECT Route_Num from Route WHERE Route_Num='103'),'Regular',38.50),
(9206,(SELECT Route_Num from Route WHERE Route_Num='103'),'Student',19.00),
(9406,(SELECT Route_Num from Route WHERE Route_Num='103'),'Pensioner',19.00),
(9606,(SELECT Route_Num from Route WHERE Route_Num='103'),'Disabled',38.50),
(9007,(SELECT Route_Num from Route WHERE Route_Num='203'),'Regular',38.50),
(9207,(SELECT Route_Num from Route WHERE Route_Num='203'),'Student',19.00),
(9407,(SELECT Route_Num from Route WHERE Route_Num='203'),'Pensioner',19.00),
(9607,(SELECT Route_Num from Route WHERE Route_Num='203'),'Disabled',38.50),
(9008,(SELECT Route_Num from Route WHERE Route_Num='104'),'Regular',26.50),
(9208,(SELECT Route_Num from Route WHERE Route_Num='104'),'Student',13.00),
(9408,(SELECT Route_Num from Route WHERE Route_Num='104'),'Pensioner',13.00),
(9608,(SELECT Route_Num from Route WHERE Route_Num='104'),'Disabled',26.50),
(9009,(SELECT Route_Num from Route WHERE Route_Num='204'),'Regular',26.50),
(9209,(SELECT Route_Num from Route WHERE Route_Num='204'),'Student',13.00),
(9409,(SELECT Route_Num from Route WHERE Route_Num='204'),'Pensioner',13.00),
(9609,(SELECT Route_Num from Route WHERE Route_Num='204'),'Disabled',26.50),
(9010,(SELECT Route_Num from Route WHERE Route_Num='105'),'Regular',53.50),
(9210,(SELECT Route_Num from Route WHERE Route_Num='105'),'Student',26.50),
(9410,(SELECT Route_Num from Route WHERE Route_Num='105'),'Pensioner',26.50),
(9610,(SELECT Route_Num from Route WHERE Route_Num='105'),'Disabled',53.50),
(9011,(SELECT Route_Num from Route WHERE Route_Num='205'),'Regular',53.50),
(9211,(SELECT Route_Num from Route WHERE Route_Num='205'),'Student',26.50),
(9411,(SELECT Route_Num from Route WHERE Route_Num='205'),'Pensioner',26.50),
(9611,(SELECT Route_Num from Route WHERE Route_Num='205'),'Disabled',53.50),
(9012,(SELECT Route_Num from Route WHERE Route_Num='106'),'Regular',19.50),
(9212,(SELECT Route_Num from Route WHERE Route_Num='106'),'Student',9.50),
(9412,(SELECT Route_Num from Route WHERE Route_Num='106'),'Pensioner',9.50),
(9612,(SELECT Route_Num from Route WHERE Route_Num='106'),'Disabled',19.50),
(9013,(SELECT Route_Num from Route WHERE Route_Num='206'),'Regular',19.50),
(9213,(SELECT Route_Num from Route WHERE Route_Num='206'),'Student',9.50),
(9413,(SELECT Route_Num from Route WHERE Route_Num='206'),'Pensioner',9.50),
(9613,(SELECT Route_Num from Route WHERE Route_Num='206'),'Disabled',19.50);



Insert into Employee Values
(1,'Moshe Cohen','1977-06-30'),
(2,'Yosef Levi','1990-11-15'),
(3,'Yarden Zehavi','1991-08-10'),
(4,'Simha Gora','1986-12-27'),
(5,'Eli Kopter','1996-03-14'),
(6,'Josh Katz','2000-02-21'),
(7,'Eitan Kohavi','1983-08-11'),
(8,'Binyamin Shamir','1961-01-09'),
(9,'Ron Butbul','1982-09-02'),
(10,'Eyal Goldshtein','1989-04-06'),
(11,'Daniel Izhak','1996-07-28'),
(12,'Guy Lavi','1993-10-14'),
(13,'Eden Bahar','1997-06-11'),
(14,'Maya Katz','1985-02-17'),
(15,'Ilanit Peretz','1977-05-26'),
(16,'Shimon Dayan','1974-10-04'),
(17,'Adi Simhi','1987-03-21'),
(18,'Miki Bender','1998-11-08'),
(19,'Raz Haim','1992-05-31'),
(20,'Tom Solomon','1990-01-10'),
(21,'Moshe Cohen','2002-09-12'),
(22,'Yosef Levi','1990-11-11'),
(23,'Yaakov Oren','1979-07-14'),
(24,'Schahar Avraham','1975-06-09'),
(25,'Eylon Simantov','1994-04-16'),
(26,'Almog Naim','1987-10-18'),
(27,'Shlomi Goldberg','1990-03-26'),
(28,'Sason Levi','1990-03-26');





Insert into Conductor Values
((SELECT Id from Employee WHERE Id='1'),145),
((SELECT Id from Employee WHERE Id='3'),356),
((SELECT Id from Employee WHERE Id='5'),185),
((SELECT Id from Employee WHERE Id='7'),171),
((SELECT Id from Employee WHERE Id='9'),197),
((SELECT Id from Employee WHERE Id='11'),88),
((SELECT Id from Employee WHERE Id='13'),218),
((SELECT Id from Employee WHERE Id='15'),262),
((SELECT Id from Employee WHERE Id='17'),46),
((SELECT Id from Employee WHERE Id='19'),100),
((SELECT Id from Employee WHERE Id='21'),87),
((SELECT Id from Employee WHERE Id='23'),208),
((SELECT Id from Employee WHERE Id='25'),74),
((SELECT Id from Employee WHERE Id='27'),168);


Insert into Train_Driver Values
((SELECT Id from Employee WHERE Id='2'),2),
((SELECT Id from Employee WHERE Id='4'),15),
((SELECT Id from Employee WHERE Id='6'),1),
((SELECT Id from Employee WHERE Id='8'),36),
((SELECT Id from Employee WHERE Id='10'),9),
((SELECT Id from Employee WHERE Id='12'),4),
((SELECT Id from Employee WHERE Id='14'),11),
((SELECT Id from Employee WHERE Id='16'),22),
((SELECT Id from Employee WHERE Id='18'),2),
((SELECT Id from Employee WHERE Id='20'),7),
((SELECT Id from Employee WHERE Id='22'),3),
((SELECT Id from Employee WHERE Id='24'),23),
((SELECT Id from Employee WHERE Id='26'),13),
((SELECT Id from Employee WHERE Id='28'),16);

Insert into Stopover Values
((SELECT Name from Train_Station WHERE Name='Ashdod'),(SELECT Route_Num from Route WHERE Route_Num='100')),
((SELECT Name from Train_Station WHERE Name='Tel-Aviv University'),(SELECT Route_Num from Route WHERE Route_Num='100')),
((SELECT Name from Train_Station WHERE Name='Haifa Hof HaCarmel'),(SELECT Route_Num from Route WHERE Route_Num='100')),
((SELECT Name from Train_Station WHERE Name='Haifa Hof HaCarmel'),(SELECT Route_Num from Route WHERE Route_Num='200')),
((SELECT Name from Train_Station WHERE Name='Tel-Aviv University'),(SELECT Route_Num from Route WHERE Route_Num='200')),
((SELECT Name from Train_Station WHERE Name='Ashdod'),(SELECT Route_Num from Route WHERE Route_Num='200')),
((SELECT Name from Train_Station WHERE Name='Netanya'),(SELECT Route_Num from Route WHERE Route_Num='101')),
((SELECT Name from Train_Station WHERE Name='Lod'),(SELECT Route_Num from Route WHERE Route_Num='101')),
((SELECT Name from Train_Station WHERE Name='Lod'),(SELECT Route_Num from Route WHERE Route_Num='201')),
((SELECT Name from Train_Station WHERE Name='Netanya'),(SELECT Route_Num from Route WHERE Route_Num='201')),
((SELECT Name from Train_Station WHERE Name='Haifa Bat Galim'),(SELECT Route_Num from Route WHERE Route_Num='102')),
((SELECT Name from Train_Station WHERE Name='Rosh HaAyin Tzafon'),(SELECT Route_Num from Route WHERE Route_Num='102')),
((SELECT Name from Train_Station WHERE Name='Rishon LeZion Harishonim'),(SELECT Route_Num from Route WHERE Route_Num='102')),
((SELECT Name from Train_Station WHERE Name='Rishon LeZion Harishonim'),(SELECT Route_Num from Route WHERE Route_Num='202')),
((SELECT Name from Train_Station WHERE Name='Rosh HaAyin Tzafon'),(SELECT Route_Num from Route WHERE Route_Num='202')),
((SELECT Name from Train_Station WHERE Name='Haifa Bat Galim'),(SELECT Route_Num from Route WHERE Route_Num='202')),
((SELECT Name from Train_Station WHERE Name='Tel-Aviv HaShalom'),(SELECT Route_Num from Route WHERE Route_Num='103')),
((SELECT Name from Train_Station WHERE Name='Tel-Aviv HaShalom'),(SELECT Route_Num from Route WHERE Route_Num='203')),
((SELECT Name from Train_Station WHERE Name='Ashdod'),(SELECT Route_Num from Route WHERE Route_Num='104')),
((SELECT Name from Train_Station WHERE Name='Ashkelon'),(SELECT Route_Num from Route WHERE Route_Num='104')),
((SELECT Name from Train_Station WHERE Name='Ashkelon'),(SELECT Route_Num from Route WHERE Route_Num='204')),
((SELECT Name from Train_Station WHERE Name='Ashdod'),(SELECT Route_Num from Route WHERE Route_Num='204')),
((SELECT Name from Train_Station WHERE Name='Haifa Hof HaCarmel'),(SELECT Route_Num from Route WHERE Route_Num='105')),
((SELECT Name from Train_Station WHERE Name='Haifa Bat Galim'),(SELECT Route_Num from Route WHERE Route_Num='105')),
((SELECT Name from Train_Station WHERE Name='Netanya'),(SELECT Route_Num from Route WHERE Route_Num='105')),
((SELECT Name from Train_Station WHERE Name='Tel-Aviv University'),(SELECT Route_Num from Route WHERE Route_Num='105')),
((SELECT Name from Train_Station WHERE Name='Lod'),(SELECT Route_Num from Route WHERE Route_Num='105')),
((SELECT Name from Train_Station WHERE Name='Lod'),(SELECT Route_Num from Route WHERE Route_Num='205')),
((SELECT Name from Train_Station WHERE Name='Tel-Aviv University'),(SELECT Route_Num from Route WHERE Route_Num='205')),
((SELECT Name from Train_Station WHERE Name='Netanya'),(SELECT Route_Num from Route WHERE Route_Num='205')),
((SELECT Name from Train_Station WHERE Name='Haifa Bat Galim'),(SELECT Route_Num from Route WHERE Route_Num='205')),
((SELECT Name from Train_Station WHERE Name='Haifa Hof HaCarmel'),(SELECT Route_Num from Route WHERE Route_Num='205'));


Insert into Crew Values
((SELECT Id from Employee WHERE Id='1'),(SELECT Route_Num from Route WHERE Route_Num='100')),
((SELECT Id from Employee WHERE Id='2'),(SELECT Route_Num from Route WHERE Route_Num='100')),
((SELECT Id from Employee WHERE Id='3'),(SELECT Route_Num from Route WHERE Route_Num='200')),
((SELECT Id from Employee WHERE Id='4'),(SELECT Route_Num from Route WHERE Route_Num='200')),
((SELECT Id from Employee WHERE Id='5'),(SELECT Route_Num from Route WHERE Route_Num='101')),
((SELECT Id from Employee WHERE Id='6'),(SELECT Route_Num from Route WHERE Route_Num='101')),
((SELECT Id from Employee WHERE Id='7'),(SELECT Route_Num from Route WHERE Route_Num='201')),
((SELECT Id from Employee WHERE Id='8'),(SELECT Route_Num from Route WHERE Route_Num='201')),
((SELECT Id from Employee WHERE Id='9'),(SELECT Route_Num from Route WHERE Route_Num='102')),
((SELECT Id from Employee WHERE Id='10'),(SELECT Route_Num from Route WHERE Route_Num='102')),
((SELECT Id from Employee WHERE Id='11'),(SELECT Route_Num from Route WHERE Route_Num='202')),
((SELECT Id from Employee WHERE Id='12'),(SELECT Route_Num from Route WHERE Route_Num='202')),
((SELECT Id from Employee WHERE Id='13'),(SELECT Route_Num from Route WHERE Route_Num='103')),
((SELECT Id from Employee WHERE Id='14'),(SELECT Route_Num from Route WHERE Route_Num='103')),
((SELECT Id from Employee WHERE Id='15'),(SELECT Route_Num from Route WHERE Route_Num='203')),
((SELECT Id from Employee WHERE Id='16'),(SELECT Route_Num from Route WHERE Route_Num='203')),
((SELECT Id from Employee WHERE Id='17'),(SELECT Route_Num from Route WHERE Route_Num='104')),
((SELECT Id from Employee WHERE Id='18'),(SELECT Route_Num from Route WHERE Route_Num='104')),
((SELECT Id from Employee WHERE Id='19'),(SELECT Route_Num from Route WHERE Route_Num='204')),
((SELECT Id from Employee WHERE Id='20'),(SELECT Route_Num from Route WHERE Route_Num='204')),
((SELECT Id from Employee WHERE Id='21'),(SELECT Route_Num from Route WHERE Route_Num='105')),
((SELECT Id from Employee WHERE Id='22'),(SELECT Route_Num from Route WHERE Route_Num='105')),
((SELECT Id from Employee WHERE Id='23'),(SELECT Route_Num from Route WHERE Route_Num='205')),
((SELECT Id from Employee WHERE Id='24'),(SELECT Route_Num from Route WHERE Route_Num='205')),
((SELECT Id from Employee WHERE Id='25'),(SELECT Route_Num from Route WHERE Route_Num='106')),
((SELECT Id from Employee WHERE Id='26'),(SELECT Route_Num from Route WHERE Route_Num='106')),
((SELECT Id from Employee WHERE Id='27'),(SELECT Route_Num from Route WHERE Route_Num='206')),
((SELECT Id from Employee WHERE Id='28'),(SELECT Route_Num from Route WHERE Route_Num='206'));


/********* UPDATE & DELETE Commands ******/

SELECT 
    Id, Name
FROM
    Employee
WHERE
    Employee.Id = 24;

UPDATE Employee 
SET 
    Name = 'Momo Avraham'
WHERE
    Employee.Id = 24;

SELECT 
    Employee.Id, Employee.Name
FROM
    Employee;

/*back to previous name*/
UPDATE Employee 
SET 
    Name = 'Schahar Avraham'
WHERE
    Employee.Id = 24;


/******delete the train driver with least years of experience******/

SELECT 
    *
FROM
    Train_Driver
ORDER BY (Years_Of_Exp);

DELETE FROM Train_Driver 
WHERE
    Train_Driver.Years_Of_Exp = 1;
       
       
	Insert into Train_Driver Values
((SELECT Id from Employee WHERE Id='6'),1);


/*********Train_Driver Select Commands **************/

/*1-train ID with the accessible to disabled*/
SELECT 
    Train.train_num
FROM
    Train
        INNER JOIN
    Wagon ON wagon.train_num = Train.train_num
WHERE
    wagon.type = 'Accessible to the disabled';


/*2-amount of routes that have a stop at Tel-Aviv HaShalom*/
SELECT 
    COUNT(Route.route_num) AS 'Number of Routes'
FROM
    Route,
    Stopover
WHERE
    Route.route_num = stopover.route_num
        AND stopover.Train_Station_Name = 'Tel-Aviv HaShalom';

/*3-Show the number of actual routes that every train has*/
SELECT 
    train.*, COUNT(actual_route.Train_Num) AS 'Number of routes'
FROM
    train,
    actual_route
WHERE
    actual_route.Train_Num = train.Train_Num
GROUP BY train.Train_Num
HAVING (COUNT(actual_route.Train_Num) >= 1);

/*4-Show the details of the routes number that have two or more stopovers and count them*/
SELECT 
    route.Route_Num,
    route.Origin,
    route.Destination,
    COUNT(stopover.Train_Station_Name) AS 'Number of stopovers'
FROM
    route,
    stopover
WHERE
    route.Route_Num = stopover.Route_Num
GROUP BY route.Route_Num
HAVING (COUNT(stopover.Train_Station_Name) >= 2)
ORDER BY COUNT(stopover.Train_Station_Name) DESC;



/*5-Show each train station and its number of platforms*/
SELECT 
    Train_Station.Name AS 'Train Station Name',
    COUNT(Train_Station.Name) AS 'Number Of Platforms'
FROM
    Train_Station
        INNER JOIN
    Platform ON Train_Station.Name = Platform.Train_Station_Name
GROUP BY Train_Station.Name
ORDER BY (COUNT(Platform.Platform_Num)) DESC;


/*6-Retrieve the routes thatstops at haifa,and the number of routes for each route in haifa*/
SELECT 
    route.*,
    stopover.Train_Station_Name AS 'First step at haifa',
    COUNT(stopover.Train_Station_Name LIKE '%Haifa%') AS 'Number of stopovers at haifa'
FROM
    route,
    stopover
WHERE
    (route.Route_Num = stopover.Route_Num)
        AND stopover.Train_Station_Name LIKE '%Haifa%'
GROUP BY route.Route_Num;

/*7-Show the routes and their details with drivers that have more than 10 years of epxperience*/
SELECT 
    actual_route.*
FROM
    actual_route
        INNER JOIN
    crew ON crew.route_num = actual_route.route_num
        INNER JOIN
    employee ON employee.Id = crew.employee_ID
        INNER JOIN
    train_driver ON employee.Id = Train_driver.id
WHERE
    train_driver.years_of_exp > 10
ORDER BY train_driver.years_of_exp;


/*********Department of Transportation Select Commands **************/




/*1-Retrieve The Employees older than 45*/
SELECT
	Name, DOB, DATEDIFF(CURDATE(), Employee.DOB) / 365 AS Age
FROM
	Employee
WHERE
	DATEDIFF(CURDATE(), Employee.DOB) / 365 > 45;
    
    /*2-Retrieve list of train drivers by years of experience*/
SELECT 
    employee.*, train_driver.Years_Of_Exp
FROM
    train_driver,
    employee
WHERE
    employee.Id = train_driver.Id
ORDER BY Years_Of_Exp DESC;
    
/*3-Retrieve the routes that left behind schedule*/
SELECT
	Route.Route_Num,
	Route.time AS ScheduledTime,
	Actual_Route.time AS ActualDepartureTime
FROM
	Route,
	Actual_Route
WHERE
	(Actual_Route.time > Route.time
    	&& Route.Route_Num = Actual_Route.Route_Num)
ORDER BY ScheduledTime DESC;

/*4-Retrieve the most experienced train driver and the conductor that checked the most tickets*/
SELECT 
    Train_Driver.Id AS TrainDriverId,
    MAX(Years_Of_Exp) AS YearsOfExp,
    Conductor.Id AS ConductorId,
    MAX(Checked_Tickets_Num) AS CheckedTickets
FROM
    Employee,
    Train_Driver,
    Conductor
WHERE
    Years_Of_Exp = (SELECT 
            MAX(Years_Of_Exp)
        FROM
            Train_Driver)
        AND Checked_Tickets_Num = (SELECT 
            MAX(Checked_Tickets_Num)
        FROM
            Conductor);
            
/*5-Retrieve the trains that includes more than 1 wagon of type'Two floor' and it's number*/
SELECT 
    train.*, COUNT(wagon.Wagon_Num) AS 'Number of wagons'
FROM
    train,
    wagon
WHERE
    (wagon.Train_Num = train.Train_Num)
        AND (wagon.Type LIKE 'Two floor')
GROUP BY train.Train_Num
HAVING (COUNT(wagon.Wagon_Num) > 1);



/*6-Show the profit for each day and the number of passengers that used the train*/
SELECT 
    route.day,
    Actual_Route.Passengers_Num,
    SUM(ticket.price) AS 'Shekels'
FROM
    ticket
        INNER JOIN
    actual_route ON ticket.route_num = actual_route.route_num
        INNER JOIN
    route ON route.route_num = actual_route.route_num
GROUP BY route.day
ORDER BY Shekels DESC;




/*7-Retrieve the number of tickets of type 'Student' that took 'Electric' Train*/
SELECT 
    COUNT(Ticket.Ticket_Num) AS 'Number Of Tickets'
FROM
    Ticket
        INNER JOIN
    Actual_Route ON Actual_route.route_num = Ticket.route_num
        INNER JOIN
    Train ON Train.Train_num = Actual_route.Train_num
WHERE
    Train.Type = 'Electric'
        AND ticket.Type = 'Student';








/************Triggers*******/


CREATE TABLE TrainStation_Log (
    old_name VARCHAR(100),
    new_name VARCHAR(100),
    old_address VARCHAR(100),
    new_address VARCHAR(100),
    command_ts TIMESTAMP,
    command VARCHAR(10)
);


delimiter $
CREATE TRIGGER trainSt_ins_trg AFTER INSERT ON Train_Station
FOR EACH ROW
BEGIN
 INSERT INTO TrainStation_Log VALUES(null, new.name, null, new.address, now(), 'insert');
END$
   
delimiter ;


delimiter $
CREATE TRIGGER trainSt_upd_trg AFTER UPDATE ON Train_Station
FOR EACH ROW
BEGIN
 INSERT INTO TrainStation_Log VALUES(old.name, new.name, old.address, new.address, now(), 'update');
END$
   
delimiter ;

delimiter $
CREATE TRIGGER trainSt_del_trg AFTER DELETE ON Train_Station
FOR EACH ROW
BEGIN
 INSERT INTO TrainStation_Log VALUES(old.name, null, old.address, null, now(), 'delete');
END$
delimiter ;








