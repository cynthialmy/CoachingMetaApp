// import all required modules
const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

mysql = require('mysql2');

const clientRouter = require('./clients');
app.use('/client', clientRouter);

const coachRouter = require('./coach');
app.use('/coach', coachRouter);

const sysRouter = require('./sys');
app.use('/sys', sysRouter);

app.get("/", (req, res) => {
	res.send("Hello World");
})


const port = process.env.PORT || 6601;
app.listen(port, () => {
	console.log(`Server is running on port ${port}`)
	console.log(`Click here to open: http://localhost:${port}`)
});