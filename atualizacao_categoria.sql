-- ###########################################################################
-- ## 🔄 ATUALIZAÇÃO DE CATEGORIA VIA DIMENSÃO DE ITENS                    ##
-- ## Atualiza a coluna 'categoria' na tabela 'nome_tabela' com os valores ##
-- ## da coluna 'nome_categoria' da tabela 'tabela_itens', baseando-se na  ##
-- ## correspondência pelo campo 'id_item'.                                ##
-- ###########################################################################

-- ✅ Sintaxe para PostgreSQL ou SQL Server:
UPDATE nome_tabela nt
SET categoria = nome_categoria 
FROM tabela_itens ti
WHERE nt.id_item = ti.id_item;

-- ✅ Sintaxe equivalente para MySQL:
UPDATE nome_tabela nt
JOIN tabela_itens ti ON nt.id_item = ti.id_item
SET nt.categoria = ti.nome_categoria;
