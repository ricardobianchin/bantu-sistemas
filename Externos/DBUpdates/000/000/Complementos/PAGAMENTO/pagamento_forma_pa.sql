--DROP PACKAGE PAGAMENTO_FORMA_PA;
SET TERM ^;
CREATE OR ALTER PACKAGE PAGAMENTO_FORMA_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  RETURNS
  (
    FORMA_ID ID_SHORT_DOM
    , FORMA_TIPO_DESCR NOME_INTERM_DOM
    , DESCR NOME_INTERM_DOM
    , DESCR_RED CHAR(8)
    , PARA_VENDA BOOLEAN
    , ATIVO BOOLEAN
  );

  PROCEDURE INSERT_INTO
  (
    PAGAMENTO_FORMA_TIPO_ID  ID_CHAR_DOM Not Null
    , DESCR                  NOME_INTERM_DOM Not Null
    , DESCR_RED              CHAR(8) Not Null
    , ATIVO                  BOOLEAN Not Null
    , PARA_VENDA             BOOLEAN Not Null
    , SIS                    BOOLEAN Not Null
    , PROMOCAO_PERMITE       BOOLEAN Not Null
    , COMISSAO_PERMITE       BOOLEAN Not Null
    , TAXA_ADM_PERC          PERC_DOM  Not Null
    , VALOR_MINIMO           PRECO_DOM Not Null
    , COMISSAO_ABATER_PERC   PERC_DOM  Not Null
    , REEMBOLSO_DIAS         SMALLINT Not Null
    , TEF_USA                BOOLEAN Not Null
    , AUTORIZACAO_EXIGE      BOOLEAN Not Null
    , PESSOA_EXIGE           BOOLEAN Not Null
    , A_VISTA                BOOLEAN Not Null  
  )
  RETURNS
  (
    PAGAMENTO_FORMA_ID ID_SHORT_DOM
  );
END^

RECREATE PACKAGE BODY PAGAMENTO_FORMA_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  RETURNS
  (
    FORMA_ID ID_SHORT_DOM
    , FORMA_TIPO_DESCR NOME_INTERM_DOM
    , DESCR NOME_INTERM_DOM
    , DESCR_RED CHAR(8)
    , PARA_VENDA BOOLEAN
    , ATIVO BOOLEAN
  )
  AS
  BEGIN
    FOR
    WITH F AS (
      SELECT PAGAMENTO_FORMA_ID ID, PAGAMENTO_FORMA_TIPO_ID TIPO_ID,
        DESCR, DESCR_RED, PARA_VENDA, ATIVO
      FROM PAGAMENTO_FORMA  
    ),
    FT AS (
      SELECT PAGAMENTO_FORMA_TIPO_ID TIPO_ID, DESCR
      FROM PAGAMENTO_FORMA_TIPO
    )
    SELECT F.ID, FT.DESCR,
      F.DESCR, F.DESCR_RED, F.PARA_VENDA, F.ATIVO
    FROM F
    JOIN FT ON F.TIPO_ID = FT.TIPO_ID
    ORDER BY F.TIPO_ID, F.ID
    INTO :FORMA_ID, :FORMA_TIPO_DESCR, :DESCR, :DESCR_RED,
      :PARA_VENDA, :ATIVO
    DO SUSPEND; 
  END

  PROCEDURE INSERT_INTO
  (
    PAGAMENTO_FORMA_TIPO_ID  ID_CHAR_DOM Not Null
    , DESCR                  NOME_INTERM_DOM Not Null
    , DESCR_RED              CHAR(8) Not Null
    , ATIVO                  BOOLEAN Not Null
    , PARA_VENDA             BOOLEAN Not Null
    , SIS                    BOOLEAN Not Null
    , PROMOCAO_PERMITE       BOOLEAN Not Null
    , COMISSAO_PERMITE       BOOLEAN Not Null
    , TAXA_ADM_PERC          PERC_DOM  Not Null
    , VALOR_MINIMO           PRECO_DOM Not Null
    , COMISSAO_ABATER_PERC   PERC_DOM  Not Null
    , REEMBOLSO_DIAS         SMALLINT Not Null
    , TEF_USA                BOOLEAN Not Null
    , AUTORIZACAO_EXIGE      BOOLEAN Not Null
    , PESSOA_EXIGE           BOOLEAN Not Null
    , A_VISTA                BOOLEAN Not Null  
  )
  RETURNS
  (
    PAGAMENTO_FORMA_ID ID_SHORT_DOM
  )
  AS
  BEGIN
    PAGAMENTO_FORMA_ID = NEXT VALUE FOR PAGAMENTO_FORMA_SEQ;

    INSERT INTO PAGAMENTO_FORMA (PAGAMENTO_FORMA_ID, PAGAMENTO_FORMA_TIPO_ID, 
      DESCR, DESCR_RED, ATIVO, PARA_VENDA, SIS, PROMOCAO_PERMITE,
      COMISSAO_PERMITE, TAXA_ADM_PERC, VALOR_MINIMO, COMISSAO_ABATER_PERC,
      REEMBOLSO_DIAS, TEF_USA, AUTORIZACAO_EXIGE, PESSOA_EXIGE, A_VISTA
    )VALUES(
      :PAGAMENTO_FORMA_ID, :PAGAMENTO_FORMA_TIPO_ID, :DESCR, :DESCR_RED,
      :ATIVO, :PARA_VENDA, :SIS, :PROMOCAO_PERMITE, :COMISSAO_PERMITE,
      :TAXA_ADM_PERC, :VALOR_MINIMO, :COMISSAO_ABATER_PERC, :REEMBOLSO_DIAS,
      :TEF_USA, :AUTORIZACAO_EXIGE, :PESSOA_EXIGE, :A_VISTA);    

    SUSPEND;
  END
END^
SET TERM ;^
