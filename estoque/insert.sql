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
    (6, 'eletrônicos', 'produtos eletrônicos'),
    (7, 'ração', 'produtos de ração'),
    (8, 'brinquedo da China', 'produtos da China'),
    (9, 'remédios', 'produtos farmacêuticos'),

    (10, 'Ford J-Car', 'Ford GT pirata'),
    (10, 'Silhouette', 'Carro feio'),
    (10, 'Custom Police Cruiser', 'policia'),
    (10, 'Porsche Carrera', '2000 Hot Wheels '),
    (10, '1970 Pontiac Firebird', 'HW Dream Garage'),
    (10, '1970 Pontiac Firebird (2nd Color)', 'HW Dream Garage'),
    (10, 'Porsche 935', 'HW Turbo'),
    (10, 'Dodge Challenger verde do ben ten', 'o jp tem esse carro na vida real!!!!'),
    (10, '69 Ford Mustang', 'Modelo do 007'),
    (10, 'HW450F', 'motinha top eu tinha uma dessa')

INSERT INTO localizacao (cidade, bairro, logradouro, numero, cep) VALUES
    ('SC', 'Criciúma', 'Verdinho', 'R. Tranquilo Dalmolin', 13, '88814505'),
    ('BH', 'Salvador', 'Cajazeira', 'Rua Álvaro da Franca Rocha', 15, '41334320'),
    ('SC', 'Blumenau', 'Velha', 'R. Gov. Jorge Lacerda', 80, '89045338'), 
    ('SC', 'Joinville', 'Anita Garibaldi', 'R. Dr. Plácido Olímpio de Oliveira', 1158, '89202165'),
    ('PR', 'Curitiba', 'Mercês', 'R. Cap. Joseph Pereira Quevedo', 622, '80710120'),
    ('SC', 'Florianópolis', 'Centro', 'R. Des. Arno Hoeschl', 360, '88015620'),
    ('SC', 'São José', 'Campinas', 'Av. Salvador di Bernardi', 77, '88101260')

INSERT INTO estoque (idProduto, idLocalizacao, nome, qtde_min, qtde_estoque, total) VALUES
    (1, )
