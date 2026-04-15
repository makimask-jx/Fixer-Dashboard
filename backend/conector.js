const mariadb = require("mariadb");
// This credentials don't matter if leaked, they are only available in a local VM
const pool = mariadb.createPool({
  host: "localhost",
  user: "root",
  password: "1111",
  connectionLimit: 5,
});
