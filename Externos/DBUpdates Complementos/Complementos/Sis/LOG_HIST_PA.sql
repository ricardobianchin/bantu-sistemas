SET TERM ^;
CREATE OR ALTER PACKAGE LOG_HIST_PA
AS
BEGIN
  FUNCTION ULTIMO_LOG_ID_GET
  RETURNS BIGINT;

  PROCEDURE TEVE_LOJA
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM
    
    , APELIDO NOME_REDU_DOM    
    
    , NOME NOME_DOM
    , NOME_FANTASIA NOME_DOM

    , C VARCHAR(15)
    , I VARCHAR(15)
    , M VARCHAR(15)
    , M_UF CHAR(2)

    , EMAIL VARCHAR(50)
    , DT_NASC DATE
    , ATIVO BOOLEAN
    
    , PESS_CRIADO_EM TIMESTAMP
    , PESS_ALTERADO_EM TIMESTAMP

    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)
    , MUNICIPIO_IBGE_ID    CHAR(7)

    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM

    , CONTATO              NOME_DOM
    , REFERENCIA           OBS1_DOM
    , SELECIONADO BOOLEAN
  );  
  
  
  PROCEDURE TEVE_TERMINAL
  (
    TERMINAL_ID_ALVO ID_SHORT_DOM
    , LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    TERMINAL_ID_RET ID_SHORT_DOM
    , APELIDO NOME_REDU_DOM
    , NOME_NA_REDE VARCHAR(15)
    , IP IPV6_DOM
    , NF_SERIE SMALLINT
    , LETRA_DO_DRIVE CHAR(1)
    , GAVETA_TEM BOOLEAN
    , BALANCA_MODO_ID ID_SHORT_DOM
    , BALANCA_ID ID_SHORT_DOM
    , BARRAS_COD_INI SMALLINT
    , BARRAS_COD_TAM SMALLINT
    , CUPOM_NLINS_FINAL SMALLINT
    , SEMPRE_OFFLINE BOOLEAN
  );  
  
END^

------ BODY

