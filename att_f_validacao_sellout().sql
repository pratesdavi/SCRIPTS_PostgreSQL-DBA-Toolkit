-- DROP PROCEDURE wogsemptcl.att_f_validacao_sellout();

CREATE OR REPLACE PROCEDURE wogsemptcl.att_f_validacao_sellout()
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    -- Variáveis para contar linhas afetadas por cada operação
    rows_tsk_id             INT := 0;
    rows_ite_id             INT := 0;
    rows_loc_id             INT := 0;
    rows_age_id             INT := 0;
    rows_data_coleta        INT := 0;
    rows_data_venda         INT := 0;
    rows_preco              INT := 0;
    rows_numero_nf          INT := 0;
    rows_ft_nf_1            INT := 0;
    rows_ft_nf_2            INT := 0;
    rows_ft_nf_3            INT := 0;
    rows_qtd_vendas         INT := 0;
    rows_status_update      INT := 0;
    total_rows_affected     INT := 0;
    v_error_message         TEXT;
BEGIN
    RAISE NOTICE 'Iniciando o processo de atualização e limpeza da tabela f_validacao_sellout...';

    -- Atualização de ID ATIVIDADE
    UPDATE wogsemptcl.f_validacao_sellout fv
    SET tsk_id = f.tsk_id
    FROM wogsemptcl.f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    GET DIAGNOSTICS rows_tsk_id = ROW_COUNT;
    RAISE NOTICE 'Coluna "tsk_id" atualizada. Linhas afetadas: %', rows_tsk_id;

    -- Atualização de ID ITEM
    UPDATE wogsemptcl.f_validacao_sellout fv
    SET ite_id = f.ite_id
    FROM wogsemptcl.f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    GET DIAGNOSTICS rows_ite_id = ROW_COUNT;
    RAISE NOTICE 'Coluna "ite_id" atualizada. Linhas afetadas: %', rows_ite_id;

    -- Atualização de ID LOCAL
    UPDATE wogsemptcl.f_validacao_sellout fv
    SET loc_id = f.loc_id
    FROM wogsemptcl.f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    GET DIAGNOSTICS rows_loc_id = ROW_COUNT;
    RAISE NOTICE 'Coluna "loc_id" atualizada. Linhas afetadas: %', rows_loc_id;

    -- Atualização de ID PESSOAS
    UPDATE wogsemptcl.f_validacao_sellout fv
    SET age_id = f.age_id
    FROM wogsemptcl.f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    GET DIAGNOSTICS rows_age_id = ROW_COUNT;
    RAISE NOTICE 'Coluna "age_id" atualizada. Linhas afetadas: %', rows_age_id;

    -- Atualização de DATA_COLETA
    UPDATE wogsemptcl.f_validacao_sellout fv
    SET data_coleta = f.hty_initialdatehour
    FROM wogsemptcl.f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    GET DIAGNOSTICS rows_data_coleta = ROW_COUNT;
    RAISE NOTICE 'Coluna "data_coleta" atualizada. Linhas afetadas: %', rows_data_coleta;

    -- Atualização DATA_VENDA
    UPDATE wogsemptcl.f_validacao_sellout fv
    SET data_venda = TO_DATE(f.e_dt_venda, 'YYYY-MM-DD') -- Converte a string da data para tipo DATE
    FROM wogsemptcl.f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    GET DIAGNOSTICS rows_data_venda = ROW_COUNT;
    RAISE NOTICE 'Coluna "data_venda" atualizada. Linhas afetadas: %', rows_data_venda;

    -- Atualização de PRECO
    UPDATE wogsemptcl.f_validacao_sellout fv
    SET preco = f.e_prc_un_venda
    FROM wogsemptcl.f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    GET DIAGNOSTICS rows_preco = ROW_COUNT;
    RAISE NOTICE 'Coluna "preco" atualizada. Linhas afetadas: %', rows_preco;

    -- Atualização de NUMERO_NF
    UPDATE wogsemptcl.f_validacao_sellout fv
    SET numero_nf = f.e_num_nf
    FROM wogsemptcl.f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    GET DIAGNOSTICS rows_numero_nf = ROW_COUNT;
    RAISE NOTICE 'Coluna "numero_nf" atualizada. Linhas afetadas: %', rows_numero_nf;

    -- Atualização de FT_NF_1
    UPDATE wogsemptcl.f_validacao_sellout fv
    SET ft_nf_1 = f.e_ft_nf
    FROM wogsemptcl.f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    GET DIAGNOSTICS rows_ft_nf_1 = ROW_COUNT;
    RAISE NOTICE 'Coluna "ft_nf_1" atualizada. Linhas afetadas: %', rows_ft_nf_1;

    -- Atualização de FT_NF_2
    UPDATE wogsemptcl.f_validacao_sellout fv
    SET ft_nf_2 = f.e_ft_nf2
    FROM wogsemptcl.f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    GET DIAGNOSTICS rows_ft_nf_2 = ROW_COUNT;
    RAISE NOTICE 'Coluna "ft_nf_2" atualizada. Linhas afetadas: %', rows_ft_nf_2;

    -- Atualização de FT_NF_3
    UPDATE wogsemptcl.f_validacao_sellout fv
    SET ft_nf_3 = f.e_ft_nf3
    FROM wogsemptcl.f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    GET DIAGNOSTICS rows_ft_nf_3 = ROW_COUNT;
    RAISE NOTICE 'Coluna "ft_nf_3" atualizada. Linhas afetadas: %', rows_ft_nf_3;

    -- Atualização de QTD_VENDAS
    UPDATE wogsemptcl.f_validacao_sellout fv
    SET qtd_vendas = f.e_qtd_vendas
    FROM wogsemptcl.f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    GET DIAGNOSTICS rows_qtd_vendas = ROW_COUNT;
    RAISE NOTICE 'Coluna "qtd_vendas" atualizada. Linhas afetadas: %', rows_qtd_vendas;

    -- Atualização de STATUS (baseado na coluna 'motivo')
    UPDATE wogsemptcl.f_validacao_sellout
    SET status = CASE
        WHEN motivo = 'APROVADO' THEN 'APROVADO'
        ELSE 'REPROVADO' -- Se 'motivo' não for 'APROVADO', ou for NULL, o status será 'REPROVADO'.
    END;
    GET DIAGNOSTICS rows_status_update = ROW_COUNT;
    RAISE NOTICE 'Coluna "status" atualizada com base no "motivo". Linhas afetadas: %', rows_status_update;

    -- Soma total de linhas afetadas por todas as operações de UPDATE/DELETE
    total_rows_affected := rows_tsk_id + rows_ite_id + rows_loc_id + rows_age_id +
                           rows_data_coleta + rows_data_venda + rows_preco +
                           rows_numero_nf + rows_ft_nf_1 + rows_ft_nf_2 + rows_ft_nf_3 +
                           rows_qtd_vendas + rows_status_update;

    RAISE NOTICE 'Processo de atualização e limpeza da tabela f_validacao_sellout concluído. Total de linhas afetadas: %', total_rows_affected;

    -- Registra o sucesso na tabela de logs
    INSERT INTO tabela_de_logs (procedure_name, execution_time, status, total_rows_affected, error_message)
    VALUES ('wogsemptcl.att_f_validacao_sellout', NOW(), 'SUCESSO', total_rows_affected, NULL);

EXCEPTION
    WHEN OTHERS THEN
        -- Captura a mensagem de erro
        GET STACKED DIAGNOSTICS v_error_message = MESSAGE_TEXT;
        RAISE NOTICE 'Erro durante a limpeza da tabela f_validacao_sellout: %', v_error_message;

        -- Registra a falha na tabela de logs
        INSERT INTO tabela_de_logs (procedure_name, execution_time, status, total_rows_affected, error_message)
        VALUES ('wogsemptcl.att_f_validacao_sellout', NOW(), 'FALHA', NULL, v_error_message);
        -- Re-lança o erro para o cliente que chamou a procedure
        RAISE;
END;
$procedure$
;
