-- scripts/permissions/list_table_permissions.sql
/*
*Descrição:* Lista permissões de usuários/roles em tabelas, excluindo schemas de sistema
Versão: 1.0

Parametros:
  Nenhum

Colunas:
  grantee       - Usuário/role com permissão
  table_schema  - Schema da tabela
  table_name    - Nome da tabela
  permissions   - Lista de permissões agregadas

Uso:
  psql -d meu_db -f list_table_permissions.sql

Exemplo Saída:
  grantee    | table_schema | table_name | permissions
  -----------+--------------+------------+-----------------
  app_user   | public       | customers  | SELECT, INSERT

Requisitos:
  PostgreSQL 9.0+ (devido ao string_agg)
  Privilégios para consultar role_table_grants

Notas:
  - Mostra apenas permissões atribuídas diretamente
  - Permissões via roles de grupo não são expandidas
*/

SELECT 
    grantee,
    table_schema,
    table_name,
    string_agg(privilege_type, ', ') AS permissions
FROM information_schema.role_table_grants
WHERE 
    table_schema NOT IN ('pg_catalog', 'information_schema')
    -- Adicione outros schemas para excluir:
    -- AND table_schema NOT IN ('outro_schema')
GROUP BY 
    grantee, 
    table_schema, 
    table_name
ORDER BY 
    table_schema ASC, 
    table_name ASC;
