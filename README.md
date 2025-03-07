# McDonald's Authentication API

Esta API foi criada para gerenciar o processo de autenticação de usuários para a plataforma McDonald's. Ela permite o cadastro de novos usuários, login via email e senha, e a visualização do perfil do usuário autenticado.

## Funcionalidades

- **Cadastro de usuários**: Permite que novos usuários se cadastrem, fornecendo um nome de usuário, email e senha.
- **Login de usuários**: Permite que os usuários se autentiquem usando seu email e senha e recebam um token JWT para autenticação em futuras requisições.
- **Perfil de usuário**: Após o login, os usuários podem acessar seu perfil, que contém informações como nome de usuário e email.

## Tecnologias Utilizadas

- **Node.js**: Ambiente de execução JavaScript do lado do servidor.
- **Express**: Framework para construir APIs.
- **Prisma**: ORM (Object-Relational Mapper) para interagir com o banco de dados.
- **JWT (JSON Web Tokens)**: Para autenticação de usuários.
- **Bcrypt.js**: Para criptografar senhas de forma segura.
- **Swagger/OpenAPI**: Para documentar a API de maneira interativa.

## Como Rodar o Projeto Localmente

### Requisitos

- **Node.js** (v14 ou superior)
- **Banco de dados Prisma** (PostgreSQL, MySQL ou outro banco de dados configurado no `prisma/schema.prisma`)

### Passos

1. **Clone o repositório**:
   ```bash
   git clone https://github.com/seu-usuario/mc-donalds-authentication.git
   cd mc-donalds-authentication

2. **Instale as dependências**:
    ```bash
    npm install
3. **Configure o banco de dados**:
- Crie o arquivo .env na raiz do projeto e adicione as variáveis de ambiente necessárias, como:
    ```bash
    DATABASE_URL=postgresql://usuario:senha@localhost:5432/mcdonalds_db?schema=public
    SECRET_KEY=sua-chave-secreta
    ```
    Certifique-se de ter um banco de dados configurado e a URL de conexão está correta.
4. **Realize as migrações do Prisma (se necessário):**
    ```bash
    npx prisma migrate dev --name init
5. **Inicie o servidor:**
    ```bash
    npm run dev
    ```
    O servidor estará rodando em http://localhost:3000.
6. **Acesse a documentação da API:**
    - Acesse a documentação interativa da API via Swagger em: http://localhost:3000/docs

## Endpoints

### 1. POST /users
Registra um novo usuário.

**Corpo da requisição**
```json
{
  "username": "johndoe",
  "email": "johndoe@example.com",
  "password": "securepassword123"
}
```
**Respostas:**
- 201: Usuário criado com sucesso.
- 409: Usuário já existe.
- 500: Erro interno do servidor.

### 2. POST /users/login
Realiza o login de um usuário e retorna um token JWT.

**Corpo da requisição**
```json
{
  "email": "johndoe@example.com",
  "password": "securepassword123"
}
```
**Respostas:**
- 200: Login bem-sucedido, retorna o token JWT.
- 401: Credenciais inválidas.
- 500: Erro interno do servidor.

### 3. GET /users
Obtém as informações do perfil do usuário autenticado.
**Headers:**
- Authorization: Bearer <JWT_TOKEN>

**Respostas:**
- 200: Retorna as informações do usuário autenticado.
- 401: Não autorizado (token ausente ou inválido).
- 500: Erro interno do servidor.