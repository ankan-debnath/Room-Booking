Create PROCEDURE CheckRoomAvailability
    @Room_ID int,
    @Checkin_DT DATE,
    @Checkout_DT DATE

AS
BEGIN

    IF EXISTS (
        SELECT 1 FROM Reservations WHERE
        RoomID = @Room_ID AND
        (Status = 'Confirmed' OR Status = 'Pending') AND
        (CheckInDate <= @Checkout_DT AND CheckOutDate >= @Checkin_DT)
    )
        BEGIN

            SELECT 'Unavailable' as Message;
            Declare @Hotel_ID int;
            
            SELECT @Hotel_ID = HotelID from Rooms WHERE
            RoomID = @Room_ID;
    
            SELECT * FROM (
                SELECT DISTINCT R.RoomID, R.RoomNumber, 'Available' as [Availability] from Rooms R LEFT JOIN Reservations Res
                ON (Res.RoomID = R.RoomID) WHERE
                R.HotelID = @Hotel_ID AND
                (
                    ReservationID is NULL OR
                    R.RoomID not  in (
                        SELECT DISTINCT R.RoomID from Rooms R JOIN Reservations Res
                        ON (Res.RoomID = R.RoomID) WHERE
                        R.HotelID = @Hotel_ID AND 
                        (Status = 'Confirmed' OR Status = 'Pending') AND
                        (CheckInDate <= @Checkout_DT AND CheckOutDate >= @Checkin_DT) 
                    )
                    
                )

            )AS Alternative_Options;
        END
    ELSE
        BEGIN
            SELECT 'Available' as Message;
        END
    
END