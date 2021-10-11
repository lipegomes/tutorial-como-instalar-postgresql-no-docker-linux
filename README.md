# **Tutorial de configuração para desenvolver com PostgreSQL no Linux utilizando docker**

Este tutorial foi produzido por mim com intuito de ajudar as pessoas que estão iniciando no mundo de desenvolvimento a fim de aprender a configurar o banco de dados PostgreSQL em um container docker em um ambiente de desenvolvimento Linux.

## **1 - Instalação e Configuração do PostgreSQL no Linux**

Para instalação do docker em sua distribuição linux consulte a documentação oficial no link abaixo:

https://docs.docker.com/engine/install/

Use o comando abaixo para iniciar o docker após instalação:

```
sudo systemctl start docker
```

Use o comando abaixo para fazer um stop(parar) o funcionamento do docker se necessário:

```
sudo systemctl stop docker
```

**1.1 - Criar container docker do PostgreSQL com a versão 14.0:**

No link abaixo é possível obter informações sobre a imagem oficial do PostgreSQL no Docker Hub:

https://hub.docker.com/_/postgres

Instale o PostgreSQL na versão 14.0 com o comando abaixo:

```
docker run --name postgres -e POSTGRES_PASSWORD=123456 -d -p 5432:5432 postgres:14.0
```

**1.2 - Verificar se o PostgreSQL foi instalado no docker:**

```
docker ps -a
```

![2021-10-10_11-01-41.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_11-01-41.png)

**1.3 - Executar o container com o PostgreSQL:**

Ao utilizar o comando docker ps -a é possível obter o CONTAINER ID, copie e cole no comando abaixo seu ID:

```
docker start <CONTAINER ID>
```

Ao colar o ID do seu container docker o comando ficará assim:

```
docker start 2b057c2cf612
```

**1.4 - Parar o funcionamento do container:**

```
docker stop postgres
```

ou

```
docker stop 2b057c2cf612
```

**1.5 - Iniciar o container:**

```
docker start postgres
```

ou

```
docker start 2b057c2cf612
```

## **2 - Acessar o PostgreSQL via terminal:**

**2.1 - Acessar o bash do PostgreSQL :**

```
docker exec -it postgres bash
```

![2021-10-10_11-09-35.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_11-09-35.png)

**2.3 Verificar o diretorio é exatamente /:**

```
pwd
```

![2021-10-10_11-10-09.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_11-10-09.png)

**2.4 - Acessar o postgres como root:**

```
psql -U postgres
```

![2021-10-10_11-11-58.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_11-11-58.png)

**2.5 - Listar usuários:**

```
\du
```

Observe na imagem abaixo que o usuário postgres já tem atributos de superusuário:

![2021-10-10_11-13-17.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_11-13-17.png)

OBS: Caso queira sair do postgres, digite o comando abaixo até voltar para a tela inicial do seu terminal no seu usuário local da máquina, conforme imagem abaixo:

```
exit
```

Se ocorrer do comando exit não funcionar, digite o comando abaixo:

```
\q
```

**2.6 - Iniciar o PostgreSQL na porta 5432:**

Sempre que for utilizar o PostgreSQL será necessário utilizar o comando abaixo para iniciar o PostgreSQL na porta 5432 utilizando o usuário root postgres:

```
docker exec -it 2b057c2cf612 psql -h localhost -p 5432 -U postgres
```

## **3 - Criar um banco de dados utilizando o PostgreSQL via terminal:**

**3.1 - Criar um banco de dados:**

Há duas formas de se criar um banco de dados utilizando o PostgreSQL via terminal:

1 - Já logado com o usuário postgres, seguindo todo item 2 descrito acima, digite o comando abaixo:

```
CREATE DATABASE universidade;
```

![2021-10-10_11-31-47.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_11-31-47.png)

Caso queria deletar o banco de dados criado por algum motivo, digite o comando abaixo sabiamente:

```
DROP DATABASE IF EXISTS universidade
```

![2021-10-10_11-13-17.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_11-13-17.png)

2 - Sem estar logado no usuário postgres, mas já com o docker e o container funcionado conforme item 1 descrito acima, digite o comando abaixo:

```
docker exec -it 2b057c2cf612 psql -U postgres -c "CREATE DATABASE universidade"
```

![2021-10-10_11-28-27.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_11-28-27.png)

Caso queria deletar o banco de dados criado por algum motivo, digite o comando abaixo sabiamente:

```
docker exec -it 2b057c2cf612 psql -U postgres -c "DROP DATABASE IF EXISTS universidade"
```

**3.2 - Listar os bancos de dados existentes:**

Ao utilizar o comando abaixo para listar os banco de dados existentes, ficará visivel o banco de dados criado no item 3.1, conforme imagem abaixo:

```
\l
```

![2021-10-10_11-39-11.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_11-39-11.png)

**3.3 - Conexao com banco de dados criado:**

Para criar as tabelas será necessário se conectar ao banco de dados criado no item 3.1, logo utilize o comando abaixo:

```
\c universidade
```

