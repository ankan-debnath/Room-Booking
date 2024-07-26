const sql = require('mssql');
const config = require('./config');



//Login function
const login = async function (UserName, password){
    try {                                                         
        await sql.connect(config);

        const request = new sql.Request();
        
        request.input('UserName', sql.NVarChar, UserName);            
        request.input('password', sql.NVarChar, password);  
    
        const result = await request.execute('UserLogin');

        console.log(result.recordsets);

        // result.recordsets has two fields 
        // - message & output array

        return result.recordsets;
        
    } catch (err) {
        
        console.error('Procedure execution  error\n\n', err);

    }finally{
        await sql.close();
    }

};

module.exports = login;