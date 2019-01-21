//Initiallising node modules
var express = require("express");
var bodyParser = require("body-parser");
var sql = require("mssql");
var app = express();

// Body Parser Middleware
app.use(bodyParser.json());

//CORS Middleware


//SELECT CPF, COUNT(CPF) AS TEMP FROM CLIENTE GROUP BY CPF HAVING (COUNT(CPF)>1) ORDER BY TEMP

// select CLIENTE.INSCRICAO, CLIENTE.NOME, CLIENTE.COMPLEMENTO, CLIENTE.CDG_CATEGORIA, 
// CLIENTE.CDG_LOGRA, CLIENTE.CDG_CIDADE, 
// LOGRADOURO.BAIRRO, LOGRADOURO.NOME
// from CLIENTE, LOGRADOURO where INSCRICAO = 9875 and CLIENTE.CDG_LOGRA = LOGRADOURO.CDG_LOGRA

app.use(function (req, res, next) {
    //Enabling CORS 
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Methods", "GET,POST,PUT");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, contentType,Content-Type, Accept, Authorization");
    next();
});

//Setting up server
var server = app.listen(process.env.PORT || 3000, function () {
    var port = server.address().port;
    console.log("App now running on port", port);
});

//Initiallising connection string
var dbConfig = {
    user: "sa",
    password: "@dmin123",
    server: "localhost",
    database: "DBSICOS_Matheus",
    options: {
        encrypt: true
    }
};



//Function to connect to database and execute query
var executeQuery = function (res, query, login) {
    sql.connect(dbConfig, function (err) {
        if (err) {
            console.log("Error while connecting database :- " + err);
            res.send(err);
        }
        else {
            // create Request object
            var request = new sql.Request();
            // query to the database
            request.query(query, function (err, rs) {
                if (err) {
                    console.log("Error while querying database :- " + err);
                    res.send(err);
                }
                else {
                    res.send(rs);
                }
            });
        }
    });
}





//GET API
//VERIFICA SE A MATRICULA EXISTE
// app.get("/api/cliente/matricula/:matricula", function (req, res) {
//     var query = "select INSCRICAO from CLIENTE where INSCRICAO = " + req.params.matricula;
//     executeQuery(res, query, 'inscricao');
// });
//VERIFICA SE O CPF EXISTE, select matricula
// app.get("/api/cliente/cpf/:cpf", function (req, res) {
//     var query = "select INSCRICAO from CLIENTE where CPF = '" + String(req.params.cpf) + "'";
//     executeQuery(res, query, 'matricula');
// });

//VERIFICA SE O CPF EXISTE
//inscrição, NOME, NUMERO DA PORTA, CATEGORIA, KEY_LOGRADOURO, CIDADE
app.get("/api/cliente/cpf/dados/:cpf", function (req, res) {
    var query = "select INSCRICAO, NOME, COMPLEMENTO, CDG_CATEGORIA, CDG_LOGRA, CDG_CIDADE from CLIENTE where CPF = '" + String(req.params.cpf) + "'";
    executeQuery(res, query, 'matricula');
});


//vERIFICA SE A MATRICULA
//INCRICAO NOME, NUMERO DA PORTA, CATEGORIA, KEY_LOGRADOURO, CIDADE
app.get("/api/cliente/matricula/dados/:matricula", function (req, res) {
    var query = "select INSCRICAO, NOME, COMPLEMENTO, CDG_CATEGORIA, CDG_LOGRA, CDG_CIDADE from CLIENTE where INSCRICAO = " + req.params.matricula;
    executeQuery(res, query, 'inscricao');
});

//SOLICITA DADOS DO DEBITO
//MES_REFERENCIA, VENCIMENTO, VALOR DA FATURA, VOLUME FATURA, origem
//FALTA O STATUS
app.get("/api/debitos/dados/:matricula", function (req, res) {
    var query = "select REF_FATUR, DATA_VENCIMENTO, VALOR_TOTAL, VOL_FATURADO, ORIGEM from DEBITO where INSCRICAO = " + req.params.matricula + " order by REF_FATUR desc";
    executeQuery(res, query, 'inscricao');
});


//SOLICITA DADOS DO ENDEREÇO
app.get("/api/logradouro/dados/:matricula", function (req, res) {
    var query = `select CLIENTE.INSCRICAO, CLIENTE.COMPLEMENTO, CLIENTE.CDG_CATEGORIA, CLIENTE.CDG_LOGRA, CLIENTE.CDG_CIDADE, 
                    LOGRADOURO.BAIRRO, LOGRADOURO.NOME
                    from CLIENTE, LOGRADOURO where INSCRICAO = ${req.params.matricula} 
                    and CLIENTE.CDG_LOGRA = LOGRADOURO.CDG_LOGRA` 
    executeQuery(res, query, 'matricula');
});

//SOLICITA DADOS DO pagamento
app.get("/api/pagamentos/dados/:matricula", function (req, res) {
    var query = `select REF_FATUR, INSCRICAO
                    from PAGAMENTO 
                    where INSCRICAO = ${req.params.matricula} 
                    order by REF_FATUR desc`
    executeQuery(res, query, 'matricula');
});
