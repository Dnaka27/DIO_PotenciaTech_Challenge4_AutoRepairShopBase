CREATE DATABASE AutoRepairShop;

USE AutoRepairSHop;

-- Criar tabelas

CREATE TABLE clients(
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(25),
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    clientType ENUM('Pessoa física', 'Pessoa jurídica') DEFAULT 'Pessoa física',
    Address VARCHAR(40),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
);

CREATE TABLE orders(
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    orderDate DATE,
    ordersStatus ENUM('Cancelado', 'Terminado', 'Em processamento') DEFAULT 'Em processamento',
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES clients(idClient)
);

CREATE TABLE product(
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(45),
    category ENUM('Peças', 'Acessórios', 'Serviços', 'Customização') DEFAULT 'Serviços',
    Pdescription VARCHAR (255),
    price FLOAT NOT NULL
);

CREATE TABLE employee (
	idEmployee INT AUTO_INCREMENT,
    Fname VARCHAR(10),
    Minit CHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    salary FLOAT,
    Sector ENUM ('Administração', 'Operação', 'Financeiro') DEFAULT 'Operação',
    PRIMARY KEY (idEmployee, salary),
    CONSTRAINT unique_cpf_client UNIQUE (CPF)
);

CREATE TABLE payment (
	idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idPClient INT,
    sendValue FLOAT,
    typePayment ENUM('Debito', 'Credito', 'Dinheiro', 'Pix') DEFAULT 'Dinheiro',
    aditionalValue FLOAT,
    CONSTRAINT fk_payment_client FOREIGN KEY (idPClient) REFERENCES clients(idClient)
);

CREATE TABLE expenses (
	idExpense INT AUTO_INCREMENT PRIMARY KEY,
	expenseDescription VARCHAR(45),
    expenseType ENUM('Empregado', 'Aluguel', 'Taxas', 'Reembolso', 'Outras contas') DEFAULT 'Outras contas',
    expenseValue FLOAT DEFAULT 0,
    expenseDate DATE
);

CREATE TABLE orderProduct (
	idOPProduct INT,
    idOPOrder INT,
    period DATE,
    orderDescription VARCHAR(255),
    PRIMARY KEY (idOPProduct, idOPOrder),
    CONSTRAINT fk_orderProduct_product FOREIGN KEY (idOPProduct) REFERENCES product(idProduct),
    CONSTRAINT fk_orderProduct_order FOREIGN KEY (idOPOrder) REFERENCES orders(idOrder)
);