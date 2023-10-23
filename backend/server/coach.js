const router = require('express').Router();
var { connection } = require("./dbInfo");
mysql = require('mysql2');

/**
 * @description - Get the client details using clientId from clients DB
 * @example - 
 * @returns {void}
 */
router.route('/getInfo/:coach_id').get(function (req, res) {
    const coach_id = req.params.coach_id;
    var sql = `select * from coaches where coach_id = '${coach_id}';`;
    connection.query(sql, function (err, result) {
        if (err) {
            console.error(err);
            res.status(400).send({
                Error: err.code
            });
        } else {
            if (result.length == 0) {
                res.status(404).send({
                    Error: 404,
                    message: "Error, no such data in the database"
                });
            } else {
                let resArr = Array();
                let coach_name = result[0]['coach_name'];
                let birthday = result[0]['birthday'];
                let gender = result[0]['gender'];
                let height = result[0]['height'];
                let weight = result[0]['weight'];
                let coaching_experience = result[0]['coaching_experience'];
                let specialization = result[0]['specialization'];

                let data =
                {
                    'coach_name': coach_name,
                    "birthday": birthday,
                    "gender": gender,
                    "height": height,
                    'weight': weight,
                    "coaching_experience": coaching_experience,
                    'specialization': specialization,
                };
                console.log(resArr);
                res.status(200).json(data);
            }
        }
    });
});


/**
 * @description - save coach profile
 * @returns {void}
 */
router.post("/saveInfo/:coach_id", (req, res) => {
    // new table should be created to store daily workout logs: dailyLog
    var reqBody = req.body
    try {
        var sql = `INSERT INTO coaches VALUES(
            '${req.params.coach_id}', '${reqBody.coach_name}', 
            '${reqBody.birthday}', '${reqBody.gender}',
            '${reqBody.height}', '${reqBody.weight}',
            '${reqBody.coaching_experience}', '${reqBody.specialization}')`;

        connection.query(sql, function (err, result) {
            if (err) {
                console.error(err);
                res.status(400).json({
                    Error: err.code
                });
            } else {
                console.log(req.params.id);
                console.log(result);
                res.status(201).json({ 'Info': "Coach Created Successfully" });
            }
        });
    } catch (e) {
        res.send({ "status": "FAILURE", "statusMessage": "Failed to post a new coach. Error: ", e })
    }
})


/**
 * @description - Get the client lists for one coach
 * @example - 
 * @returns {void}
 */
router.route('/getClients/:coach_id').get(function (req, res) {
    const coach_id = req.params.coach_id;
    var sql =
        `
    select * from clients where client_id in 
    (select 
        client_id from client_match 
        where coach_id = '${coach_id}');
    `;
    connection.query(sql, function (err, result) {
        if (err) {
            console.error(err);
            res.status(400).send({
                Error: err.code
            });
        } else {
            if (result.length == 0) {
                console.log("Error, no clients for the current coach in the database");
                res.status(404).send({
                    Error: 404,
                    message: "Error, no such data in the database"
                });
            } else {
                let resArr = Array();
                for (let i = 0; i < result.length; i++) {
                    let client_id = result[i]['client_id']
                    let client_name = result[i]['client_name'];

                    resArr.push(
                        {
                            "client_id": client_id,
                            'client_name': client_name
                        });
                }
                console.log(resArr);
                res.status(200).json({ 'coach_id': coach_id, 'clientList': resArr });
            }
        }
    });
});

/**
 * @description - Get the client workout history for one coach
 * @example - 
 * @returns {void}
 */
router.route('/getHistory/:client_id').get(function (req, res) {
    const client_id = req.params.client_id;
    var sql =
        `
    select update_date from planTasks where client_id = '${client_id}' group by update_date;
    `;
    connection.query(sql, function (err, result) {
        if (err) {
            console.error(err);
            res.status(400).send({
                Error: err.code
            });
        } else {
            if (result.length == 0) {
                console.log("Error, no clients for the current coach in the database");
                res.status(404).send({
                    Error: 404,
                    message: "Error, no such data in the database"
                });
            } else {
                let resArr = Array();
                for (let i = 0; i < result.length; i++) {
                    let update_date = result[i]['update_date']
                    resArr.push(
                        {
                            "update_date": update_date
                        });
                }
                console.log(resArr);
                res.status(200).json({ 'client_id': client_id, 'exerciseList': resArr });
            }
        }
    });
});


/**
 * @description - Save a new plan
 * @returns {void}
 */
router.post("/savePlan/:client_id", (req, res) => {
    // new table should be created to store daily workout logs: dailyLog
    var reqBody = req.body;
    try {
        let client_id = req.params.client_id;
        let update_date = reqBody.update_date;
        let task_lists = reqBody.tasks;
        for (let i = 0; i < task_lists.length; i++) {
            var task = task_lists[i];
            var sql = `INSERT INTO planTasks VALUES(
                '${task.task_id}', '${task.task_name}', 
                '${update_date}', '${client_id}',
                '${task.isDone}', '${task.description}');`;
            connection.query(sql, function (err, result) {
                if (err) {
                    console.error(err);
                    res.status(400).json({
                        Error: err.code
                    });
                }
            });
        }
        res.status(201).json({ 'Info': "Plan Created Successfully" });
    } catch (e) {
        res.send({ "status": "FAILURE", "statusMessage": "Failed to post a new plan. Error: ", e })
    }
})

/**
 * @description - Get the client workout with one date for one coach
 * @example - 
 * @returns {void}
 */
router.route('/getWorkout/:client_id/:update_date').get(function (req, res) {
    const client_id = req.params.client_id;
    const update_date = req.params.update_date;
    var sql =
        `
    select * from workout where client_id = '${client_id}' and update_date = '${update_date}';
    `;
    connection.query(sql, function (err, result) {
        if (err) {
            console.error(err);
            res.status(400).send({
                Error: err.code
            });
        } else {
            if (result.length == 0) {
                console.log(`Error, no workout data for the current client and date ${update_date} in the database`);
                res.status(404).send({
                    Error: 404,
                    message: "Error, no such data in the database"
                });
            } else {
                let resArr = Array();
                let duration = result[0]['duration'];
                let oxygen_saturation = result[0]['oxygen_saturation'];
                let heart_rate = result[0]['heart_rate'];
                let calories = result[0]['calories'];
                let notes = result[0]['notes'];
                data = 
                    {
                        "client_id": client_id,
                        "update_date": update_date,
                        "duration": duration,
                        "oxygen_saturation": oxygen_saturation,
                        "heart_rate": heart_rate,                      
                        "calories": calories,
                        "notes": notes
                    };

                console.log(data);
                res.status(200).json(data);
            }
        }
    });
});

module.exports = router;