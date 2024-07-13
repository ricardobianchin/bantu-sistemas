SET TERM ^;
CREATE OR ALTER PACKAGE LOJA_MANUT_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  (
    P_LOJA_ID ID_SHORT_DOM NOT NULL
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
    
    , PESS_CRIADO_EM TIMESTAMP
    , PESS_ALTERADO_EM TIMESTAMP
    
    , ENDER_ORDEM SMALLINT
    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)
    , MUNICIPIO_IBGE_ID    CHAR(5)
    , MUNICIPIO_NOME    NOME_DOM
    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM
    , CONTATO              NOME_DOM
    , REFERENCIA           OBS1_DOM
    , ENDER_CRIADO_EM            TIMESTAMP
    , ENDER_ALTERADO_EM          TIMESTAMP
    , ATIVO BOOLEAN
  );--LISTA_GET FIM

  PROCEDURE GARANTIR(
    LOJA_ID SMALLINT NOT NULL,
    TERMINAL_ID SMALLINT NOT NULL,
    NOME VARCHAR(60),
    NOME_FANTASIA VARCHAR(60),
    APELIDO VARCHAR(20),
    GENERO_ID CHAR(1),
    ESTADO_CIVIL_ID CHAR(1),
    C VARCHAR(15),
    I VARCHAR(15),
    M VARCHAR(15),
    M_UF CHAR(2),
    EMAIL VARCHAR(50),
    DT_NASC DATE,
    PESSOA_ID INTEGER,

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
    REFERENCIA        OBS1_DOM,

    ATIVO BOOLEAN
  )
  RETURNS
  (
    LOJA_ID_RET SMALLINT,
    TERMINAL_ID_RET SMALLINT,
    PESSOA_ID_RET INTEGER
  );
END^

----- body -----

