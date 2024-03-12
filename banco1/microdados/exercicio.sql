-- 1. Qual é a média da nota em matemática dos alunos que estudaram numa escola em Santa Catarina?
SELECT AVG(NU_NOTA_MT) 'média de matemática'  
FROM MICRODADOS_ENEM_2021_SC a
WHERE SG_UF_ESC = 'SC';

-- 2. Qual é a média da nota em Linguagens e Códigos dos alunos que estudaram numa escola em Santa Catarina?
SELECT AVG(NU_NOTA_LC) 'Média de Linguagens'
FROM MICRODADOS_ENEM_2021_SC a
WHERE SG_UF_ESC = 'SC';

-- 3. Qual é a média da nota em Ciências Humanas dos alunos do sexo FEMININO que estudaram numa escola em Santa Catarina?
SELECT AVG(NU_NOTA_CN) 'Média de Ciências'
FROM MICRODADOS_ENEM_2021_SC a
WHERE SG_UF_ESC = 'SC' AND TP_SEXO = 'F';

-- 4. Qual é a soma das notas em Matemática dos alunos do sexo FEMININO que estudaram numa escola na cidade de Criciúma?

--pegar a cidade antes
SELECT distinct NO_MUNICIPIO_ESC from MICRODADOS_ENEM_2021_SC;

SELECT SUM(NU_NOTA_MT) 'Soma de Matemática'
FROM MICRODADOS_ENEM_2021_SC a
WHERE TP_SEXO = 'F' AND NO_MUNICIPIO_ESC = 'Criciúma';

-- 5. Qual é a diferença da nota média em matemática dos alunos que estudaram o ensino médio em escola pública e em escola privada?
SELECT AVG(NU_NOTA_MT) - (
	SELECT AVG(NU_NOTA_MT) 'Diferença da média de Matemática'
	FROM MICRODADOS_ENEM_2021_SC	
	WHERE TP_ESCOLA = 2
) 'Diferença da média de Matemática'
FROM MICRODADOS_ENEM_2021_SC	
WHERE TP_ESCOLA = 3;

-- 6. Quantos alunos não quiseram declarar a cor/raça em 2021 em SC (Entenda a opção "não declarado" nessa pergunta)?
SELECT COUNT(*) 'não declarados'
FROM MICRODADOS_ENEM_2021_SC
WHERE TP_COR_RACA = 0;

-- 7. Qual é o número de alunos do sexo feminino que estudaram em escola no estado de Santa Catarina?
SELECT COUNT(*) 'catarinenses'
FROM MICRODADOS_ENEM_2021_SC a
WHERE TP_SEXO = 'F' AND SG_UF_ESC = 'SC';

-- 8. Quantos alunos do sexo masculino que estudaram em escola no estado de Santa Catarina possuem EXATAMENTE uma geladeira em casa?
SELECT COUNT(*) 'cerveja gelada'
FROM MICRODADOS_ENEM_2021_SC a
WHERE TP_SEXO = 'M' AND SG_UF_ESC = 'SC' AND Q012 = 'B';

-- 9. Quantos alunos que estudaram em escolas em zona rural de Santa Catarina possuem internet em casa?
SELECT COUNT(*) 'fazendeiros modernos'
FROM MICRODADOS_ENEM_2021_SC a
WHERE SG_UF_ESC = 'SC' AND Q025 = 'B' AND TP_LOCALIZACAO_ESC = 2;

-- 10. Quantos alunos cuja residência possui ATÉ 2 carros que estudaram em uma escola de Blumenau?
SELECT COUNT(*) '(vrumm vrumm)^2'
FROM MICRODADOS_ENEM_2021_SC a
WHERE NO_MUNICIPIO_ESC = 'Blumenau' AND Q010 LIKE '[A-C]'

-- 11. Qual é a segunda cidade catarinense (considere a coluna NO_MUNICIPIO_ESC) em que estudaram mais alunos no ENEM 2021?
SELECT NO_MUNICIPIO_ESC '2º best sc-city', COUNT(*) 'qtde'
FROM MICRODADOS_ENEM_2021_SC a
WHERE SG_UF_ESC = 'SC' AND NU_ANO = 2021
GROUP BY NO_MUNICIPIO_ESC
ORDER BY COUNT(*) DESC
offset 1 rows
fetch next 1 rows only  

-- 12. Qual é a cidade catarinense (considere a coluna NO_MUNICIPIO_ESC) possui o menor número de alunos cuja mãe possui ensino superior completo?
SELECT TOP 1 NO_MUNICIPIO_ESC 'menos mães que n terminaram o ensino superior', COUNT(*) 'qtde' 
FROM MICRODADOS_ENEM_2021_SC a
WHERE SG_UF_ESC = 'SC' AND Q002 LIKE '[A-E]'
GROUP BY NO_MUNICIPIO_ESC
ORDER BY COUNT(*)

-- 13. Qual é a segunda cidade catarinense (considere a coluna NO_MUNICIPIO_ESC) que possui o maior número de pessoas na faixa “entre 26 e 30 anos”?
SELECT TOP 1 NO_MUNICIPIO_ESC '26 - 30 anos', COUNT(*) 'qtde'
FROM MICRODADOS_ENEM_2021_SC a
WHERE SG_UF_ESC = 'SC' AND TP_FAIXA_ETARIA = 11
GROUP BY NO_MUNICIPIO_ESC
ORDER BY COUNT(*) DESC

-- 14. Qual é a cidade catarinense (considere a coluna NO_MUNICIPIO_ESC) que possui o TERCEIRO maior número de alunos cuja residência possui PELO MENOS 2 banheiros?
SELECT NO_MUNICIPIO_ESC 'banheiro', COUNT(*) 'qtde'
FROM MICRODADOS_ENEM_2021_SC a
WHERE SG_UF_ESC = 'SC' AND Q008 LIKE '[C-E]'
GROUP BY NO_MUNICIPIO_ESC
ORDER BY COUNT(*) DESC
offset 2 rows
fetch next 1 rows only 