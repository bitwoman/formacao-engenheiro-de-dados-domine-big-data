/*CREATING VIEWS*/
#Quais veículos foram locados em determinados períodos?
CREATE VIEW locadosPerido AS 
	SELECT 
	       veiculo.modelo AS Modelo, 
	       MONTH(loc.datalocacao) AS Mes, 
	       YEAR(loc.datalocacao) AS Ano, 
	       COUNT(*) AS Total 
	FROM locacao AS loc 
	JOIN veiculos AS veiculo ON (loc.idveiculo = veiculo.idveiculo) 
	GROUP BY veiculo.modelo, MONTH(loc.datalocacao), YEAR(loc.datalocacao) 
	ORDER BY Total DESC;


#Quais despachantes locaram quais veículos?
CREATE VIEW locadosDespachante AS 
	SELECT 
		desp.nome AS Nome, 
		veiculo.modelo AS Modelo, 
		MONTH(loc.datalocacao) AS Mes, 
		YEAR(loc.datalocacao) AS Ano, 
		COUNT(*) AS Total 
	FROM locacao AS loc 
	JOIN veiculos AS veiculo ON (loc.idveiculo = veiculo.idveiculo) 
	JOIN despachantes AS desp ON (desp.iddespachante = loc.iddespachante) 
	GROUP BY desp.nome, veiculo.modelo, MONTH(loc.datalocacao), YEAR(loc.datalocacao) 
	ORDER BY Total DESC;


#Qual o faturamento por período? 
CREATE VIEW locadosFaturamento AS 
	SELECT 
		MONTH(loc.datalocacao) AS Mes, 
		YEAR(loc.datalocacao) AS Ano, 
		SUM(loc.total) AS Total 
	FROM locacao AS loc 
	GROUP BY MONTH(loc.datalocacao), YEAR(loc.datalocacao) 
	ORDER BY Mes, Ano; 


#Quais clientes locaram veículos?
CREATE VIEW locadosClientes AS 
	SELECT 
		c.nome AS Cliente, 
		MONTH(loc.datalocacao) AS Mes, 
		YEAR(loc.datalocacao) AS Ano, 
		COUNT(*) AS TotalLocacoes 
	FROM locacao AS loc 
	JOIN clientes AS c ON(c.idcliente = loc.idcliente) 
	GROUP BY c.nome, MONTH(loc.datalocacao), YEAR(loc.datalocacao) 
	ORDER BY c.nome;