
# Railway Ticket Booking System

## Project Background
Railway ticket booking systems are essential for efficiently managing reservations in a railway network. This project aims to develop a robust system that allows users to search for trains, book tickets, and manage reservations online.

## Project Description
The Railway Ticket Booking System provides functionalities for users to:

1. Search for trains based on source, destination, date, and class.
2. View available seats and fares for selected trains.
3. Book tickets by providing passenger details and making secure payments.
4. Manage bookings, including cancellation and modification of reservations.
5. Generate e-tickets and receipts for successful bookings.

## ER Diagram
*The ER diagram visually represents the structure of the database, including entities, attributes, and relationships.*

**Main Components:**

- **User:** Attributes include `UserID`, `Username`, `Password`, `Name`, `Email`.
- **Train:** Attributes include `TrainID`, `TrainName`, `DepartureStationID`, `ArrivalStationID`, `DepartureTime`, `ArrivalTime`.
- **Station:** Attributes include `StationID`, `StationName`, `Location`.
- **Booking:** Attributes include `BookingID`, `UserID`, `TrainID`, `BookingDate`, `TotalFare`, `Status`.
- **Ticket:** Attributes include `TicketID`, `BookingID`, `PassengerName`, `SeatNumber`, `Fare`.
- **Seat:** Attributes include `SeatID`, `TrainID`, `SeatNumber`, `Class`, `Availability`.

**Relationships:**

- User → Booking: One-to-Many
- Train → Station: Many-to-Many (via TrainStation)
- Booking → Ticket: One-to-Many
- Train → Seat: One-to-Many

## Database Tables

### User Table
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

### Train Table
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

### Station Table
CREATE TABLE Station (
    StationID INT PRIMARY KEY,
    StationName VARCHAR(100) NOT NULL,
    Location VARCHAR(100) NOT NULL
);

### Booking Table
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

### Ticket Table
CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY,
    BookingID INT,
    PassengerName VARCHAR(100) NOT NULL,
    SeatNumber VARCHAR(10),
    Fare DECIMAL(10,2),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

### Seat Table
CREATE TABLE Seat (
    SeatID INT PRIMARY KEY,
    TrainID INT,
    SeatNumber VARCHAR(10),
    Class VARCHAR(20),
    Availability VARCHAR(10),
    FOREIGN KEY (TrainID) REFERENCES Train(TrainID)
);

## Sample Data
- Users: John Doe, Jane Smith, Mike Brown, Sarah Lee, David Kim
- Trains: Express 101, FastTrack 102, SuperSonic 103, Speedy 104, RapidTransit 105
- Stations: Station A (City X) … Station E (City V)
- Bookings & Tickets: Sample bookings with associated seats and fares
- Seats: Sample seat data for all trains

## SQL Queries

1. Retrieve all bookings made by **John Doe**:
SELECT * FROM Booking WHERE UserID = 1;

2. List all available seats on **Express 101**:
SELECT * FROM Seat WHERE TrainID = 101 AND Availability = 'Available';

3. Retrieve all bookings made on **2024-04-22**:
SELECT * FROM Booking WHERE BookingDate = '2024-04-22';

## Views

1. **findJohnDoe:** Tickets for John Doe
CREATE VIEW findJohnDoe AS
SELECT * FROM Ticket WHERE PassengerName = 'John Doe';

2. **UserTable:** List of all users
CREATE VIEW UserTable AS SELECT * FROM User;

3. **BookingsToday:** Bookings on current date
CREATE VIEW BookingsToday AS
SELECT * FROM Booking WHERE BookingDate = CURRENT_DATE;

4. **DisplayStationNames:** All station names
CREATE VIEW DisplayStationNames AS
SELECT StationName FROM Station;

5. **TicketSeatInfo:** Ticket seat details
CREATE VIEW TicketSeatInfo AS
SELECT TicketID, SeatNumber FROM Ticket;

## Normalization
All tables are normalized up to **3rd Normal Form (3-NF)**:

1. 1-NF: Atomic attributes, no repeating groups  
2. 2-NF: No partial dependencies  
3. 3-NF: No transitive dependencies  

## Conclusion
The Railway Ticket Booking System provides a reliable platform for users to search trains, book tickets, manage reservations, and view e-tickets. The database design ensures data integrity and minimizes redundancy through proper normalization.
