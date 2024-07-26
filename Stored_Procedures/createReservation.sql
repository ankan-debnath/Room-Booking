CREATE PROCEDURE CreateReservation
    @UserID int,
    @RoomID int,
    @CheckInDate DATE,
    @CheckOutDate DATE

AS
BEGIN

    INSERT INTO Reservations(UserID, RoomID, CheckInDate, CheckOutDate, Status) VALUES
    (@UserID, @RoomID, @CheckInDate, @CheckInDate, 'Confirmed');

END