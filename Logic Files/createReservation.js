const sql = require('mssql');
const config = require('./config');
const checkAvailability = require('./checkAvailability');

//Reservation function eg. createReservation(3, 8, '2024-08-08', '2024-08-09')
const createReservation =  async function (UserID ,RoomID, CheckInDate , CheckOutDate){
    try {                                                            

        const ifAvailable = await checkAvailability(RoomID, CheckInDate, CheckOutDate);
        
        await sql.connect(config);

        if(ifAvailable[0][0].Message === 'Available'){
            const request = new sql.Request();
        
            request.input('UserID', sql.Int, UserID);            
            request.input('RoomID', sql.Int, RoomID);  
            request.input('CheckInDate', sql.Date, CheckInDate);
            request.input('CheckOutDate', sql.Date, CheckOutDate);

            const result = await request.execute('CreateReservation');

            console.log(result.recordsets);

            return result.recordsets;
        }
        else{
            console.log('Room not available\nAlternative Options : ');

            ifAvailable[1].forEach(element => {
                console.log(element);
            });
        }

        return ifAvailable[1];

        // result.recordsets has two fields 
        // - message & ouput  array
        
    } catch (err) {
        
        console.error('Procedure execution  error\n\n', err);

    }finally{
        await sql.close();
    }
};

module.exports = createReservation;