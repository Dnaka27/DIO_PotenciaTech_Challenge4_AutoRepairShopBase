USE autorepairshop;

-- Inserção de dados

INSERT INTO clients (Fname, Minit, Lname, CPF, clientType, Address) VALUES
('Maria', 'A.', 'Silva', '12345678901', 'Pessoa física', 'Rua A, 123'),
('Empresa ABC', NULL, NULL, '09876543210', 'Pessoa jurídica', 'Av. Principal, 456'),
('João', 'B.', 'Pereira', '23456789012', 'Pessoa física', 'Rua B, 789'),
('Empresa XYZ', NULL, NULL, '98765432109', 'Pessoa jurídica', 'Av. Secundária, 789'),
('Carlos', 'C.', 'Santos', '34567890123', 'Pessoa física', 'Rua C, 456');

INSERT INTO orders (idOrderClient, orderDate, ordersStatus) VALUES
(1, '2023-09-01', 'Em processamento'),
(2, '2023-08-15', 'Terminado'),
(3, '2023-09-02', 'Em processamento'),
(4, '2023-08-25', 'Cancelado'),
(5, '2023-09-03', 'Em processamento');

INSERT INTO product (Pname, category, Pdescription, price) VALUES
('Pneu', 'Peças', 'Pneu de alta qualidade para carros', 140),
('Óleo de Motor', 'Acessórios', 'Óleo sintético para motores a gasolina', 2500),
('Troca de Óleo', 'Serviços', 'Troca de óleo e filtro de óleo', 1200),
('Kit de Personalização', 'Customização', 'Kit de personalização para veículos', 2000),
('Pastilhas de Freio', 'Peças', 'Pastilhas de freio de cerâmica', 60);

INSERT INTO employee (Fname, Minit, Lname, CPF, salary, Sector) VALUES
('Ana', 'M.', 'Santos', '45678901234', 4000, 'Administração'),
('Pedro', 'A.', 'Oliveira', '56789012345', 3500, 'Operação'),
('Mariana', 'B.', 'Silva', '67890123456', 4200, 'Financeiro'),
('Ricardo', 'C.', 'Pereira', '78901234567', 1600, 'Operação'),
('Luciana', 'D.', 'Martins', '89012345678', 4100, 'Financeiro');

INSERT INTO payment (idPClient, sendValue, typePayment, aditionalValue) VALUES
(1, 150, 'Dinheiro', 0),
(2, 1200, 'Debito', 40),
(3, 60, 'Credito', 0),
(4, 2500, 'Pix', 100),
(5, 2000, 'Dinheiro', 30);

INSERT INTO expenses (expenseDescription, expenseType, expenseValue, expenseDate) VALUES
('Salário do Funcionário estagiário A', 'Empregado', 1600, '2023-09-05'),
('Aluguel do Escritório', 'Aluguel', 1500, '2023-09-01'),
('Taxa de Serviços', 'Taxas', 300, '2023-09-10'),
('Reembolso de Despesas de Viagem', 'Reembolso', 500, '2023-08-28'),
('Conta de Energia Elétrica', 'Outras contas', 200, '2023-09-15');

INSERT INTO orderProduct (idOPProduct, idOPOrder, period, orderDescription) VALUES
(1, 1, '2023-09-05', 'Pneu para o carro da Maria'),
(3, 2, '2023-08-15', 'Troca de óleo para a empresa ABC'),
(5, 3, '2023-09-02', 'Pastilhas de freio para o carro do João'),
(2, 4, '2023-08-25', 'Óleo de motor para a empresa XYZ'),
(4, 5, '2023-09-03', 'Kit de personalização para o carro do Carlos');

-- Manipulando dados

-- Ver clientes por pedidos como pessoa física
SELECT concat(Fname, " ", minit, " ", Lname) as Fullname, CPF, address, orderDate, ordersStatus, clientType FROM clients INNER JOIN orders ON idOrderClient = idClient WHERE clientType = "Pessoa física";

-- Clientes por pedidos por pessoa jurídica e CPF do responsável da empresa
SELECT Fname, CPF, address, orderDate, ordersStatus, clientType FROM clients INNER JOIN orders ON idOrderClient = idClient WHERE clientType = "Pessoa jurídica";

