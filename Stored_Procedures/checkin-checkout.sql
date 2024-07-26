-- Procedure for Check-In
CREATE PROCEDURE CheckIn
    @ReservationID INT
AS
BEGIN

    IF EXISTS (SELECT 1 FROM Reservations WHERE ReservationID=@ReservationId)
    BEGIN
        IF EXISTS (SELECT 1 FROM Reservations WHERE ReservationID=@ReservationId AND Status='Confirmed')
        BEGIN

            UPDATE Reservations
            SET Status = 'CheckedIn'
            WHERE ReservationID = @ReservationID;

            SELECT 'Checkin Successful!' as Message;

        END
        
        ELSE
        BEGIN
            SELECT 'Checkin Denied. Reservation cancled/pending or alredy checkedin/checkedout !' as Message;
        END
    END

    ELSE
    BEGIN
        SELECT 'No such reservation !' as Message;
    END
    
END;

-- Procedure for Check-Out
CREATE PROCEDURE CheckOut
    @ReservationID INT
AS
BEGIN

    IF EXISTS (SELECT 1 FROM Reservations WHERE ReservationID=@ReservationId)
    BEGIN
        IF EXISTS (SELECT 1 FROM Reservations WHERE ReservationID=@ReservationId AND Status='CheckedIN')
        BEGIN

            UPDATE Reservations
            SET Status = 'CheckedOut'
            WHERE ReservationID = @ReservationID;
            
            UPDATE Billing
            SET PaymentStatus = 'Paid', PaymentDate = GETDATE()
            WHERE ReservationID = @ReservationID;

            SELECT 'Checkout Successful!' as Message;

        END
        
        ELSE
        BEGIN
            SELECT 'Checkout Denied. Reservation cancled/pending or alredy checkedout/ not checkedin yet !' as Message;
        END
    END

    ELSE
    BEGIN
        SELECT 'No such reservation !' as Message;
    END

    
END;
