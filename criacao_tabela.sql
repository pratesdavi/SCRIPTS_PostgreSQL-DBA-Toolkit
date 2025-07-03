select * from tabela_de_logs;

-- Cria a tabela 'tabela_de_logs' para registrar as execuções das procedures de limpeza.
CREATE TABLE tabela_de_logs (
    log_id SERIAL PRIMARY KEY, -- Chave primária auto-incrementável para cada registro de log.
    procedure_name TEXT NOT NULL, -- Nome da procedure que foi executada (ex: 'limpeza_f_validacao_coleta_tv').
    execution_time TIMESTAMP WITH TIME ZONE DEFAULT NOW(), -- Data e hora da execução do log, com fuso horário.
    status TEXT NOT NULL, -- Status da execução ('SUCESSO' ou 'FALHA').
    total_rows_affected INT, -- Número total de linhas afetadas pela procedure. Pode ser NULL em caso de falha.
    error_message TEXT -- Mensagem de erro, se a procedure falhou. Será NULL em caso de sucesso.
);

-- Opcional: Adicionar comentários para documentação da tabela e colunas
COMMENT ON TABLE tabela_de_logs IS 'Tabela para registrar o histórico de execuções de procedures de limpeza.';
COMMENT ON COLUMN tabela_de_logs.log_id IS 'Identificador único do registro de log.';
COMMENT ON COLUMN tabela_de_logs.procedure_name IS 'Nome da procedure de limpeza executada.';
COMMENT ON COLUMN tabela_de_logs.execution_time IS 'Timestamp da execução da procedure.';
COMMENT ON COLUMN tabela_de_logs.status IS 'Status da execução: SUCESSO ou FALHA.';
COMMENT ON COLUMN tabela_de_logs.total_rows_affected IS 'Número total de linhas modificadas (inseridas, atualizadas, excluídas) pela procedure.';
COMMENT ON COLUMN tabela_de_logs.error_message IS 'Mensagem de erro em caso de falha na execução da procedure.';
