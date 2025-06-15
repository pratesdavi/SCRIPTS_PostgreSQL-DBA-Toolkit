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
    - nomedoschema.tabela_preco_produtos_coletado tppc
    - tabela_itens: Dimensão dos itens coletados (produtos).

*/

SELECT
    diu.ite_description,  -- Nome do produto
    TO_CHAR(MIN(tppc.preco), '99G999D99') AS min_preco,              -- Preço mínimo formatado
    TO_CHAR(AVG(tppc.preco), '99G999D99') AS media_preco,           -- Preço médio formatado
    TO_CHAR(MAX(tppc.preco), '99G999D99') AS max_preco,             -- Preço máximo formatado
    TO_CHAR(MAX(tppc.preco) - MIN(tppc.preco), '99G999D99') AS difference -- Diferença entre máx. e mín.
FROM nomedoschema.tabela_preco_produtos_coletado tppc
INNER JOIN tabela_itens ti
    ON tppc.id_item = ti.id_item
GROUP BY dlu.loc_description, diu.ite_description
HAVING MAX(tppc.preco) - MIN(tppc.preco) > 300  -- Casos com variação maior que R$300
ORDER BY MAX(tppc.preco) - MIN(tppc.preco) DESC; -- Ordenação por maior discrepância