RECREATE PACKAGE BODY LOG_HIST_PA
AS
BEGIN
  FUNCTION ULTIMO_LOG_ID_GET
  RETURNS BIGINT
  AS
    DECLARE VARIABLE LOG_ID_RET BIGINT;
  BEGIN
    SELECT MAX(LOG.LOG_ID)
    FROM LOG
    JOIN AMBIENTE_SIS ON AMBIENTE_SIS.LOJA_ID = LOG.LOJA_ID
    WHERE LOG.TERMINAL_ID = 0
    INTO :LOG_ID_RET;

    RETURN :LOG_ID_RET;
  END 

  PROCEDURE TEVE_LOJA
  (
    LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM
    
    , APELIDO NOME_REDU_DOM    
    
    , NOME NOME_DOM
    , NOME_FANTASIA NOME_DOM

    , C VARCHAR(15)
    , I VARCHAR(15)
    , M VARCHAR(15)
    , M_UF CHAR(2)

    , EMAIL VARCHAR(50)
    , DT_NASC DATE
    , ATIVO BOOLEAN
    
    , PESS_CRIADO_EM TIMESTAMP
    , PESS_ALTERADO_EM TIMESTAMP

    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)
    , MUNICIPIO_IBGE_ID    CHAR(7)

    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM

    , CONTATO              NOME_DOM
    , REFERENCIA           OBS1_DOM
    , SELECIONADO BOOLEAN
  )
  AS
    --DECLARE STMP CONFIG_VALOR_DOM;
  BEGIN
    SELECT FIRST(1)
      LOJA.LOJA_ID
      , P.TERMINAL_ID
      , P.PESSOA_ID
      
      , LOJA.APELIDO

      , P.NOME
      , P.NOME_FANTASIA
      
      , P.C
      , P.I
      , P.M
      , P.M_UF
      , P.EMAIL
      , P.DT_NASC
      , P.ATIVO
      
      , P.CRIADO_EM
      , P.ALTERADO_EM
      
      , E.LOGRADOURO
      , E.NUMERO
      , E.COMPLEMENTO
      , E.BAIRRO
      , E.UF_SIGLA
      , E.CEP
      , E.MUNICIPIO_IBGE_ID
      , E.DDD
      , E.FONE1
      , E.FONE2
      , E.FONE3
      , E.CONTATO
      , E.REFERENCIA
      
      , LOJA.SELECIONADO
      
    FROM AMBIENTE_SIS AMBI

    JOIN LOG ON 
      AMBI.LOJA_ID = LOG.LOJA_ID
      AND LOG.TERMINAL_ID = 0 -- TERM RETAGUARDA
      AND FEATURE_SIS_ID = 1 -- FEATURE LOJA
      AND LOG_ID >= :LOG_ID_INI
      AND LOG_ID <= :LOG_ID_FIN
      
    JOIN LOG_ENVOLVE_ID LOG_EN ON
      LOG_EN.LOJA_ID = LOG.LOJA_ID
      AND LOG_EN.TERMINAL_ID = LOG.TERMINAL_ID
      AND LOG_EN.LOG_ID = LOG.LOG_ID
      AND LOG_EN.LOJA_ID_ENVOLVIDO = AMBI.LOJA_ID  
      AND LOG_EN.TERMINAL_ID_ENVOLVIDO IS NULL
      AND LOG_EN.ID_ENVOLVIDO IS NULL

    JOIN LOJA ON
      AMBI.LOJA_ID = LOJA.LOJA_ID 
      
    LEFT JOIN LOJA_EH_PESSOA LEP ON
      LEP.LOJA_ID = LOJA.LOJA_ID 
      
    LEFT JOIN PESSOA P ON
      LEP.LOJA_ID = P.LOJA_ID 
      AND LEP.TERMINAL_ID = P.TERMINAL_ID 
      AND LEP.PESSOA_ID = P.PESSOA_ID 

    LEFT JOIN ENDERECO E ON
      P.LOJA_ID = E.LOJA_ID
      AND P.TERMINAL_ID = E.TERMINAL_ID
      AND P.PESSOA_ID = E.PESSOA_ID
    INTO
      :LOJA_ID
      , :TERMINAL_ID
      , :PESSOA_ID
      
      , :APELIDO
      
      , :NOME
      , :NOME_FANTASIA
      
      , :C
      , :I
      , :M
      , :M_UF

      , :EMAIL
      , :DT_NASC
      , :ATIVO
      
      , :PESS_CRIADO_EM
      , :PESS_ALTERADO_EM

      , :LOGRADOURO
      , :NUMERO
      , :COMPLEMENTO
      , :BAIRRO
      , :UF_SIGLA
      , :CEP

      , :MUNICIPIO_IBGE_ID

      , :DDD
      , :FONE1
      , :FONE2
      , :FONE3

      , :CONTATO
      , :REFERENCIA
      , :SELECIONADO
      ;
    SUSPEND;
  END
  
  PROCEDURE TEVE_TERMINAL
  (
    TERMINAL_ID_ALVO ID_SHORT_DOM
    , LOG_ID_INI BIGINT
    , LOG_ID_FIN BIGINT
  )
  RETURNS
  (
    TERMINAL_ID_RET ID_SHORT_DOM
    , APELIDO NOME_REDU_DOM
    , NOME_NA_REDE VARCHAR(15)
    , IP IPV6_DOM
    , NF_SERIE SMALLINT
    , LETRA_DO_DRIVE CHAR(1)
    , GAVETA_TEM BOOLEAN
    , BALANCA_MODO_ID ID_SHORT_DOM
    , BALANCA_ID ID_SHORT_DOM
    , BARRAS_COD_INI SMALLINT
    , BARRAS_COD_TAM SMALLINT
    , CUPOM_NLINS_FINAL SMALLINT
    , SEMPRE_OFFLINE BOOLEAN
  )
  AS
  BEGIN
    SELECT   
      T.TERMINAL_ID TERMINAL_ID_RET
        , T.APELIDO
        , T.NOME_NA_REDE
        , T.IP
        , T.NF_SERIE
        , T.LETRA_DO_DRIVE
        , T.GAVETA_TEM
        , T.BALANCA_MODO_ID
        , T.BALANCA_ID
        , T.BARRAS_COD_INI
        , T.BARRAS_COD_TAM
        , T.CUPOM_NLINS_FINAL
        , T.SEMPRE_OFFLINE
        
      FROM AMBIENTE_SIS AMBI

      JOIN LOG ON 
        AMBI.LOJA_ID = LOG.LOJA_ID
        AND LOG.TERMINAL_ID = 0 -- TERM RETAGUARDA
        AND FEATURE_SIS_ID = 2 -- FEATURE TERMINAL
        AND LOG_ID >= :LOG_ID_INI
        AND LOG_ID <= :LOG_ID_FIN
        
      JOIN LOG_ENVOLVE_ID LOG_EN ON
        LOG_EN.LOJA_ID = LOG.LOJA_ID
        AND LOG_EN.TERMINAL_ID = LOG.TERMINAL_ID
        AND LOG_EN.LOG_ID = LOG.LOG_ID
        AND LOG_EN.TERMINAL_ID_ENVOLVIDO = :TERMINAL_ID_ALVO

      JOIN TERMINAL t ON
        T.TERMINAL_ID = :TERMINAL_ID_ALVO
    INTO
      :TERMINAL_ID_RET
      , :APELIDO
      , :NOME_NA_REDE
      , :IP
      , :NF_SERIE
      , :LETRA_DO_DRIVE
      , :GAVETA_TEM
      , :BALANCA_MODO_ID
      , :BALANCA_ID
      , :BARRAS_COD_INI
      , :BARRAS_COD_TAM
      , :CUPOM_NLINS_FINAL
      , :SEMPRE_OFFLINE
      ;
    SUSPEND;
  END
END^
SET TERM ;^
