const sql = require('mssql');
const config = require('./config');

//Signup function
async function signup(UserName, Password, Email, Role){
    try {                                                      
        await sql.connect(config);

        const request = new sql.Request();
        
        request.input('UserName', sql.NVarChar, UserName);            
        request.input('Password', sql.NVarChar, Password);  
        request.input('Email', sql.NVarChar, Email);  
        request.input('Role', sql.NVarChar, Role);  
    
        const result = await request.execute('SignUP');

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

module.exports = signup;
