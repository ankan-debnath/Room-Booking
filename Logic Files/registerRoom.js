const sql = require('mssql');
const config = require('./config');

async function registerRoom(HotelID, RoomNumber, RoomType, PricePerNight){
    try {                                                      
        await sql.connect(config);

        const request = new sql.Request();
        
        request.input('HotelID', sql.Int, HotelID);            
        request.input('RoomNumber', sql.NVarChar, RoomNumber);  
        request.input('RoomType', sql.NVarChar, RoomType);  
        request.input('PricePerNight', sql.Decimal, PricePerNight);  
    
        const result = await request.execute('RegisterRoom');

        console.log(result.recordsets);

        // result.recordsets has two fields 
        // - message & output  array

        return result.recordsets;
        
    } catch (err) {
        console.error('Procedure execution  error\n\n', err);
    }finally{
        await sql.close();
    }
}

module.exports = registerRoom;