
var express = require("express");
const editJsonFile = require("edit-json-file");
var app = express();
app.get("/get", (req, res, next) => {
    let file = editJsonFile(`${__dirname}/score.json`);
    res.json(file.toObject());
});

app.post('/score/:score', (req, res) => {
    const user = req.params.username;
    const score = req.params.score;
    console.log("test");
    let file = editJsonFile(`${__dirname}/score.json`);
    if (file.get("one") < parseInt(score, 10))
        file.set(`one`, parseInt(score, 10));
    else if (file.get("two") < parseInt(score, 10))
        file.set(`two`, parseInt(score, 10));
    else if (file.get("three") < parseInt(score, 10))
        file.set(`three`, parseInt(score, 10));
    else if (file.get("four") < parseInt(score, 10))
        file.set(`four`, parseInt(score, 10));
    else if (file.get("five") < parseInt(score, 10))
        file.set(`five`, parseInt(score, 10));
    file.save();
    res.sendStatus(200);
});

app.listen(3000, () => {
    console.log("Server running on port 3000");
});