Observe na imagem abaixo que estamos conectado ao banco de dados universidade utilizando o usuário postgres:

![2021-10-10_11-48-44.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_11-48-44.png)

**3.4 - Criar tabelas:**

Utilizar as queries abaixo para criar as tabelas dentro do banco de dados universidade:

```
CREATE TABLE professores(
    matricula VARCHAR(10) NOT NULL PRIMARY KEY,
    cpf VARCHAR(14) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL
);
```

```
CREATE TABLE disciplinas(
    codigo VARCHAR(20) NOT NULL PRIMARY KEY,
    titulo VARCHAR(1000) NOT NULL,
    professor_matricula VARCHAR(10) NOT NULL,
    CONSTRAINT fk_professor_disciplinas FOREIGN KEY(professor_matricula) REFERENCES professores
);
```

Observe na imagem abaixo que as tabelas foram criadas:

![2021-10-10_12-05-16.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_12-05-16.png)

**3.5 - Listar as tabelas criadas:**

Utilizar o comando abaixo para listar as relações presentes no banco de dados universidade:

```
\dt
```

Observe conforme imagem abaixo que as tabelas professores e disciplinas foram criadas:


**3.6 - Listar os parâmetros das tabelas criadas:**

```
\d professores
```

Observe na imagem abaixo que todos os parâmetros utilizados na query de criacao da table estão presentes:

![2021-10-10_12-06-54.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_12-06-54.png)

```
\d professores
```

Observe na imagem abaixo que todos os parâmetros utilizados na query de criação da tabela estão presentes:

![2021-10-10_12-10-17.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_12-10-17.png)

```
\d disciplinas
```

Observe na imagem abaixo que todos os parâmetros utilizados na query de criação da tabela estão presentes:

![2021-10-10_12-10-56.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_12-10-56.png)

**3.7 - Inserir dados na tabela professor:**

Utilizar as queries abaixo para inserir dados na tabela professores dentro do banco de dados universidade:

```
INSERT INTO professores (matricula, cpf, nome, sobrenome) VALUES('0001-1', '000.000.000-01', 'Mark', 'Twin');
```

```
INSERT INTO professores (matricula, cpf, nome, sobrenome) VALUES('0358-2', '000.000.000-76', 'Letícia', 'Bragança');
```

```
INSERT INTO professores (matricula, cpf, nome, sobrenome) VALUES('1765-4', '000.000.000-98', 'Paulo', 'Pereira');
```

```
INSERT INTO professores (matricula, cpf, nome, sobrenome) VALUES('0023-1', '000.000.000-18', 'Helena', 'Avelino');
```

**3.8 - Verificar a tabela professores:**

O comando abaixo seleciona todos(*) os items presentes na tabela professores e os lista:

```
SELECT * FROM professores;
```

Observe conforme imagem abaixo que os dados iseridos no item 3.7 se encontram presentes na table professores:

![2021-10-10_12-24-28.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_12-24-28.png)

**3.9 - Inserir dados na tabela disciplinas:**

Utilizar as queries abaixo para inserir dados na tabela disciplinas dentro do banco de dados universidade:

```
INSERT INTO disciplinas (codigo, titulo, professor_matricula) VALUES('ED123', 'Estrutura de dados', '0001-1');
```

```
INSERT INTO disciplinas (codigo, titulo, professor_matricula) VALUES('BM034', 'Bioquímica de Macromoléculas', '0358-2');
```

```
INSERT INTO disciplinas (codigo, titulo, professor_matricula) VALUES('MQ198', 'Mecânica Quantica', '1765-4');
```

```
INSERT INTO disciplinas (codigo, titulo, professor_matricula) VALUES('FS572', 'Física dos Sólidos', '0023-1');
```

**3.10 - Verificar a tabela disciplinas:**

O comando abaixo seleciona todos(*) os items presentes na tabela professores e os lista:

```
SELECT * FROM disciplinas;
```

Observe conforme imagem abaixo que os dados iseridos no item 3.9 se encontram presentes na table disciplinas:

![2021-10-10_12-39-53.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_12-39-53.png)

## **4 - Conectar e acessar o banco de dados pelo PgAdmin4:**

Para download do PgAdmin4 acesse o link abaixo, lembrando que deve instalar exatamente para o sistema de pacotes da sua distribuição linux:

https://www.pgadmin.org/download/

**4.1 - Configuração do PgAdmin4:**

Ao iniciar o PgAdmin4 ele irá solicitar a sua senha root do PostgreSQL, digite a senha utilizada na criação do container docker do  PostgreSQL no item 1.1 em seguida clique em OK:

Senha: 123456

![2021-10-10_12-52-09.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_12-52-09.png)

Clique em cima de Servers com botão direito do mouse e entre em Server:

![2021-10-10_12-39-53.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_12-39-53.png)

Já em Server, no campo Name digite o nome Local para nome do server:

![2021-10-10_12-52-58.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_12-52-58.png)

Em seguida entre na aba Connection e no campo Host name/address digite localhost. Em Password digite 123456 pois essa será a senha para acessar o banco de dados no PgAdmin4, em seguida clique em Save:

