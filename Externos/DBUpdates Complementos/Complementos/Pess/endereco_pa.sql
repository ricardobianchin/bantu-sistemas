SET TERM ^;
CREATE OR ALTER PACKAGE ENDERECO_PA
AS
BEGIN
  PROCEDURE UF_SIGLA_LISTA_GET
  RETURNS (
      UF_SIGLA CHAR(2),
      UF_IBGE_ID ID_SHORT_DOM
  );
  
  PROCEDURE MUNICIPIO_LISTA_GET
  (
    UF_SIGLA CHAR(2)
  )
  RETURNS
  (
    MUNICIPIO_IBGE_ID CHAR(5)
    , NOME NOME_DOM
  );

  PROCEDURE GARANTIR 
  (
    LOJA_ID           ID_SHORT_DOM,
    TERMINAL_ID       ID_SHORT_DOM,
    PESSOA_ID         ID_DOM,
    ORDEM             ID_SHORT_DOM,
    LOGRADOURO        VARCHAR(70),
    NUMERO            NOME_DOM,
    COMPLEMENTO       NOME_DOM,
    BAIRRO            NOME_DOM,
    UF_SIGLA          CHAR(2),
    CEP               CHAR(8),
    MUNICIPIO_IBGE_ID CHAR(5),
    DDD               CHAR(2),
    FONE1             NOME_CURTO_DOM,
    FONE2             NOME_CURTO_DOM,
    FONE3             NOME_CURTO_DOM,
    CONTATO           NOME_DOM,
    REFERENCIA        OBS1_DOM
  );
END^

/*
--------
-- BODY
--------
*/

RECREATE PACKAGE BODY ENDERECO_PA
AS
BEGIN
  PROCEDURE UF_SIGLA_LISTA_GET
  RETURNS (
      UF_SIGLA CHAR(2),
      UF_IBGE_ID ID_SHORT_DOM
  )
  AS
  BEGIN
    FOR SELECT
      UF_SIGLA,
      UF_IBGE_ID
    FROM UF
    ORDER BY UF_SIGLA
    INTO :UF_SIGLA,
      :UF_IBGE_ID
    DO
    BEGIN
      SUSPEND;
    END
  END
  
  PROCEDURE MUNICIPIO_LISTA_GET
  (
    UF_SIGLA CHAR(2)
  )
  RETURNS
  (
    MUNICIPIO_IBGE_ID CHAR(5)
    , NOME NOME_DOM
  )
  AS
  BEGIN
    FOR SELECT
      MUNICIPIO_IBGE_ID,
      NOME
    FROM MUNICIPIO
    WHERE UF_SIGLA = :UF_SIGLA
    ORDER BY NOME
    INTO :MUNICIPIO_IBGE_ID,
        :NOME
    DO
    BEGIN
      SUSPEND;
    END
  END

  PROCEDURE GARANTIR 
  (
    LOJA_ID           ID_SHORT_DOM,
    TERMINAL_ID       ID_SHORT_DOM,
    PESSOA_ID         ID_DOM,
    ORDEM             ID_SHORT_DOM,
    LOGRADOURO        VARCHAR(70),
    NUMERO            NOME_DOM,
    COMPLEMENTO       NOME_DOM,
    BAIRRO            NOME_DOM,
    UF_SIGLA          CHAR(2),
    CEP               CHAR(8),
    MUNICIPIO_IBGE_ID CHAR(5),
    DDD               CHAR(2),
    FONE1             NOME_CURTO_DOM,
    FONE2             NOME_CURTO_DOM,
    FONE3             NOME_CURTO_DOM,
    CONTATO           NOME_DOM,
    REFERENCIA        OBS1_DOM
  )
  AS
  BEGIN
    UPDATE OR INSERT INTO ENDERECO (
        LOJA_ID,
        TERMINAL_ID,
        PESSOA_ID,
        ORDEM,
        LOGRADOURO,
        NUMERO,
        COMPLEMENTO,
        BAIRRO,
        UF_SIGLA,
        CEP,
        MUNICIPIO_IBGE_ID,
        DDD,
        FONE1,
        FONE2,
        FONE3,
        CONTATO,
        REFERENCIA
    )
    VALUES (
        :LOJA_ID,
        :TERMINAL_ID,
        :PESSOA_ID,
        :ORDEM,
        :LOGRADOURO,
        :NUMERO,
        :COMPLEMENTO,
        :BAIRRO,
        :UF_SIGLA,
        :CEP,
        :MUNICIPIO_IBGE_ID,
        :DDD,
        :FONE1,
        :FONE2,
        :FONE3,
        :CONTATO,
        :REFERENCIA
    )
    MATCHING (LOJA_ID, TERMINAL_ID, PESSOA_ID, ORDEM);
  END
END^
SET TERM ;^
