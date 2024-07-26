const sql = require('mssql');
const config = require('./config');

//register hotel
async function registerHotel(HotelName, Address, City, Country){
    try {                                                      
        await sql.connect(config);

        const request = new sql.Request();
        
        request.input('HotelName', sql.NVarChar, HotelName);            
        request.input('Address', sql.NVarChar, Address);  
        request.input('City', sql.NVarChar, City);  
        request.input('Country', sql.NVarChar, Country);  
    
        const result = await request.execute('RegisterHotel');

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

module.exports = registerHotel;
