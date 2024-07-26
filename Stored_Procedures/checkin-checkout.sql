-- Procedure for Check-In
CREATE PROCEDURE CheckIn
    @ReservationID INT
AS
BEGIN
    UPDATE Reservations
    SET Status = 'CheckedIn'
    WHERE ReservationID = @ReservationID;
END;

-- Procedure for Check-Out
CREATE PROCEDURE CheckOut
    @ReservationID INT
AS
BEGIN
    UPDATE Reservations
    SET Status = 'CheckedOut'
    WHERE ReservationID = @ReservationID;
    
    UPDATE Billing
    SET PaymentStatus = 'Paid', PaymentDate = GETDATE()
    WHERE ReservationID = @ReservationID;
END;
