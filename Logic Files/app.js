const sql = require('mssql');

const config = require('./config');
const query = require('./query');
const checkAvailability = require('./checkAvailability');
const createReservation = require('./createReservation')
const login = require('./login');
const signup = require('./signup');
const registerHotel = require('./registerHotel');
const registerRoom = require('./registerRoom');
const checkin = require('./checkin');
const checkout = require('./checkout');
const generateBill = require('./generateBill');



//example calls 

checkAvailability(8, '2024-08-01', '2024-08-01');
createReservation(3, 9, '2024-08-08', '2024-08-09');
query();
login('ankan123', 'password123');
signup('ankan1', 'password123', 'example@gmail.com', 'customer');

registerHotel('Test Hotel1', 'Address1', 'Kolkata', 'India');

registerRoom(1, '110', 'Double', 999.23);

checkin(1);
checkout(1);

generateBill(1);







