-- ###########################################################################
-- ## 📊 REVALIDAÇÃO DE PREÇOS POR PRODUTO E LOJA                          ##
-- ## Verifica a consistência dos preços coletados, destacando casos com   ##
-- ## grande variação de valor entre lojas e produtos, mesmo após validação.##
-- ###########################################################################

/*
📋 Objetivo:
    Esta consulta tem como foco revalidar os preços coletados por produto e loja,
    identificando possíveis divergências significativas entre os valores mínimo e máximo.
    Serve como uma segunda checagem, já que mesmo coletas "sem erro" podem conter
    inconsistências não percebidas inicialmente.

🔍 O que ela faz:
    - Extrai os valores mínimo, médio e máximo de preço por item e loja.
    - Filtra apenas os casos onde a diferença entre o preço máximo e mínimo excede R$ 300.
    - Formata os valores para melhor leitura (separadores e casas decimais).

🗂️ Tabelas utilizadas:
    - tabela_preco_produtos tpp
    - tabela_itens: Dimensão dos itens coletados (produtos).

*/

SELECT
    diu.ite_description,  -- Nome do produto
    TO_CHAR(MIN(tpp.preco), '99G999D99') AS min_preco,              -- Preço mínimo formatado
    TO_CHAR(AVG(tpp.preco), '99G999D99') AS media_preco,           -- Preço médio formatado
    TO_CHAR(MAX(tpp.preco), '99G999D99') AS max_preco,             -- Preço máximo formatado
    TO_CHAR(MAX(tpp.preco) - MIN(tpp.preco), '99G999D99') AS difference -- Diferença entre máx. e mín.
FROM wogsemptcl.tabela_preco_produtos tpp
INNER JOIN d_locais_umov dlu
    ON fvca.loc_id = dlu.loc_id
INNER JOIN d_itens_umov diu
    ON fvca.ite_id = diu.ite_id
WHERE fvca.validado = 'SIM - SEM ERRO'  -- Apenas coletas validadas como sem erro
GROUP BY dlu.loc_description, diu.ite_description
HAVING MAX(fvca.preco) - MIN(fvca.preco) > 300  -- Casos com variação maior que R$300
ORDER BY MAX(fvca.preco) - MIN(fvca.preco) DESC; -- Ordenação por maior discrepância
