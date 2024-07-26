CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(50) NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Role NVARCHAR(20) NOT NULL
);

CREATE TABLE Hotels (
    HotelID INT PRIMARY KEY IDENTITY(1,1),
    HotelName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    Country NVARCHAR(50) NOT NULL
);

CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY IDENTITY(1,1),
    HotelID INT FOREIGN KEY REFERENCES Hotels(HotelID),
    RoomNumber NVARCHAR(10) NOT NULL,
    RoomType NVARCHAR(50) NOT NULL,
    PricePerNight DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Reservations (
    ReservationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    RoomID INT FOREIGN KEY REFERENCES Rooms(RoomID),
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    Status NVARCHAR(20) NOT NULL -- "Confirmed", "Cancelled", "Pending", "Checkdin", "Checkedout"
);


CREATE TABLE Billing (
    BillID INT PRIMARY KEY IDENTITY(1,1),
    ReservationID INT FOREIGN KEY REFERENCES Reservations(ReservationID),
    TotalAmount DECIMAL(10, 2) NOT NULL,
    PaymentStatus NVARCHAR(20) NOT NULL, --"Paid", "Pending"
    PaymentDate DATE
);