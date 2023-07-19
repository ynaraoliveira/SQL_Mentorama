# SQL_Mentorama

Esse documento refere-se ao projeto final do curso de SQL da escola Mentorama.
O conteúdo do curso abordou a linguagem de consulta de dados, a linguagem demdefinição de dados, a linguagem de manipulação de dados, a linguagem de controle de transações e a linguagem de controle de dados. 
Foi usado o MySQL como sistema de gerenciamento de banco de dados e o MySQL Workbench como interface gráfica.
Esse projeto busca definir o modelo conceitual, o modelo lógico, o modelo físico e as consultas e análises realizadas no banco de dados.

## Modelo Conceitual e Lógico

O sistema proposto descreve a arquitetura de armazenamento de dados de um e-commerce fictício de livros com produtos no formato físico e digital e entrega no Brasil. A inserção dos dados dos clientes e de pedidos no banco seria feita através da interação do usuário com a interface gráfica do site (frontend). O registro dos dados de pedidos e vendas seria parte da lógica de um sistema backend que validaria as regras de negócio e registraria os dados no banco. Os dados de livros e estoque seria registrado através de um sistema interno por funcionários do próprio e-commerce. Os bancos de dados poderiam ser acessados diretamente por analistas de dados, com as restrições aplicadas pelo administrador do banco de dados, para fins de consultas e análises para geração de valor para o negócio.

### Regras de negócio

- Trata-se de um e-commerce próprio com a finalidade única de vender livros
- Os livros vendidos são no formato digital ou físico
- No estoque podemos ter vários livros iguais, apenas com um id_estoque diferente
- Um cliente é considerado ativo se tiver feito uma compra nos últimos 3 meses
- O status inativo não impede que o cliente realize uma compra
- A tabela ‘vendas’ armazena apenas os pedidos aprovados
- Cada item do pedido é registrado com um id_pedido diferente
- Os status possíveis para a tabela pedido são ‘aprovado’, ‘pendente’ e ‘rejeitado’

### Descrição das tabelas

→ **clientes**: armazena dados que identifica o cliente no sistema, caso já existente, ou registra um novo cliente se for o caso. É composta pelas colunas id_cliente, nome, sobrenome, email, id_endereco, ultima_atualizacao e ativo. 

→ **enderecos**: tabela que contém os dados de endereço do cliente e é identificada através da chave estrangeira id_cliente. As outras colunas da tabela são id_endereco, logradouro, cep, cidade, estado.

→ **livros**: essa tabela contém detalhes do produto vendido nesse e-commerce. Aqui são encontradas informações sobre a obra como o título e o gênero literário. As colunas dessa tabela são id_livro, título, id_autor e genero. 

→ **autores**: descreve detalhes do autor da obra. Como um mesmo autor pode ter escrito vários livros, essa tabela é representada de forma apartada para evitar a repetição de dados na tabela livros. As colunas são representadas pela chave primária id_autor e os campos nome e sobrenome.

→ **estoque**: a finalidade dessa tabela é fazer um levantamento de todas as unidades de produto disponíveis para ser vendidas. Dessa forma, as colunas são representadas apenas pela chave primária id_estoque, a chave estrangeira id_livro e o formato do livro, que pode ser livro físico ou digital.

→ **pedidos**: a tabela pedidos representa o histórico de todos os pedidos feitos pelo e-commerce e armazena o seu status, que pode ser aprovado, pendente ou negado. Ela é representada pela chave primária id_pedido e as chaves estrangeiras id_cliente e id_estoque.

→ **vendas**: a tabela vendas representa apenas aqueles pedidos que foram concluídos com sucesso e, portanto, têm status aprovado. Suas colunas são id_pedido, valor e data_pedido.

[Query com a criação e inserção de dados nas tabelas](https://github.com/ynaraoliveira/SQL_Mentorama/blob/main/definicao.sql)

## Modelo Físico

Abaixo segue um o diagrama entidade e relacionamento do banco de dados já refinado, bem como os relacionamentos entre as tabelas, a indicação das chaves primárias e secundárias e o tipo do dado de cada coluna. Esse diagrama foi gerado pelo software MySQL Workbench.

![](https://github.com/ynaraoliveira/SQL_Mentorama/blob/main/diagrama.png)

## Consultas e Análises

- Qual a venda acumulada do mês de maio por gênero literário?
    
    Essa query permite avaliar o acumulado de vendas por categoria e por mês. Assim é possível analisar qual gênero literário está liderando as vendas em um intervalo temporal.
    
- Lista dos 3 livros com unidades mais vendidas.
    
    A finalidade dessa query é indicar o ranking dos livros mais vendidos. Com base nela podemos mostrar na página inicial do e-commerce indicações das unidades mais populares.
    
- Qual o valor total de livros vendidos por gênero? A proporção de vendas por gênero condiz com a proporção disponível em estoque?
    
    Essa query busca analisar o valor total de vendas por gênero literário versus a disponibilidade de estoque por gênero literário. Assim podemos avaliar se precisamos adquirir mais variedade de livros para complementar o estoque de acordo com os gêneros mais populares.
    
- Qual o Estado com o maior número de pedidos registrados no e-commerce?
    
    Essa query busca analisar a região do país que lidera o pedido de vendas na plataforma. Assim podemos tanto buscar ações para manter um bom fluxo de vendas nessa região como buscar formas de engajar as regiões com um volume menor de vendas ou implementar outras medidas, se necessário.

[Query com as análises feitas acima](https://github.com/ynaraoliveira/SQL_Mentorama/blob/main/analise.sql)
