const sql = require('mssql');
const config = require('./config');

console.log(config);


const query = async function (query){            //Query function for any query execution
    try{
        await sql.connect(config);
        
        const result = await sql.query(query);
        console.log(result);
        return result.recordsets;
    }
    catch(err){ 
        console.log("Database connection error", err );

    }
    finally{
        await sql.close();
    }
};

module.exports = query;