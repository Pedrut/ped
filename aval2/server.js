const express = require('express');
const sqlite3 = require('sqlite3');
const path = require('path');
const cors = require('cors')
const app = express();

app.use(cors())

const PORT = 3000;

// Conectar ao banco de dados SQLite3
const db = new sqlite3.Database(path.join(__dirname, './eleicoes2022pi.db'));

// Servir arquivos estáticos da pasta 'public'
app.use(express.static('public'));

// Rota para realizar consultas com base no tipo de consulta e filtro
app.get('/consulta', (req, res) => {
    const tipoConsulta = req.query.type;
    const filtroEleicao = req.query.filtro;

    // Construir e executar a consulta SQL com base no tipo e filtro
    let sql;
    let params = [];

    switch (tipoConsulta) {
        case "candidato":
            sql = "SELECT * FROM candidato WHERE nome LIKE ?";
            params.push( `%${filtroEleicao.toUpperCase()}%`);
            break;

        case "cargo":
            sql = `SELECT candidato.id, candidato.nome, candidato.status, SUM(votacao.votos) AS total_votos
            FROM votacao
            LEFT JOIN candidato ON votacao.candidato = candidato.id
            WHERE candidato.cargo = ?
            GROUP BY candidato.id, candidato.nome, candidato.status;`;
            params.push(filtroEleicao);
            break;

        case 'municipio':
            sql = "SELECT * FROM resultados WHERE tipo = 'eleito' AND municipio = ?";
            params.push(filtroEleicao);
            break;

        case "resultadoGeral":
            if (filtroEleicao === 'eleitos') {
                sql = "SELECT * FROM resultados WHERE tipo = 'eleito'";
            } else if (filtroEleicao === 'naoEleitos') {
                sql = "SELECT * FROM resultados WHERE tipo = 'naoEleito'";
            } else {
                sql = "SELECT * FROM resultados";
            }
            break;

        default:
            res.status(400).send('Tipo de consulta inválido.');
            return;
    }

    console.log(sql, params);

    // Executar a consulta no banco de dados
    db.all(sql, params, (err, rows) => {
        if (err) {
            res.status(500).send(err);
            return;
        }

        // Gerar o resultado em formato HTML baseado no tipo de consulta
        let htmlResultado = '<table border="2"><tr><th>ID</th><th>Nome</th><th>Cargo</th><th>Tipo</th><th>Status</th></tr>';
        rows.forEach(row => {
            htmlResultado += `<tr><td>${row.id}</td><td>${row.nome}</td><td>${row.cargo}</td><td>${row.tipo}</td><td>${row.status}</td></tr>`;
        });
        htmlResultado += '</table>';

        // Enviar a resposta com o resultado em HTML
        res.send(htmlGenerator(tipoConsulta, rows));
    });
});

// Função para gerar o HTML com base no tipo de consulta
const htmlGenerator = (tipoConsulta, data) => {
    if (tipoConsulta === "cargo") {
        let htmlResultado = '<table border="2"><tr><th>ID</th><th>Nome</th><th>Total de Votos</th><th>Status</th></tr>';
        data.forEach(row => {
            htmlResultado += `<tr><td>${row.id}</td><td>${row.nome}</td><td>${row.total_votos}</td><td>${row.status}</td></tr>`;
        });
        htmlResultado += '</table>';
        return htmlResultado
    }
    
    let htmlResultado = '<table border="2"><tr><th>ID</th><th>Nome</th><th>Cargo</th><th>Tipo</th><th>Status</th></tr>';
    data.forEach(row => {
        htmlResultado += `<tr><td>${row.id}</td><td>${row.nome}</td><td>${row.cargo}</td><td>${row.tipo}</td><td>${row.status}</td></tr>`;
    });
    htmlResultado += '</table>';
    return htmlResultado
}

// Rota para obter opções de cargo
app.get('/cargo', (req, res) => {
    const sql = "SELECT * FROM cargo ORDER BY id DESC";
  
    // Executar a consulta no banco de dados
    db.all(sql, (err, rows) => {
        if (err) {
            res.status(500).send(err);
            return;
        }

        let htmlResultado = '';
        rows.forEach(row => {
            htmlResultado += `<option value=${row.id}>${row.nome}</option>`
        });
     
        // Enviar a resposta com as opções de cargo
        res.send(htmlResultado);
    });
});

// Iniciar o servidor
app.listen(PORT, () => {
    console.log(`Servidor está rodando em http://localhost:${PORT}`);
});
