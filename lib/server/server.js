const express = require('express');
const app = express();
const hostname = '127.0.0.1';
const port = 3000;
const bodyParser = require('body-parser');
const mysql = require('mysql');
const fs = require('fs');

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));

const con = mysql.createConnection({
    host: "127.0.0.1",
    user: "root",
    password: "123456789",
    database: "db_project"
})

con.connect(err => {
    if(err) throw(err);
    else{
        console.log("MySQL connected");
    }
})

let tablename = "userInfo";

const queryDB = (sql) => {
    return new Promise((resolve,reject) => {
        // query method
        con.query(sql, (err,result, fields) => {
            if (err) reject(err);
            else
                resolve(result)
        })
    })
}

// create table and add data to database
app.post("/addDB",async (req,res) => {
    let sql = "CREATE TABLE IF NOT EXISTS userInfo (id INT AUTO_INCREMENT PRIMARY KEY, reg_date TIMESTAMP default CURRENT_TIMESTAMP, username VARCHAR(255),email VARCHAR(100),password VARCHAR(100),image VARCHAR(100),favIds VARCHAR(100))";
    let result = await queryDB(sql);
    sql = `INSERT INTO userInfo (username, email, password, image, favIds) VALUES ("${req.body.username}", "${req.body.email}", "${req.body.password}", "${req.body.image}", "")`;
    result = await queryDB(sql);
    console.log("New record created successfully");
    res.end("New record created successfully");
})

// update data
app.post("/updateDB",async (req,res) => {
    let sql = `UPDATE ${tablename} SET password = '${req.body.password}' WHERE username = '${req.body.username}'`;
    let result = await queryDB(sql);
    console.log(result);
    res.end("Record updated successfully");
})

// delete data
app.post("/deleteDB",async (req,res) => {
    console.log("delete");
    let sql = `DELETE FROM ${tablename} WHERE username = '${req.body.username}'`;
    let result = await queryDB(sql);
    console.log(result);
    res.end("Record deleted successfully");
})

// show data
app.get("/showDB", async (req,res) => {
    // let sql = `SELECT * FROM ${tablename}`;
    let sql = `SELECT id, username, password FROM ${tablename}`;
    let result = await queryDB(sql);
    result = Object.assign({},result);
    console.log(result);
    res.json(result);
})

// get UserData
app.post("/getUser", async (req,res) => {
  // let sql = `SELECT * FROM ${tablename}`;
  let sql = `SELECT id, username, email, password, image, favIds FROM ${tablename} WHERE username = '${req.body.username}'`;
  let result = await queryDB(sql);
  result = Object.assign({},result);
  console.log(result);
  res.json(result);
})

app.get("/getCatalogue", async (req,res) =>{
    let catjson = await readCatalogue();
    res.json(JSON.parse(catjson));
})

const readCatalogue = () => {
    return new Promise((resolve,reject) => {
      fs.readFile('catalogue.json','utf8',(err,data) => {
        if(err){
          reject(err);
        }
        else{
          resolve(data);
        }
      });
    })
  }

app.get("/getProduct", async (req,res) =>{
    let catjson = await readProduct();
    res.json(JSON.parse(catjson));
})

const readProduct = () => {
    return new Promise((resolve,reject) => {
      fs.readFile('product.json','utf8',(err,data) => {
        if(err){
          reject(err);
        }
        else{
          resolve(data);
        }
      });
    })
  }
 
 app.listen(port, hostname, () => {
    console.log(`Server running at   http://${hostname}:${port}/`);
});