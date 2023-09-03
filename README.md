# - Banco de Dados AutoRepairShop

Este repositório também é para um desafio do curso de ciência de dados da DIO, o banco de dados foi desenvolvido com o intuito de simular um sistema de gerenciamento para uma oficina automotiva. Este banco de dados desempenha um papel na administração de todas as operações, oferecendo uma estrutura organizada para armazenar e rastrear informações cruciais, como clientes, pedidos, produtos, funcionários, pagamentos e despesas.

### Principais Tabelas e Características

Resumindo os tópicos das tabelas:

- ### Tabela "Clients" (Clientes)
Registra informações completas sobre os clientes, incluindo nome, sobrenome, CPF, tipo de cliente, endereço e um ID exclusivo.
A integridade é assegurada com uma restrição contra duplicação de CPFs.

- ### Tabela "Orders" (Pedidos)
Mantém detalhes de pedidos, incluindo data e status (cancelado, terminado, em processamento).
Usa chaves estrangeiras para vincular pedidos a clientes.

- ### Tabela "Product" (Produtos)
Armazena dados detalhados sobre produtos, como nome, categoria, descrição e preço.

- ### Tabela "Employee" (Funcionários)
Registra informações de funcionários, como nome, CPF, salário e setor, identificados por um ID exclusivo.

- ### Tabela "Payment" (Pagamentos)
Mantém informações sobre pagamentos, incluindo tipo de pagamento, valor enviado e valor adicional, associandos a clientes por chaves estrangeiras.

- ### Tabela "Expenses" (Despesas)
Registra dados de despesas, incluindo descrição, tipo de despesa, valor e data.

- ### Tabela "OrderProduct" (Produtos do Pedido)
Rastreia produtos em cada pedido com detalhes como período e descrição, estabelecendo relações entre produtos, pedidos e a tabela de produtos por chaves estrangeiras.

A integridade dos dados é mantida no banco de dados por meio de chaves primárias e chaves estrangeiras. Assim, pode-se ter mais consistência e confiabilidade nas operações de consulta e/ou manipulação. Isso tudo também no intuito de fazer a tomada de decisões ser mais precisaa e informada.
