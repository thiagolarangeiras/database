INSERT INTO categoria (nome, descricao) VALUES 
    ('químicos', 'produtos químicos'),
    ('metais', 'produtos metálicos'),
    ('plástico', 'produtos plásticos'),
    ('tecido', 'produtos de tecidos'),
    ('comida', 'produtos de comida'),
    ('eletrônicos', 'produtos eletrônicos'),
    ('ração', 'produtos de ração'),
    ('brinquedo da China', 'produtos da China'),
    ('remédios', 'produtos farmacêuticos'),
    ('hot wheels', 'produtos da mattel')
;

INSERT INTO produto (idcategoria, nome, descricao, peso, preco) VALUES 
    (1, 'Cloreto de amônia', 'amõnia', 1.5, 220),
    (1, 'Ácido polifosfórico', 'ácido fosfórico condensado', 2, 300),
    (1, 'Ácido propiônico', 'ácido etanocarboxílico ; ácido metilacético ; ácido propanóico', 2.5, 350),
    (1, 'Ácido salicílico', 'ÁCIDO o - HIDROXIBENZÓICO', 3, 400),
    (1, 'Ácido sulfúrico', 'ÁCIDO PARA BATERIA ; ÓLEO DE VITRÍOLO ; ÁCIDO FERTILIZANTE ; SULFATO DE HIDROGÊNIO.', 3.0, 450),
    
    (2, 'Cano de metal', 'aço', 20.176, 28.71),
    (2, 'Bronze', 'ouro fraco', 102.5, 100.5),
    (2, 'Prata', 'A escolha perfeita para seus talheres', 412.150, 69.69),
    (2, 'Ouro', 'dourado', 1.75, 5500),
    (2, 'Platina', 'vale mais que ouro', 2, 5600),
    
    (3, 'Torneira', 'Com resistência', 0.5, 100),
    (4, 'toalha', 'com bordado', 0.3, 20),
    (5, 'feijão enlatado', 'vencido', 1, 20),
    (6, 'eletrônicos', 'produtos eletrônicos', 1, 20),
    (7, 'ração', 'produtos de ração', 1, 20),
    (8, 'brinquedo da China', 'produtos da China', 1, 20),
    (9, 'remédios', 'produtos farmacêuticos', 1, 20),

    (10, 'Ford J-Car', 'Ford GT pirata', 1, 20),
    (10, 'Silhouette', 'Carro feio', 1, 20),
    (10, 'Custom Police Cruiser', 'policia', 1, 20),
    (10, 'Porsche Carrera', '2000 Hot Wheels ', 1, 20),
    (10, '1970 Pontiac Firebird', 'HW Dream Garage', 1, 20),
    (10, '1970 Pontiac Firebird (2nd Color)', 'HW Dream Garage', 1, 20),
    (10, 'Porsche 935', 'HW Turbo', 1, 20),
    (10, 'Dodge Challenger verde do ben ten', 'o jp tem esse carro na vida real!!!!', 1, 20),
    (10, '69 Ford Mustang', 'Modelo do 007', 1, 20),
    (10, 'HW450F', 'motinha top eu tinha uma dessa', 1, 20)
;

INSERT INTO localizacao (uf, cidade, bairro, logradouro, numero, cep) VALUES
    ('SC', 'Criciúma', 'Verdinho', 'R. Tranquilo Dalmolin', 13, '88814505'),
    ('BA', 'Salvador', 'Cajazeira', 'Rua Álvaro da Franca Rocha', 15, '41334320'),
    ('SC', 'Blumenau', 'Velha', 'R. Gov. Jorge Lacerda', 80, '89045338'), 
    ('SC', 'Joinville', 'Anita Garibaldi', 'R. Dr. Plácido Olímpio de Oliveira', 1158, '89202165'),
    ('PR', 'Curitiba', 'Mercês', 'R. Cap. Joseph Pereira Quevedo', 622, '80710120'),
    ('SC', 'Florianópolis', 'Centro', 'R. Des. Arno Hoeschl', 360, '88015620'),
    ('SC', 'São José', 'Campinas', 'Av. Salvador di Bernardi', 77, '88101260')
;

