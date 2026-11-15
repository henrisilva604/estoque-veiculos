Sistema Automotivo — Gestão de Estoque de Veículos

API RESTful e interface web integrada desenvolvidas para o gerenciamento eficiente de estoque de veículos de uma concessionária. O projeto aplica conceitos de Programação Orientada a Objetos (POO), arquitetura em camadas, persistência relacional e consultas dinâmicas.

Autor: Henri

Curso: Análise e Desenvolvimento de Sistemas — UniFECAF

Tecnologias Utilizadas

Linguagem: Java 21

Framework Backend: Spring Boot 4.1.2 (Spring Web, Spring Data JPA, Bean Validation)

Banco de Dados: MySQL 8

Frontend: HTML5, CSS3 e JavaScript puro (servido de forma integrada pela aplicação)

Gerenciador de Dependências: Maven

Arquitetura e Funcionalidades

O sistema segue a arquitetura em camadas (Controller, Service, Repository e Model) utilizando DTOs (Data Transfer Objects) para tráfego seguro de dados e tratamento centralizado de exceções HTTP (400 Bad Request, 404 Not Found, 409 Conflict).

Principais Funcionalidades:

Gestão de Marcas e Modelos: Cadastro relacional impedindo a exclusão de registros em uso por integridade referencial.

CRUD Completo de Veículos: Cadastro, consulta detalhada, atualização parcial (PATCH) e remoção (DELETE).

Filtros Dinâmicos e Paginação: Consultas combinadas por marca, modelo, ano mínimo/máximo, preço mínimo/máximo e status (DISPONIVEL, RESERVADO, VENDIDO, DESCONTINUADO) utilizando JpaSpecificationExecutor.

Regras de Negócio: Validação que impede a redução da quilometragem atual e bloqueia o retorno ao estoque de veículos já marcados como vendidos.

Estrutura de Pastas do Repositório

estoque-veiculos/
├── banco/
│   └── schema.sql            # Script DDL para criação do banco, tabelas e índices
├── postman/
│   └── ...                   # Coleções de requisições para testes da API
├── src/
│   ├── main/
│   │   ├── java/com/concessionaria/estoqueveiculos/
│   │   │   ├── controller/   # Endpoints REST
│   │   │   ├── dto/          # Objetos de transferência de dados (Request/Response/Filtro)
│   │   │   ├── exception/    # Exceções customizadas e Handler global
│   │   │   ├── model/        # Entidades JPA (EntidadeBase, Marca, Modelo, Veiculo)
│   │   │   ├── repository/   # Interfaces Spring Data JPA e Specifications
│   │   │   └── service/      # Regras de negócio e transações
│   │   └── resources/
│   │       ├── static/       # Arquivos do Frontend (HTML/CSS/JS)
│   │       └── application.properties
├── pom.xml
└── README.md



Pré-requisitos e Como Executar

1. Pré-requisitos

JDK 21 instalado e configurado no PATH.

MySQL 8 em execução na porta padrão 3306.

Maven (ou utilização do wrapper ./mvnw incluso no projeto).

2. Configuração do Banco de Dados

Execute o script localizado em banco/schema.sql no seu cliente MySQL para criar o banco de dados estoque_veiculos e suas respectivas tabelas:

SOURCE banco/schema.sql;



3. Variável de Ambiente

Por motivos de segurança, a senha do banco de dados não fica exposta no arquivo application.properties. Antes de iniciar a aplicação, defina a variável de ambiente DB_PASSWORD no seu terminal ou IDE:

Linux / macOS:

export DB_PASSWORD=sua_senha_do_mysql



Windows (PowerShell):

$env:DB_PASSWORD="sua_senha_do_mysql"



4. Executando a Aplicação

Na raiz do projeto, execute o comando abaixo via terminal:

./mvnw spring-boot:run



Após a inicialização, acesse:

Interface Web: http://localhost:8080

Base URL da API: http://localhost:8080/veiculos

Endpoints da API REST

Veículos (/veiculos)

Método

Endpoint

Descrição

Status de Sucesso

POST

/veiculos

Cadastra um novo veículo no estoque

201 Created

GET

/veiculos

Lista veículos com filtros combináveis, paginação e ordenação

200 OK

GET

/veiculos/{id}

Busca os detalhes de um veículo específico pelo ID

200 OK

PATCH

/veiculos/{id}

Atualiza parcialmente preço, quilometragem e/ou status

200 OK

DELETE

/veiculos/{id}

Remove um veículo do estoque

204 No Content

Exemplo de parâmetros de filtro (GET /veiculos):

GET /veiculos?marca=Toyota&status=DISPONIVEL&precoMax=150000&anoMin=2020



Marcas e Modelos (/marcas e /modelos)

Método

Endpoint

Descrição

GET, POST, PUT, DELETE

/marcas

Gerenciamento completo de fabricantes

GET, POST, PUT, DELETE

/modelos

Gerenciamento completo de modelos vinculados a uma marca
