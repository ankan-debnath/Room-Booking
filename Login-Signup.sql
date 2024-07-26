--  Login Procedure
CREATE PROCEDURE UserLogin
    @UserName NVARCHAR(50),
    @password NVARCHAR(50)
AS
BEGIN
    
    IF EXISTS (SELECT 1 FROM Users WHERE UserName = @UserName)
    BEGIN
        IF EXISTS( SELECT 1 FROM Users WHERE UserName=@UserName AND Password = @password)
        BEGIN
            SELECT UserName, Email, Role from Users WHERE
            UserName=@UserName;
        END

        ELSE
        BEGIN
            SELECT 'Password Not Matched' as Message;
        END
    END

    ELSE
    BEGIN
        SELECT 'User Not Found' as Message;
    END

END

--Signup Procedure
CREATE PROCEDURE SignUP
    @UserName NVARCHAR(50),
    @Password NVARCHAR(50),
    @Email NVARCHAR(100),
    @Role NVARCHAR(20)
AS
BEGIN

    IF EXISTS ( SELECT 1 FROM Users WHERE UserName = @UserName)
    BEGIN

        SELECT 'User with same UserName exists' as Message;
    
    END
    
    ELSE
    BEGIN

        INSERT INTO Users(UserName, Password, Email, Role) VALUES
        (@UserName, @Password, @Email, @Role);
        
        SELECT 'Sign up successful' as Message;

    END

END