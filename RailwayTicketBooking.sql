CREATE DATABASE Railway_Ticket_Booking_sys;
USE Railway_Ticket_Booking_sys;
DROP DATABASE Railway_Ticket_Booking_sys;
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

CREATE TABLE Station (
    StationID INT PRIMARY KEY,
    StationName VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL
);

CREATE TABLE Train (
    TrainID INT PRIMARY KEY,
    TrainName VARCHAR(100) NOT NULL,
    DepartureStationID INT,
    ArrivalStationID INT,
    DepartureTime TIME,
    ArrivalTime TIME,
    FOREIGN KEY (DepartureStationID) REFERENCES Station(StationID),
    FOREIGN KEY (ArrivalStationID) REFERENCES Station(StationID)
);

CREATE TABLE Booking (
    BookingID INT PRIMARY KEY,
    UserID INT,
    TrainID INT,
    BookingDate DATE,
    TotalFare DECIMAL(10,2),
    Status VARCHAR(20),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (TrainID) REFERENCES Train(TrainID)
);

CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY,
    BookingID INT,
    PassengerName VARCHAR(100) NOT NULL,
    SeatNumber VARCHAR(10),
    Fare DECIMAL(10,2),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE Seat (
    SeatID INT PRIMARY KEY,
    TrainID INT,
    SeatNumber VARCHAR(10),
    Class VARCHAR(20),
    Availability VARCHAR(10),
    FOREIGN KEY (TrainID) REFERENCES Train(TrainID)
);

INSERT INTO User (UserID, Username, Password, Name, Email)
VALUES
(1, 'user123', '', 'John Doe', 'john@example.com'),
(2, 'janesmith', '', 'Jane Smith', 'jane@example.com'),
(3, 'mike23', '', 'Mike Brown', 'mike@example.com'),
(4, 'sarah88', '', 'Sarah Lee', 'sarah@example.com'),
(5, 'davidK', '', 'David Kim', 'david@example.com');

INSERT INTO Station (StationID, StationName, Location)
VALUES
(1, 'Station A', 'City X'),
(2, 'Station B', 'City Y'),
(3, 'Station C', 'City Z'),
(4, 'Station D', 'City W'),
(5, 'Station E', 'City V');

INSERT INTO Train (TrainID, TrainName, DepartureStationID, ArrivalStationID, DepartureTime, ArrivalTime) 
VALUES 
(101, 'Express 101', 1, 5, '08:00', '12:00'), 
(102, 'FastTrack 102', 3, 4, '10:30', '14:30'), 
(103, 'SuperSonic 103', 2, 2, '12:00', '16:30'), 
(104, 'Speedy 104', 5, 3, '15:00', '19:30'), 
(105, 'RapidTransit 105', 4, 1, '18:30', '22:30');

INSERT INTO Booking (BookingID, UserID, TrainID, BookingDate, TotalFare, Status)
VALUES
(1001, 1, 101, '2024-04-20', 50.00, 'Confirmed'),
(1002, 2, 102, '2024-04-21', 70.00, 'Confirmed'),
(1003, 3, 103, '2024-04-22', 80.00, 'Confirmed'),
(1004, 4, 104, '2024-04-23', 90.00, 'Confirmed'),
(1005, 5, 105, '2024-04-24', 60.00, 'Confirmed');

INSERT INTO Ticket (TicketID, BookingID, PassengerName, SeatNumber, Fare)
VALUES
(5001, 1001, 'John Doe', 'A12', 25.00),
(5002, 1002, 'Jane Smith', 'B24', 35.00),
(5003, 1003, 'Mike Brown', 'C34', 40.00),
(5004, 1004, 'Sarah Lee', 'D45', 45.00),
(5005, 1005, 'David Kim', 'E56', 30.00);


-- SELECT * FROM Booking;


CREATE VIEW BookingsToday AS
SELECT *
FROM Booking
WHERE BookingDate = CURRENT_DATE;

SELECT * FROM BookingsToday;

CREATE VIEW findJohnDoe AS
SELECT *
FROM Ticket
WHERE PassengerName = "John Doe";

SELECT * FROM findJohnDoe;

CREATE VIEW UserTable AS
SELECT *
FROM User;

SELECT * FROM UserTable;

CREATE VIEW DisplayStationNames AS
SELECT StationName
FROM Station;
select *from DisplayStationNames;

CREATE VIEW TicketSeatInfo AS
SELECT TicketID, SeatNumber
FROM Ticket;

SELECT * FROM TicketSeatInfo;
