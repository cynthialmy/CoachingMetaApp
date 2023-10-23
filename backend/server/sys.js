const router = require('express').Router();
var {connection} = require("./dbInfo");
mysql = require('mysql2');

/**
 * @description - Save a new client
 * @returns {void}
 */
router.post("/createUser", (req, res) => {
	// new table should be created to store daily workout logs: dailyLog
	var reqBody = req.body
	try {
		var sql = `INSERT INTO user_relationship
            (
                uid, userRole
            )
            VALUES
            (
                '${reqBody.uid}', '${reqBody.userRole}'
            )`;
		connection.query(sql, function (err, result) {
			if (err) {
				console.error(err);
				res.status(400).json({
					Error: err.code
				});
			} else {
				console.log(req.params.id);
				console.log(result);
				res.status(201).json({ 'Info': "Client Created Successfully" });
			}
		});
	} catch (e) {
		consol.log("Error posting end of day work out plan. Error: ", e)
		res.send({ "status": "FAILURE", "statusMessage": "Failed to post a new user. Error: ", e })
	}
})

/**
 * @description - Get the user role when logging in
 *
 */
router.get("/getLoginRole/:uid", (req, res) => {
	try {
		let sql = `select * from user_relationship where uid = '${req.params.uid}'`;
		connection.query(sql, function (err, result) {
			if (err) {
				console.error(err);
				res.status(400).send({
					Error: err.code
				});
			} else {
				if (result.length == 0) {
					console.log("Error, no user for the current login account in the database");
					res.status(404).send({
						Error: 404,
						message: "Error, no such data in the database"
					});
				} else {
					let resArr = Array();
					for (let i = 0; i < 1; i++) {
						let uid = result[i]['uid']
						let userRole = result[i]['userRole'];
						resArr.push(
							{
								"uid": uid,
								'role': userRole
							});
					}
					console.log(resArr);
					res.status(200).json(resArr);
				}
			}
		});
	} catch (e) {
		console.log("Error getting login user role. Error: ", e)
		res.send({ "status": "FAILURE", "statusMessage": "Failed to get the user role. Error: ", e })
	}
})

module.exports = router;