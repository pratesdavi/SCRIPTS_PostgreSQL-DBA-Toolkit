CREATE OR REPLACE PROCEDURE limpeza_f_validacao_sellout()
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE 'Iniciando o processo de atualização e limpeza da tabela f_validacao_sellout...';

    -- Atualização de ID ATIVIDADE
    UPDATE f_validacao_sellout fv
    SET tsk_id = f.tsk_id
    FROM f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    RAISE NOTICE 'Coluna "tsk_id" atualizada.';

    -- Atualização de ID ITEM
    UPDATE f_validacao_sellout fv
    SET ite_id = f.ite_id
    FROM f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    RAISE NOTICE 'Coluna "ite_id" atualizada.';

    -- Atualização de ID LOCAL
    UPDATE f_validacao_sellout fv
    SET loc_id = f.loc_id
    FROM f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    RAISE NOTICE 'Coluna "loc_id" atualizada.';

    -- Atualização de ID PESSOAS
    UPDATE f_validacao_sellout fv
    SET age_id = f.age_id
    FROM f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    RAISE NOTICE 'Coluna "age_id" atualizada.';

    -- Atualização de DATA_COLETA
    UPDATE f_validacao_sellout fv
    SET data_coleta = f.hty_initialdatehour
    FROM f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    RAISE NOTICE 'Coluna "data_coleta" atualizada.';

    -- Atualização DATA_VENDA
    UPDATE f_validacao_sellout fv
    SET data_venda = TO_DATE(f.e_dt_venda, 'YYYY-MM-DD') -- Converte a string da data para tipo DATE
    FROM f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    RAISE NOTICE 'Coluna "data_venda" atualizada.';

    -- Atualização de PRECO
    UPDATE f_validacao_sellout fv
    SET preco = f.e_prc_un_venda
    FROM f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    RAISE NOTICE 'Coluna "preco" atualizada.';

    -- Atualização de NUMERO_NF
    UPDATE f_validacao_sellout fv
    SET numero_nf = f.e_num_nf
    FROM f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    RAISE NOTICE 'Coluna "numero_nf" atualizada.';

    -- Atualização de FT_NF_1
    UPDATE f_validacao_sellout fv
    SET ft_nf_1 = f.e_ft_nf
    FROM f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    RAISE NOTICE 'Coluna "ft_nf_1" atualizada.';

    -- Atualização de FT_NF_2
    UPDATE f_validacao_sellout fv
    SET ft_nf_2 = f.e_ft_nf2
    FROM f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    RAISE NOTICE 'Coluna "ft_nf_2" atualizada.';

    -- Atualização de FT_NF_3
    UPDATE f_validacao_sellout fv
    SET ft_nf_3 = f.e_ft_nf3
    FROM f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    RAISE NOTICE 'Coluna "ft_nf_3" atualizada.';

    -- Atualização de QTD_VENDAS
    UPDATE f_validacao_sellout fv
    SET qtd_vendas = f.e_qtd_vendas
    FROM f_sellout_umov f
    WHERE f.codigo_agrupador = fv.codigo_agrupador;
    RAISE NOTICE 'Coluna "qtd_vendas" atualizada.';

    -- Atualização de STATUS (baseado na coluna 'motivo')
    UPDATE f_validacao_sellout
    SET status = CASE
        WHEN motivo = 'APROVADO' THEN 'APROVADO'
        ELSE 'REPROVADO' -- Se 'motivo' não for 'APROVADO', ou for NULL, o status será 'REPROVADO'.
    END;
    RAISE NOTICE 'Coluna "status" atualizada com base no "motivo".';

    RAISE NOTICE 'Processo de atualização e limpeza da tabela f_validacao_sellout concluído.';
END;
$$;