![2021-10-10_12-53-08.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_12-53-08.png)

Pronto, o PgAdmin4 está configurado e com acesso aos bancos de dados, conforme imagem abaixo, clique em no server Local para expandir, depois clique em Databases e em seguida clique sobre o banco de dados universidade para para o iniciar.

![2021-10-10_12-53-33.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_12-53-33.png)

Observe na imagem abaixo que as tabelas criadas no item 3.4 se encontram dentro de Schemas em Tables.

![2021-10-10_13-17-56.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_13-17-56.png)

Clique com botão o direito sobre a tabela disciplinas, depois vá em View/Edit Data e clique em All Rows para listar todas as linhas presentes na tabela disciplinas:

![2021-10-10_13-19-41.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_13-19-41.png)

Observer que a interface do PgAdmin4 agora propicia vários recursos e observe na imagem abaixo em Data Output a tabela disciplinas e todas as suas linhas:

![2021-10-10_13-21-54.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_13-21-54.png)

## **5 - Conectar e acessar o banco de dados pelo DBeaver:**

Para download do DBeaver acesse o link abaixo:

https://dbeaver.io/download/

- Ir em: Database > New Database Connection
- Conforme imagem abaixo, clique no icone do PostgreSQL e depois clique em next( botão na parte inferior).

![2021-10-10_13-28-26.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_13-28-26.png)

- Confome imagem abaixo, use os seguintes valores:

  - Server Host: localhost
  - Database: universidade
  - Username: postgres
  - Password: 123456

![2021-10-10_13-30-17.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_13-30-17.png)

  - Clique em Test Connection para verificar se a configuração está correta e realizar uma conexão com sucesso.

![2021-10-10_13-30-34.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_13-30-34.png)

- Agora o PostgreSQL está configurado no DBeaver para uso no Linux conforme imagem abaixo:

![2021-10-10_16-12-56.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_16-12-56.png)


## **6 - Diagrama do banco de dados criado:**

![diagram.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/database/diagram/diagram.png)

## **7 - Criar backup do banco de dados utilizando o terminal:**

Utilizar o comando abaixo para entrar no bash do container do PostgreSQL:

```
docker exec -it postgres bash
```

Digitar o comando abaixo para listar as pastas ou arquivos presentes no diretorio:

```
ls
```

![2021-10-10_15-03-54.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_15-03-54.png)

Em seguida, digite o comando abaixo para criar o backup do banco de dados universidade:

```
pg_dump -U postgres -h localhost -p 5432 universidade > dump20211010.sql
```

Digite novamente o comando ls para para listar as pastas ou arquivos presentes no diretorio, observe que o arquivo dump20211010.sql foi criado conforme imagem:

![2021-10-10_15-12-12.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_15-12-12.png)

Agora utiliza o comando abaixo em uma nova janela/aba do terminal para criar uma cópia do arquivo de backup dump20211010.sql o movendo para o diretório desejado:

```
docker cp 2b057c2cf612:/dump20211010.sql /home/filipe/mydocs/dev/docker/tutorial-como-instalar-postgresql-no-docker-linux/database/backup/Dump20211010/
```

O comando acima é basicamente isso:

```
docker cp <numero do seu container do PostgreSQL>:/backup.sql <caminho para o diretório que você deseja copiar o arquivo nele>
```

Utilize o comando abaixo para listar/mostrar o arquivo copiado para o diretório desejado:

```
ls /home/filipe/mydocs/dev/docker/tutorial-como-instalar-postgresql-no-docker-linux/database/backup/Dump20211010/
```

Conforme imagem abaixo podemos observar que o arquivo de backup criado foi copiado para o diretório desejado:

![2021-10-10_15-18-37.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_15-18-37.png)

Em seguida, recomendo que delete o arquivo de backup criado dentro do container docker para não encher o mesmo de arquivo desnecessário(ou deixe ele ali pelo tempo que você necessitar), use o comando abaixo para deletar o arquivo dump20211010.sql:

```
rm -rf dump20211010.sql
```

Conforme imagem abaixo o arquivo de backup dump20211010.sql foi deletado:

![2021-10-10_15-22-00.png](https://github.com/lipegomes/tutorial-como-instalar-postgresql-no-docker-linux/blob/main/assets/img/2021-10-10_15-22-00.png)

## **8 - Considerações finais:**

O objetivo desse tutorial não é fazer um CRUD(Create, Read, Update, Delete), mas sim aprender a utilizar PostgreSQL com Docker, PgAdmin4 e DBeaver. Se sinta a vontade para fazer um CRUD e criar seu próprio banco de dados e tabelas.

###  Operational System:

- [Fedora](https://getfedora.org/)

###  Programs Used:

- [PgAdmin4](https://www.pgadmin.org/download/)
- [Dbeaver](https://dbeaver.io/)
- [Visual Studio Code](https://code.visualstudio.com/)

### Tools:

- [Git](https://git-scm.com/)
- [Docker](https://www.docker.com/)

### Data Base in Docker Hub:

- [PostgreSQL](https://hub.docker.com/_/postgres)
