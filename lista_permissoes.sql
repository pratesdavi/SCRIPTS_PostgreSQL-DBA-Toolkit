-- Esta consulta SQL lista todas as permissões de tabelas concedidas a usuários/roles em um banco de dados PostgreSQL,
-- excluindo esquemas de sistema. Ela agrupa as permissões por destinatário, esquema e tabela, fornecendo uma visão consolidada dos privilégios.


SELECT 
    grantee,
    table_schema,
    table_name,
    string_agg(privilege_type, ', ') AS permissions
FROM information_schema.role_table_grants
WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
GROUP BY grantee, table_schema, table_name
ORDER BY table_schema, table_name;