INSERT INTO estoqueItens (idEstoque, idProduto, qtde_min, qtde_max, qtde) VALUES
    (1, 1, 5, 500, 60),
    (2, 2, 10, 50, 45),
    (1, 6, 20, 125, 23),
    (1, 11, 1, 20, 2),
    (2, 18, 5, 25, 2),
    (2, 19, 10, 50, 50),
    (3, 20, 50, 100, 51),
    (3, 21, 100, 200, 199),
    (1, 21, 10, 20, 22)
;

INSERT INTO estoque (idLocalizacao, nome) VALUES
    (1, 'Setor A'),
    (1, 'Setor B'),
    (1, 'Setor C'),
    (1, 'Setor D'),
    (1, 'Setor E'),
    (1, 'Setor F'),
    (1, 'Setor G')
;

INSERT INTO fornecedor (idLocalizacao, nome, cnpj, telefone, email) VALUES 
    (1, 'Mattel' , '12345678901234', '9999999999', 'email@email'), 
    (2, 'Vale' , '12345678901234', '9999999999', 'email@email'), -- metal
    (3, 'Globalpack' , '12345678901234', '9999999999', 'email@email'),  --plastico
    (4, 'JBS' , '12345678901234', '9999999999', 'email@email'),
    (5, 'Dow Chemical' , '12345678901234', '9999999999', 'email@email'),
    (6, 'Multilaser' , '12345678901234', '9999999999', 'email@email'),
    (7, 'Bayer' , '12345678901234', '9999999999', 'email@email')
;
    
INSERT INTO transportadora (idLocalizacao, nome, cnpj, telefone, email) VALUES
    (1, 'TNT Mercúrio Cargas e Encomendas Expressas' , '12345678901234', '9999999999', 'email@email'),
    (2, 'Rodonaves Transportes e Encomendas' , '12345678901234', '9999999999', 'email@email'),
    (3, 'Patrus Transportes Urgentes' , '12345678901234', '9999999999', 'email@email'),
    (4, 'Jamef Transportes' , '12345678901234', '9999999999', 'email@email'),
    (5, 'Alfa Transportes' , '12345678901234', '9999999999', 'email@email'),
    (6, 'Expresso São Miguel' , '12345678901234', '9999999999', 'email@email'),
    (7, 'Transportes Translovato' , '12345678901234', '9999999999', 'email@email')
;

-- tipo = 0 entrada 
-- tipo = 1 saida
INSERT INTO transacao (idFornecedor, idTransportadora, dataRegistro, dataFim, preco, frete, imposto, tipo) VALUES
    (1, 1, '2023/01/01 10:10:10', '2023/06/01 12:00:00', 100.00, 50.0, 1, 0),
    (2, 2, '2023/01/01 10:10:10', '2023/06/01 12:00:00', 200.50, 150.0, 1, 0),
    (3, 3, '2023/01/01 10:10:10', '2023/06/01 12:00:00', 300.75, 25.4, 1, 0),
    (4, 4, '2023/01/01 10:10:10', '2023/06/01 12:00:00', 100.00, 50.0, 1, 0),
    (null, 5, '2023/01/01 10:10:10', '2023/06/01 12:00:00', 100.00, 50.0, 1, 0),
    (null, 6, '2023/01/01 10:10:10', '2023/06/01 12:00:00', 100.00, 50.0, 1, 0),
    (null, 7, '2023/01/01 10:10:10', '2023/06/01 12:00:00', 100.00, 50.0, 1, 0)
;

INSERT INTO transacaoItens (idEstoqueItens, idProduto, idEstoque, idtransacao, qtde) VALUES
    (1, 1, 1, 1, 100),
    (2, 2, 2, 2, 500),
    (3, 6, 1, 3, 150),
    (4, 11, 1, 4, 50),
    (5, 18, 2, 5, 15),
    (6, 19, 2, 6, 200),
    (7, 20, 3, 7, 400),
    (8, 21, 3, 1, 10),
    (9, 21, 1, 2, 3)
;

UPDATE estoqueItens
SET qtde = qtde + (
    SELECT SUM(qtde) 
    FROM transacaoItens
    WHERE transacaoItens.idEstoque = estoqueItens.idEstoque
)
WHERE EXISTS (
    SELECT 1 
    FROM transacaoItens
    WHERE transacaoItens.idEstoque = estoqueItens.idEstoque
);
