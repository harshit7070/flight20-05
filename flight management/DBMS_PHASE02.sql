-- Recreate the database with enhanced schema
DROP DATABASE IF EXISTS flight;
CREATE DATABASE flight;
USE flight;

-- User table for authentication
CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Role ENUM('Admin', 'Staff', 'Passenger') NOT NULL,
    Password VARCHAR(255) NOT NULL
);

-- Aircraft table
CREATE TABLE Aircraft (
    AircraftID INT PRIMARY KEY AUTO_INCREMENT,
    Model VARCHAR(100) NOT NULL,
    Capacity INT NOT NULL,
    MaintenanceStatus ENUM('Operational', 'Under Maintenance') NOT NULL
);

-- Flight table with Delay column
CREATE TABLE Flight (
    FlightID INT PRIMARY KEY AUTO_INCREMENT,
    Source VARCHAR(100) NOT NULL,
    Destination VARCHAR(100) NOT NULL,
    DepartureTime DATETIME NOT NULL,
    ArrivalTime DATETIME NOT NULL,
    AircraftID INT,
    Status ENUM('On Time', 'Delayed') DEFAULT 'On Time',
    FOREIGN KEY (AircraftID) REFERENCES Aircraft(AircraftID) ON DELETE SET NULL
);

-- Ticket table with TripType column
CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY AUTO_INCREMENT,
    PassengerID INT NOT NULL,
    FlightID INT NOT NULL,
    BookingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Price DECIMAL(10,2) NOT NULL,
    SeatNumber VARCHAR(10),
    Status ENUM('Booked', 'Cancelled', 'Completed') NOT NULL,
    TripType ENUM('One Way', 'Round Trip') NOT NULL,
    FOREIGN KEY (PassengerID) REFERENCES User(UserID) ON DELETE CASCADE,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID) ON DELETE CASCADE
);

-- Payment table
CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    TicketID INT UNIQUE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(50) DEFAULT 'Credit Card',
    Status ENUM('Pending', 'Completed', 'Failed', 'Refunded') NOT NULL,
    TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (TicketID) REFERENCES Ticket(TicketID) ON DELETE CASCADE
);

-- Insert sample aircraft data
INSERT INTO Aircraft (Model, Capacity, MaintenanceStatus) 
VALUES 
('Boeing 737', 180, 'Operational'),
('Airbus A320', 150, 'Operational'),
('Boeing 787', 250, 'Operational'),
('Airbus A380', 525, 'Operational');

-- Insert sample flight data
INSERT INTO Flight (Source, Destination, DepartureTime, ArrivalTime, AircraftID)
VALUES
('New York', 'London', '2025-05-01 08:00:00', '2025-05-01 20:00:00', 1),
('London', 'Paris', '2025-05-02 10:00:00', '2025-05-02 11:30:00', 2),
('Tokyo', 'Seoul', '2025-05-03 14:00:00', '2025-05-03 16:00:00', 3),
('Dubai', 'Mumbai', '2025-05-04 23:00:00', '2025-05-05 01:30:00', 4),
('Los Angeles', 'New York', '2025-05-05 06:00:00', '2025-05-05 14:00:00', 1),
('Paris', 'Rome', '2025-05-15 09:00:00', '2025-05-15 11:00:00', 2),
('Rome', 'Paris', '2025-05-25 09:00:00', '2025-05-25 11:00:00', 2);

-- Create a test admin user (password: admin123)
INSERT INTO User (Name, Email, Role, Password) 
VALUES ('Admin User', 'admin@example.com', 'Admin', '$2b$12$tG0m8GLFIuSI5aTSkSF0aeNI8u1CCSvO/7KvWh7.WYI4BcQgH09.G');