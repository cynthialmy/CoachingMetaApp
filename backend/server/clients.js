const router = require('express').Router();
var { connection } = require("./dbInfo");
mysql = require('mysql2');


/**
 * @description - Get the client details using clientId from clients DB
 * @example - 
 * @returns {void}
 */
router.route('/getInfo/:clientid').get(function (req, res) {
    const clientid = req.params.clientid;
    var sql = `select * from clients where client_id = '${clientid}';`;
    connection.query(sql, function (err, result) {
        if (err) {
            console.error(err);
            res.status(400).send({
                Error: err.code
            });
        } else {
            if (result.length == 0) {
                console.log("Error, no such client in the database");
                res.status(404).send({
                    Error: 404,
                    message: "Error, no such data in the database"
                });
            } else {
                let resArr = Array();
                let client_name = result[0]['client_name'];
                let birthday = result[0]['birthday'];
                let gender = result[0]['gender'];
                let height = result[0]['height'];
                let weight = result[0]['weight'];
                let exercise_preference = result[0]['exercise_preference'];

                let data =
                {
                    'client_name': client_name,
                    "birthday": birthday,
                    "gender": gender,
                    "height": height,
                    'weight': weight,
                    "exercisePreference": exercise_preference
                };
                console.log(resArr);
                res.status(200).json(data);
            }
        }
    });
});

/**
 * @description - Get the the latest plan from coach
 * @example - 
 * @returns {void}
 */
router.route('/getRecentPlan/:clientid').get(function (req, res) {
    const clientid = req.params.clientid;
    let updateDate = null;
    var sql =
        `
    select * from planTasks where update_date = (select update_date from planTasks where client_id = '${clientid}' order by update_date desc limit 1);`;
    console.log(sql);
    connection.query(sql, function (err, result) {
        if (err) {
            console.error(err);
            res.status(400).send({
                Error: err.code
            });
        } else {
            if (result.length == 0) {
                console.log("Error, no plan for the current client in the database");
                res.status(404).send({
                    Error: 404,
                    message: "Error, no such data in the database"
                });
            } else {
                console.log(result);
                let resArr = Array();
                for (let i = 0; i < result.length; i++) {
                    let task_id = result[i]['task_id']
                    let task_name = result[i]['task_name'];
                    let update_date = result[i]['update_date'];
                    let client_id = result[i]['client_id'];
                    let isDone = result[i]['isDone'];
                    let description = result[i]['description'];
                    updateDate = update_date;
                    resArr.push(
                        {
                            "task_id": task_id,
                            'task_name': task_name,
                            "update_date": update_date,
                            "client_id": client_id,
                            "isDone": isDone,
                            'description': description
                        });
                }
                console.log(resArr);
                res.status(200).json({ 'client_id': clientid, 'update_date': updateDate, 'tasks': resArr });
            }
        }
    });
});

/**
 * @description - Get the the latest plan from coach
 * @example - 
 * @returns {void}
 */
router.route('/getPlan/:clientid/:date').get(function (req, res) {
    const clientid = req.params.clientid;
    const date = req.params.date;
    var sql =
        `
    select * from planTasks where client_id = '${clientid}' and update_date = '${date}';
    `;
    connection.query(sql, function (err, result) {
        if (err) {
            console.error(err);
            res.status(400).send({
                Error: err.code
            });
        } else {
            if (result.length == 0) {
                console.log("Error, no plan for the current client in the database");
                res.status(404).send({
                    Error: 404,
                    message: "Error, no such data in the database"
                });
            } else {
                let resArr = Array();
                for (let i = 0; i < result.length; i++) {
                    let task_id = result[i]['task_id']
                    let task_name = result[i]['task_name'];
                    let update_date = result[i]['update_date'];
                    let client_id = result[i]['client_id'];
                    let isDone = result[i]['isDone'];
                    let description = result[i]['description'];

                    resArr.push(
                        {
                            "task_id": task_id,
                            'task_name': task_name,
                            "update_date": update_date,
                            "client_id": client_id,
                            "isDone": isDone,
                            'description': description
                        });
                }
                console.log(resArr);
                res.status(200).json({ 'client_id': clientid, 'update_date': date, 'tasks': resArr });
            }
        }
    });
});

/**
 * @description - Save a new client
 * @returns {void}
 */