RECREATE PACKAGE BODY LOJA_MANUT_PA
AS
BEGIN
  PROCEDURE LISTA_GET
  (
    P_LOJA_ID ID_SHORT_DOM NOT NULL
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
    
    , PESS_CRIADO_EM TIMESTAMP
    , PESS_ALTERADO_EM TIMESTAMP
    
    , ENDER_ORDEM SMALLINT
    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)
    , MUNICIPIO_IBGE_ID    CHAR(5)
    , MUNICIPIO_NOME    NOME_DOM
    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM
    , CONTATO              NOME_DOM
    , REFERENCIA           OBS1_DOM
    , ENDER_CRIADO_EM            TIMESTAMP
    , ENDER_ALTERADO_EM          TIMESTAMP
    , ATIVO BOOLEAN
  )
  AS
  BEGIN
    FOR
      WITH LO AS
      (
        SELECT 
          LOJA_ID, 
          APELIDO, 
          ATIVO
        FROM 
          LOJA
        WHERE (:P_LOJA_ID = 0) OR (:P_LOJA_ID = LOJA_ID)
        ORDER BY LOJA_ID
      )
      , MU AS
      (
        SELECT MUNICIPIO_IBGE_ID, NOME FROM MUNICIPIO
      )
      , PE AS
      (
        SELECT
          P.LOJA_ID,
          P.TERMINAL_ID,
          P.PESSOA_ID, 
          P.NOME, 
          P.NOME_FANTASIA, 
          P.GENERO_ID, 
          P.ESTADO_CIVIL_ID, 
          P.C, 
          P.I, 
          P.M, 
          P.M_UF, 
          P.EMAIL, 
          P.DT_NASC, 
          P.CRIADO_EM PESS_CRIADO_EM,
          P.ALTERADO_EM PESS_ALTERADO_EM, 
          
          E.ORDEM ENDER_ORDEM,
          E.LOGRADOURO,
          E.NUMERO,
          E.COMPLEMENTO,
          E.BAIRRO,
          E.UF_SIGLA,
          E.CEP,
          E.MUNICIPIO_IBGE_ID,
          MU.NOME MUNICIPIO_NOME,
          E.DDD,
          E.FONE1,
          E.FONE2,
          E.FONE3,
          E.CONTATO,
          E.REFERENCIA,
          E.CRIADO_EM ENDER_CRIADO_EM,
          E.ALTERADO_EM ENDER_ALTERADO_EM
          
        FROM 
          LOJA_EH_PESSOA LP 
        JOIN 
          PESSOA P ON LP.LOJA_ID = P.LOJA_ID AND LP.TERMINAL_ID = P.TERMINAL_ID AND LP.PESSOA_ID = P.PESSOA_ID
        LEFT JOIN 
          ENDERECO E ON P.LOJA_ID = E.LOJA_ID AND P.TERMINAL_ID = E.TERMINAL_ID AND P.PESSOA_ID = E.PESSOA_ID AND E.ORDEM = 0
        LEFT JOIN
          MU ON MU.MUNICIPIO_IBGE_ID = E.MUNICIPIO_IBGE_ID
      )
      SELECT 
        LO.LOJA_ID,
        PE.TERMINAL_ID,
        PE.PESSOA_ID, 
        LO.APELIDO, 
        
        PE.NOME, 
        PE.NOME_FANTASIA, 
        
        PE.C, 
        PE.I, 
        PE.M, 
        PE.M_UF, 
        
        PE.EMAIL, 
        PE.DT_NASC, 
        
        PE.PESS_CRIADO_EM, 
        PE.PESS_ALTERADO_EM, 
        
        PE.ENDER_ORDEM,
        PE.LOGRADOURO,
        PE.NUMERO,
        PE.COMPLEMENTO,
        PE.BAIRRO,
        PE.UF_SIGLA,
        PE.CEP,
        PE.MUNICIPIO_IBGE_ID,
        PE.MUNICIPIO_NOME,
        PE.DDD,
        PE.FONE1,
        PE.FONE2,
        PE.FONE3,
        PE.CONTATO,
        PE.REFERENCIA,
        PE.ENDER_CRIADO_EM,
        PE.ENDER_ALTERADO_EM,
        LO.ATIVO
     FROM LO
      LEFT JOIN PE ON
      LO.LOJA_ID = PE.LOJA_ID

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
      
      , :PESS_CRIADO_EM
      , :PESS_ALTERADO_EM
      
      , :ENDER_ORDEM
      , :LOGRADOURO
      , :NUMERO
      , :COMPLEMENTO
      , :BAIRRO
      , :UF_SIGLA
      , :CEP
      , :MUNICIPIO_IBGE_ID
      , :MUNICIPIO_NOME
      , :DDD
      , :FONE1
      , :FONE2
      , :FONE3
      , :CONTATO
      , :REFERENCIA

      , :ENDER_CRIADO_EM
      , :ENDER_ALTERADO_EM

      , :ATIVO
    
    DO 
      SUSPEND; 
  END


  PROCEDURE GARANTIR(
    LOJA_ID SMALLINT NOT NULL,
    TERMINAL_ID SMALLINT NOT NULL,
    NOME VARCHAR(60),
    NOME_FANTASIA VARCHAR(60),
    APELIDO VARCHAR(20),
    GENERO_ID CHAR(1),
    ESTADO_CIVIL_ID CHAR(1),
    C VARCHAR(15),
    I VARCHAR(15),
    M VARCHAR(15),
    M_UF CHAR(2),
    EMAIL VARCHAR(50),
    DT_NASC DATE,
    PESSOA_ID INTEGER,

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
    REFERENCIA        OBS1_DOM,

    ATIVO BOOLEAN
  )
  RETURNS
  (
    LOJA_ID_RET SMALLINT,
    TERMINAL_ID_RET SMALLINT,
    PESSOA_ID_RET INTEGER
  )
  AS
  BEGIN
    SELECT PESSOA_ID_GRAVADA FROM PESSOA_PA.GARANTIR(
      :LOJA_ID,
      :TERMINAL_ID,
      :NOME,
      :NOME_FANTASIA,
      :APELIDO,
      :GENERO_ID,
      :ESTADO_CIVIL_ID,
      :C,
      :I,
      :M,
      :M_UF,
      :EMAIL,
      :DT_NASC,
      :PESSOA_ID,
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
    ) INTO :PESSOA_ID_RET;

    :LOJA_ID_RET = :LOJA_ID;
    :TERMINAL_ID_RET = :TERMINAL_ID;
    
    EXECUTE PROCEDURE LOJA_INICIAL_PA.GARANTIR(:LOJA_ID, :APELIDO, :ATIVO);

    UPDATE OR INSERT INTO LOJA_EH_PESSOA (LOJA_ID, TERMINAL_ID, PESSOA_ID)
    VALUES (:LOJA_ID_RET, :TERMINAL_ID_RET, :PESSOA_ID_RET)
    MATCHING (LOJA_ID, TERMINAL_ID, PESSOA_ID);
    
    SUSPEND;
  END
END^
SET TERM ;^
