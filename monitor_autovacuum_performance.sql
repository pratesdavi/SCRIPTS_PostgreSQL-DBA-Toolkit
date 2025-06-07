/*
 * Descrição: Lista permissões de usuários/roles em tabelas de um schema específico, 
 *            mostrando proprietário, permissões e usuários/roles com acesso.
 * Versão: 1.1
 * Data Criação: 2023-10-15
 * Última Atualização: 2024-01-20
 *
 * Parâmetros:
 *   Nenhum (o schema está fixado como 'wogsemptcl' - edite conforme necessidade)
 *
 * Colunas:
 *   schema        - Schema onde a tabela está localizada
 *   tabela        - Nome da tabela
 *   proprietario  - Proprietário (owner) da tabela
 *   permissoes    - Lista de permissões agregadas (SELECT, INSERT, UPDATE, etc)
 *   usuarios_roles- Usuários e roles com permissões na tabela
 *
 * Uso:
 *   psql -d nome_banco -U usuario -f list_table_permissions.sql
 *   -- Ou para exportar CSV:
 *   psql -d meu_db -c "\i list_table_permissions.sql" -o output.csv -A -F ','
 *
 * Exemplo Saída:
 *   schema    | tabela  | proprietario | permissoes              | usuarios_roles
 *   ----------+---------+--------------+-------------------------+-----------------
 *   wogsemptcl| clientes| admin        | {SELECT,INSERT,UPDATE}  | {user1,user2}
 *   wogsemptcl| pedidos | app_owner    | {SELECT,UPDATE}         | {report_user}
 *
 * Requisitos:
 *   PostgreSQL 9.0+ (devido ao uso de array_agg())
 *   Privilégios para consultar pg_catalog e information_schema
 *
 * Notas:
 *   - Filtra apenas tabelas regulares (exclui views, sequences, etc)
 *   - Mostra apenas permissões atribuídas diretamente (não expande herança de roles)
 *   - O schema 'wogsemptcl' está fixado no WHERE (edite linha 46 para alterar)
 *   - Tabelas sem permissões explícitas mostrarão NULL nas colunas de permissões
 *   - Para múltiplos schemas: substitua por `n.nspname IN ('schema1', 'schema2')`
 */

-- =============================================================================
-- Consulta Principal
-- =============================================================================
SELECT
    n.nspname AS schema,
    c.relname AS tabela,
    r.rolname AS proprietario,
    array_agg(g.privilege_type) AS permissoes,
    array_agg(g.grantee) AS usuarios_roles
FROM 
    pg_catalog.pg_class c
JOIN 
    pg_catalog.pg_namespace n ON n.oid = c.relnamespace
JOIN 
    pg_catalog.pg_roles r ON r.oid = c.relowner
LEFT JOIN 
    information_schema.role_table_grants g 
    ON g.table_schema = n.nspname 
    AND g.table_name = c.relname
WHERE 
    c.relkind = 'r'  -- Somente tabelas regulares
    AND n.nspname = 'wogsemptcl'  -- Filtro por schema específico
    /* 
     * Para excluir múltiplos schemas de sistema:
     * AND n.nspname NOT IN ('pg_catalog', 'information_schema', 'pg_toast')
     */
GROUP BY 
    n.nspname, c.relname, r.rolname
ORDER BY 
    schema ASC, 
    tabela ASC;