router.post("/saveInfo/:clientid", (req, res) => {
    // new table should be created to store daily workout logs: dailyLog
    var reqBody = req.body
    try {
        var sql = `INSERT INTO clients VALUES(
            '${req.params.clientid}', '${reqBody.client_name}', 
            '${reqBody.birthday}', '${reqBody.gender}',
            '${reqBody.height}', '${reqBody.weight}',
            '${reqBody.exercise_preference}')`;

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
        res.send({ "status": "FAILURE", "statusMessage": "Failed to post a new client. Error: ", e })
    }
})

/**
 * @description - Save assigned coach
 * @returns {void}
 */
router.post("/saveCoach/:clientid", (req, res) => {
    // new table should be created to store daily workout logs: dailyLog
    var reqBody = req.body
    try {
        var sql = `INSERT INTO client_match VALUES(
            '${req.params.clientid}', '${reqBody.coach_id}')`;

        connection.query(sql, function (err, result) {
            if (err) {
                console.error(err);
                res.status(400).json({
                    Error: err.code
                });
            } else {
                console.log(req.params.id);
                console.log(result);
                res.status(201).json({ 'Info': "Coach assigned successfully" });
            }
        });
    } catch (e) {
        res.send({ "status": "FAILURE", "statusMessage": "Failed to assign coach for the client. Error: ", e })
    }
})

/**
 * @description - Save assigned coach
 * @returns {void}
 */
router.post("/saveWorkout/:clientid", (req, res) => {
    // new table should be created to store daily workout logs: dailyLog
    var reqBody = req.body
    try {
        var sql = `INSERT INTO workout VALUES(
            '${req.params.clientid}', '${reqBody.update_date}', 
            '${reqBody.duration}', '${reqBody.oxygen_saturation}',
            '${reqBody.heart_rate}', '${reqBody.calories}',
            '${reqBody.notes}')`;

        connection.query(sql, function (err, result) {
            if (err) {
                console.error(err);
                res.status(400).json({
                    Error: err.code
                });
            } else {
                console.log(req.params.id);
                console.log(result);
                res.status(201).json({ 'Info': "Workout saved successfully" });
            }
        });
    } catch (e) {
        res.send({ "status": "FAILURE", "statusMessage": "Failed to save a new workout for the client. Error: ", e })
    }
})

/**
 * @description - Get the coach from client_id
 * @example - 
 * @returns {void}
 */
router.route('/getCoach/:clientid').get(function (req, res) {
    const clientid = req.params.clientid;
    var sql = `select * from client_match where client_id = '${clientid}';`;
    connection.query(sql, function (err, result) {
        if (err) {
            console.error(err);
            res.status(400).send({
                Error: err.code
            });
        } else {
            if (result.length == 0) {
                res.status(400).send({
                    "client_id": clientid,
                    "coach_id": "-1"
                });
            } else {
                let resArr = Array();
                let client_id = result[0]['client_id'];
                let coach_id = result[0]['coach_id'];
                let data =
                {
                    "client_id": client_id,
                    "coach_id": coach_id
                };
                console.log(resArr);
                res.status(200).json(data);
            }
        }
    });
});

/**
 * @description - change the coach from client_id
 * @example - 
 * @returns {void}
 */
router.route('/changeCoach/:clientid').put(function (req, res) {
    const clientid = req.params.clientid;
    var sql = `update client_match set coach_id = '${req.body.coach_id}' where client_id = '${clientid}';`
    connection.query(sql, function (err, result) {
        if (err) {
            console.error(err);
            res.status(400).send({
                Error: err.code
            });
        } else {
            res.status(201).json({ 'Info': "Change Coach successfully" });
        }
    });
});

/**
 * @description - update the plan tasks from client_id
 * @example - 
 * @returns {void}
 */
router.route('/updatePlan').put(function (req, res) {
    let tasks =  req.body.tasks;
    for (i = 0; i < tasks.length; i++) {
        let task =  tasks[i];
        var sql = `update planTasks set isDone = '${task.isDone}' where task_id = '${task.task_id}';`
        connection.query(sql, function (err, result) {
            if (err) {
                console.error(err);
                res.status(400).send({
                    Error: err.code
                });
            }
        })
    }

    res.status(201).json({ 'Info': "Update the tasks successfully" });
});

module.exports = router;