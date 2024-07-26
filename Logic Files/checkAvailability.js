const sql = require('mssql');
const config = require('./config');

const checkAvailability = async function (Room_ID, Checkin_DT, Checkout_DT) {    // checkAvailability function eg. 
    try {                                                               // checkAvailability(1, '2024-08-01', '2024-08-05');
        await sql.connect(config);

        const request = new sql.Request();
        
        request.input('Room_ID', sql.Int, Room_ID);            
        request.input('Checkin_DT', sql.Date, Checkin_DT);  
        request.input('Checkout_DT', sql.Date, Checkout_DT);

        const result = await request.execute('CheckRoomAvailability');


        // console.log(result.recordsets[0][0].Message);
        console.log(result.recordsets);

        // result.recordsets has two fields 
        // - message & output  array

        return result.recordsets;
        
    } catch (err) {
        
        console.error('Procedure execution  error\n\n', err);

    }finally{
        await sql.close();
    }

};

module.exports = checkAvailability;