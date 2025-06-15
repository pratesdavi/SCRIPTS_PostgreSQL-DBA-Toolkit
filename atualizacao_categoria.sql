--- ## ATULIZAÇÃO DE BU ## ---
-- ## TV
update nome_tabela nt
set categoria = nome_categoria 
from tabela_itens ti
where nt.id_item = ti.id_item
