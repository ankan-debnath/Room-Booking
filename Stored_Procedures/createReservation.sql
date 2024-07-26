CREATE PROCEDURE CreateReservation
    @UserID int,
    @RoomID int,
    @CheckInDate DATE,
    @CheckOutDate DATE

AS
BEGIN

    INSERT INTO Reservations(UserID, RoomID, CheckInDate, CheckOutDate, Status) VALUES
    (@UserID, @RoomID, @CheckInDate, @CheckOutDate, 'Confirmed');

    SELECT ReservationID, RoomID, CheckINDate, CheckOutDate, Status, 'Reservation Successful' as Message FROM
    Reservations  WHERE UserID=@UserID AND RoomID=@RoomID AND CheckInDate=@CheckInDate AND CheckOutDate=@CheckOutDate
    AND Status='Confirmed';

END