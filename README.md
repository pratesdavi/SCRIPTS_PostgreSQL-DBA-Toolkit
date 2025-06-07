# PostgreSQL DBA Toolkit 🛠️

Coleção de scripts úteis para administração de bancos PostgreSQL

## 📁 Estrutura de Pastas


## 🔐 Scripts de Permissões

### [Listar Permissões de Tabelas](scripts-database/blob/main/list_table_permissions.sql)
Lista permissões agrupadas por usuário/schema/tabela

**Uso:**
```bash
psql -d nome_banco -f scripts/permissions/list_table_permissions.sql
