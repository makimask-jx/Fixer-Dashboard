const mariadb = require("mariadb");
// This credentials don't matter if leaked, they are only available in a local VM

// Connect to a local mariadb instance
const pool = mariadb.createPool({
  host: "127.0.0.1",
  user: "edgerunner",
  password: "1111",
  database: "edgerunner",
  connectionLimit: 5,
});

async function testQuery() {
  let connection;
  try {
    connection = await pool.getConnection();
    q;
    const rows = await connection.query("SELECT alias FROM MERCENARIO;");
    console.log(rows);
  } catch (err) {
    throw err;
  } finally {
    if (connection) connection.release();
  }
}

testQuery();
