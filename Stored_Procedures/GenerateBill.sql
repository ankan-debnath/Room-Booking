--Genereate Bills Procedure
CREATE PROCEDURE GenerateBill
    @ReservationID INT
AS
BEGIN
    DECLARE @TotalAmount DECIMAL(10, 2);

    If EXISTS (SELECT 1 FROM Reservations WHERE ReservationID = @ReservationID )
    BEGIN
       
        IF EXISTS( SELECT 1 FROM Reservations WHERE ReservationID=@ReservationID AND (Status ='Checkedin' OR Status = 'Confirmed')) 
        BEGIN
            IF EXISTS (SELECT 1 FROM Reservations WHERE @ReservationID 
                IN (SELECT ReservationID from Billing)
            )
            BEGIN
                SELECT 'Bille already generated!' as Message;
            END

            ELSE
            BEGIN

                SELECT @TotalAmount = DATEDIFF(DAY, CheckInDate, CheckOutDate) * r.PricePerNight
                FROM Reservations rs
                JOIN Rooms r ON (rs.RoomID = r.RoomID)
                WHERE rs.ReservationID = @ReservationID;

                INSERT INTO Billing (ReservationID, TotalAmount, PaymentStatus)
                VALUES (@ReservationID, @TotalAmount, 'Pending');

                SELECT * from Billing where ReservationID = @ReservationID;

            END
        END

        ELSE
        BEGIN
            SELECT 'Sorry! Not confirmed or already checkedin/checkedout !' as Message;
        END

    END
    
    ELSE
    BEGIN
        SELECT 'No such Reservation found!' as Message;
    END
END;