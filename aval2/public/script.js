// Função para realizar a consulta com base no tipo selecionado
function realizarConsulta() {
    const tipoConsulta = document.getElementById("consultaTipo").value;
    const filtroEleicao = document.getElementById("filtroEleicao").value;
    const candidateName = document.getElementById("nomeCandidato").value
    const filtro = tipoConsulta === "candidato" ? candidateName : filtroEleicao

    // Construir a URL da requisição
    const url = `http://localhost:3000/consulta?type=${tipoConsulta}&filtro=${filtro}`;

    // Enviar requisição utilizando Fetch API
    fetch(url)
        .then(response => {
            // Verificar se a resposta foi bem-sucedida
            if (!response.ok) {
                throw new Error(`Erro na solicitação AJAX: ${response.status} ${response.statusText}`);
            }
            return response.text();
        })
        .then(data => {
            // Atualizar o conteúdo da div 'resultadoConsulta' com os dados recebidos
            document.getElementById("resultadoConsulta").innerHTML = data;
        })
        .catch(error => {
            // Lidar com erros capturados durante a requisição
            console.error(error);
        });
}

// Função para alternar a exibição dos campos com base no tipo de consulta selecionado
function toggleFields() {
    const consultaTipo = document.getElementById("consultaTipo").value;
    const nomeCandidatoContainer = document.getElementById("nomeCandidatoContainer");
    const filtroEleicaoContainer = document.getElementById("filtroEleicaoContainer");
    const filtroEleicaoSelect = document.getElementById("filtroEleicao");
    
    if (consultaTipo === "candidato") {
        // Exibir campo de nome do candidato e esconder campo de filtro
        nomeCandidatoContainer.style.display = "block";
        filtroEleicaoContainer.style.display = "none";
    } else if (consultaTipo === "cargo") {
        // Realizar requisição para obter opções de cargo
        fetch("http://localhost:3000/cargo")
        .then(response => {
            // Verificar se a resposta foi bem-sucedida
            if (!response.ok) {
                throw new Error(`Erro na solicitação AJAX: ${response.status} ${response.statusText}`);
            }
            return response.text();
        })
        .then(data => {
            // Atualizar o conteúdo HTML do select 'filtroEleicaoSelect' com as opções de cargo
            filtroEleicaoSelect.innerHTML = data;
        })
        .catch(error => {
            // Lidar com erros capturados durante a requisição
            console.error(error);
        });

        // Exibir campo de filtro e esconder campo de nome do candidato
        nomeCandidatoContainer.style.display = "none";
        filtroEleicaoContainer.style.display = "block";
    } else {
        // Esconder ambos os campos se não for 'candidato' nem 'cargo'
        nomeCandidatoContainer.style.display = "none";
        filtroEleicaoContainer.style.display = "none";
    }
}
