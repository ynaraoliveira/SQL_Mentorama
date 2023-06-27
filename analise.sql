-- Consultas e Análises

-- Qual a venda acumulada do mês de maio por gênero literário?
SELECT  l.genero
       ,SUM(v.valor) OVER (PARTITION BY l.genero ROWS UNBOUNDED PRECEDING) AS venda_acumulada_maio
FROM vendas AS v
INNER JOIN pedidos AS p
ON v.id_pedido = p.id_pedido
INNER JOIN estoque AS e
ON p.id_estoque = e.id_estoque
INNER JOIN livros AS l
ON e.id_livro = l.id_livro
WHERE EXTRACT(MONTH
FROM data_pedido) = '05';

-- Lista dos 3 livros com unidades mais vendidas
SELECT  l.titulo
       ,CONCAT(a.nome,' ',a.sobrenome) AS autor
       ,l.genero
       ,COUNT(e.id_livro)              AS numero_vendas
FROM pedidos AS p
INNER JOIN estoque AS e
ON p.id_estoque = e.id_estoque
INNER JOIN livros AS l
ON e.id_livro = l.id_livro
INNER JOIN autores AS a
ON l.id_autor = a.id_autor
WHERE status = 'aprovado'
GROUP BY  e.id_livro
ORDER BY numero_vendas DESC
LIMIT 3;

-- Qual o valor total de livros vendidos por gênero? 
-- A proporção de vendas por gênero condiz com a proporção disponível em estoque?
SELECT  l.genero
       ,SUM(v.valor) AS valor_total
FROM vendas AS v
INNER JOIN pedidos AS p
ON v.id_pedido = p.id_pedido
INNER JOIN estoque AS e
ON p.id_estoque = e.id_estoque
INNER JOIN livros AS l
ON e.id_livro = l.id_livro
GROUP BY  l.genero
ORDER BY valor_total DESC;
-- Os gêneros com maior unidades vendidas são aventura, romance e fantasia. 

SELECT  l.genero
       ,COUNT(e.id_livro) AS valor_total
FROM vendas AS v
INNER JOIN pedidos AS p
ON v.id_pedido = p.id_pedido
INNER JOIN estoque AS e
ON p.id_estoque = e.id_estoque
INNER JOIN livros AS l
ON e.id_livro = l.id_livro
GROUP BY  l.genero
ORDER BY valor_total DESC;
-- Os gêneros com maior unidades disponíveis em estoque são aventura, fantasia e romance. 
-- Portanto podemos afirmar que a quantidade de livros vendidos condiz com a quantodade de livros disponíveis em estoque 

-- Qual o Estado com o maior número de pedidos registrados no ecommerce?
SELECT  e.estado
       ,COUNT(p.id_cliente) AS total_pedidos
FROM pedidos AS p
INNER JOIN clientes AS c
ON p.id_cliente = c.id_cliente
INNER JOIN enderecos AS e
ON c.id_endereco = e.id_endereco
GROUP BY  e.estado
ORDER BY total_pedidos DESC
LIMIT 1;