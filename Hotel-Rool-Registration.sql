-- Procedure to register a new hotel

CREATE PROCEDURE RegisterHotel
    @HotelName NVARCHAR(100),
    @Address NVARCHAR(255),
    @City NVARCHAR(50),
    @Country NVARCHAR(50)
AS
BEGIN
    INSERT INTO Hotels (HotelName, Address, City, Country)
    VALUES (@HotelName, @Address, @City, @Country);
    
    SELECT 'Hotel Registered' as Message;
END;


-- Procedure to register a new room
CREATE PROCEDURE RegisterRoom
    @HotelID INT,
    @RoomNumber NVARCHAR(10),
    @RoomType NVARCHAR(50),
    @PricePerNight DECIMAL(10, 2)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Rooms WHERE HotelID=@HotelID AND RoomNumber=@RoomNumber)
    BEGIN

        SELECT 'Sorry! room already exists with this Room Number in this Hotel'
        AS Message;

    END

    ELSE
    BEGIN

        INSERT INTO Rooms (HotelID, RoomNumber, RoomType, PricePerNight)
        VALUES (@HotelID, @RoomNumber, @RoomType, @PricePerNight);
        
        SELECT 'New Room Registered !';

    END
END;
