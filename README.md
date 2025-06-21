# PostgreSQL DBA Toolkit 🛠️

Coleção de scripts úteis para administração de bancos PostgreSQL

## 📁 Estrutura de Pastas


## 🔐 Scripts de Permissões

### [Listar Permissões de Tabelas](/list_table_permissions.sql)
Lista permissões


## 🔐 Monitor Autovacuum

### [Listar Permissões de Tabelas](/monitor_autovacuum_performance.sql)
Monitora as últimas operações de autovacuum e analyze em tabelas de um schema específico.

**Uso:**
```bash
psql -d nome_banco -f scripts/permissions/monitor_autovacuum_performance.sql
```
