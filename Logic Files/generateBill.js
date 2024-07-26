const sql = require('mssql');
const config = require('./config');

async function generateBill(ReservationID){
    try {                                                      
        await sql.connect(config);

        const request = new sql.Request();
        
        request.input('ReservationID', sql.Int, ReservationID);            
    
        const result = await request.execute('GenerateBill');

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

module.exports = generateBill;