-- Ver os clientes com seus pagamentos
SELECT Fname as firstName, concat(minit, " ", Lname) as lastName, sendValue, typePayment, aditionalValue FROM clients INNER JOIN payment ON idPClient = idClient;

-- Ver os clientes e os detalhes dos pedidos de produtos
SELECT Fname as firstName, concat(minit, " ", Lname) as lastName, clientType, period, orderDescription, Pname, category, Pdescription, price FROM clients INNER JOIN orders ON idOrderClient = idClient INNER JOIN orderProduct ON idOPOrder = idOrder INNER JOIN product ON idProduct = idOPProduct;

-- Ver os clientes e valor do troco dos pedidos
SELECT Fname as firstName, concat(minit, " ", Lname) as lastName, period, Pname, Pdescription, sendValue - price AS tip FROM clients INNER JOIN payment ON idPClient = idClient INNER JOIN orders ON idOrderClient = idClient INNER JOIN orderProduct ON idOPOrder = idOrder INNER JOIN product ON idProduct = idOPProduct;

-- Ver o resumo de fluxo por cliente por pedido completo ou em processamento
SELECT Fname as firstName, concat(minit, " ", Lname) as lastName, period, Pname, price AS valueIn, ordersStatus FROM clients INNER JOIN payment ON idPClient = idClient INNER JOIN orders ON idOrderClient = idClient INNER JOIN orderProduct ON idOPOrder = idOrder INNER JOIN product ON idProduct = idOPProduct WHERE ordersStatus = "Em processamento" OR ordersStatus = "Terminado";

-- Ver tabela de funcionários
SELECT concat(Fname, " ", minit, " ", Lname) AS FullName, CPF, salary, Sector FROM employee;

-- Ver tabela de gastos de setembro
SELECT * FROM expenses WHERE expenseDate >= "2023-09-01" AND expenseDate <= "2023-09-30";

-- Ver tabela de valor a entrar por produto terminado ou em processamento
SELECT Pname, SUM(price) AS sumPrice, ordersStatus FROM product INNER JOIN orderProduct ON idOPProduct = idProduct INNER JOIN orders ON idOrder = idOPOrder GROUP BY Pname, ordersStatus HAVING ordersStatus = "Em processamento" OR ordersStatus = "Terminado";

-- Ver possível total de entrada de setembro em processamento (há pedidos em processamentos ainda)
SELECT SUM(sumPrice) AS totalInSeptember FROM (SELECT Pname, SUM(price) AS sumPrice, ordersStatus FROM product INNER JOIN orderProduct ON idOPProduct = idProduct INNER JOIN orders ON idOrder = idOPOrder GROUP BY Pname, ordersStatus HAVING ordersStatus = "Em processamento" OR ordersStatus = "Terminado") AS subquery;

-- Ver possível total de saída de setembro
SELECT SUM(sumExpenses) AS totalOutSeptember FROM (SELECT idExpense, SUM(expenseValue) AS sumExpenses FROM expenses WHERE expenseDate >= "2023-09-01" AND expenseDate <= "2023-09-30" GROUP BY idExpense) AS subquery;

-- Ver possível fluxo de setembro (há pedidos em processamentos ainda)
SELECT (totalInSeptember - totalOutSeptember) AS differenceSeptember FROM (
	SELECT SUM(sumPrice) AS totalInSeptember FROM (
        SELECT Pname, SUM(price) AS sumPrice
        FROM product
        INNER JOIN orderProduct ON idOPProduct = idProduct
        INNER JOIN orders ON idOrder = idOPOrder
        WHERE ordersStatus IN ("Em processamento", "Terminado")
        GROUP BY Pname
    ) AS subquery1
) AS subquery1v1,
(
    SELECT SUM(sumExpenses) AS totalOutSeptember FROM (
        SELECT idExpense, SUM(expenseValue) AS sumExpenses
        FROM expenses
        WHERE expenseDate >= "2023-09-01" AND expenseDate <= "2023-09-30"
        GROUP BY idExpense
    ) AS subquery2
) AS subquery2v1;

