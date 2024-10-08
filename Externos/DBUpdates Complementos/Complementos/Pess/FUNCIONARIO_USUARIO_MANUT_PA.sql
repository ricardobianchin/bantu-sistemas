SET TERM ^;
CREATE OR ALTER PACKAGE FUNCIONARIO_USUARIO_MANUT_PA
AS
BEGIN 
  PROCEDURE LISTA_GET 
  (
    LOJA_ID_FILTRO ID_SHORT_DOM NOT NULL,
    TERMINAL_ID_FILTRO ID_SHORT_DOM NOT NULL,
    PESSOA_ID_FILTRO INTEGER NOT NULL
  )
  RETURNS 
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM

    , NOME NOME_DOM
    , NOME_FANTASIA NOME_DOM
    , APELIDO NOME_REDU_DOM

    , GENERO_ID CHAR(1)
    , GENERO_DESCR NOME_CURTO_DOM

    , ESTADO_CIVIL_ID CHAR(1)
    , ESTADO_CIVIL_DESCR NOME_CURTO_DOM
    
    , C VARCHAR(15)
    , I VARCHAR(15)
    , M VARCHAR(15)
    , M_UF CHAR(2)

    , EMAIL VARCHAR(50)
    , DT_NASC DATE
    , ATIVO BOOLEAN

    , PESS_CRIADO_EM TIMESTAMP
    , PESS_ALTERADO_EM TIMESTAMP

    , ENDER_ORDEM SMALLINT

    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)

    , MUNICIPIO_IBGE_ID    CHAR(7)
    , MUNICIPIO_NOME    NOME_DOM

    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM
    
    , CONTATO              NOME_DOM
    , REFERENCIA           OBS1_DOM

    , ENDER_CRIADO_EM            TIMESTAMP
    , ENDER_ALTERADO_EM          TIMESTAMP
    
    , NOME_DE_USUARIO NOME_REDU_DOM
    , SENHA SENHA_DOM
    , CRY_VER ID_SHORT_DOM
    , PERFIL_DE_USO_DESCRS VARCHAR(1024)
  );
  
  PROCEDURE PERFIL_DE_USO_IDS_GET (
    LOJA_ID ID_SHORT_DOM NOT NULL,
    TERMINAL_ID ID_SHORT_DOM NOT NULL,
    PESSOA_ID ID_DOM NOT NULL
  )
  RETURNS (
    PERFIL_DE_USO_ID ID_DOM,
    NOME NOME_REDU_DOM,
    TEM BOOLEAN
  );
  
END^

----- BODY -----

RECREATE PACKAGE BODY FUNCIONARIO_USUARIO_MANUT_PA
AS 
BEGIN
  PROCEDURE LISTA_GET 
  (
    LOJA_ID_FILTRO ID_SHORT_DOM NOT NULL,
    TERMINAL_ID_FILTRO ID_SHORT_DOM NOT NULL,
    PESSOA_ID_FILTRO INTEGER NOT NULL
  )
  RETURNS 
  (
    LOJA_ID ID_SHORT_DOM
    , TERMINAL_ID ID_SHORT_DOM
    , PESSOA_ID ID_DOM

    , NOME NOME_DOM
    , NOME_FANTASIA NOME_DOM
    , APELIDO NOME_REDU_DOM

    , GENERO_ID CHAR(1)
    , GENERO_DESCR NOME_CURTO_DOM

    , ESTADO_CIVIL_ID CHAR(1)
    , ESTADO_CIVIL_DESCR NOME_CURTO_DOM
    
    , C VARCHAR(15)
    , I VARCHAR(15)
    , M VARCHAR(15)
    , M_UF CHAR(2)

    , EMAIL VARCHAR(50)
    , DT_NASC DATE
    , ATIVO BOOLEAN

    , PESS_CRIADO_EM TIMESTAMP
    , PESS_ALTERADO_EM TIMESTAMP

    , ENDER_ORDEM SMALLINT
    , LOGRADOURO           VARCHAR(70)
    , NUMERO               NOME_DOM
    , COMPLEMENTO          NOME_DOM
    , BAIRRO               NOME_DOM
    
    , UF_SIGLA             CHAR(2)
    , CEP                  CHAR(8)

    , MUNICIPIO_IBGE_ID    CHAR(7)
    , MUNICIPIO_NOME    NOME_DOM

    , DDD                  CHAR(2)
    , FONE1                NOME_CURTO_DOM
    , FONE2                NOME_CURTO_DOM
    , FONE3                NOME_CURTO_DOM

    , CONTATO              NOME_DOM
    , REFERENCIA           OBS1_DOM

    , ENDER_CRIADO_EM            TIMESTAMP
    , ENDER_ALTERADO_EM          TIMESTAMP

    , NOME_DE_USUARIO NOME_REDU_DOM
    , SENHA SENHA_DOM
    , CRY_VER ID_SHORT_DOM
    , PERFIL_DE_USO_DESCRS VARCHAR(1024)
  )
  AS
  BEGIN 
    FOR
      WITH ECIVIL AS (
        SELECT ESTADO_CIVIL_ID, DESCR FROM ESTADO_CIVIL
      ), MU AS(
         SELECT UF_SIGLA, MUNICIPIO_IBGE_ID, NOME FROM MUNICIPIO
      ), GEN AS (
        SELECT GENERO_ID, DESCR FROM GENERO
      ), PES AS (
        SELECT
          LOJA_ID, TERMINAL_ID, PESSOA_ID, NOME, APELIDO, NOME_FANTASIA, GENERO_ID,
          ESTADO_CIVIL_ID, C, I, M, M_UF, EMAIL, DT_NASC, ATIVO,
          CRIADO_EM, ALTERADO_EM
        FROM
          PESSOA
        WHERE
          TERMINAL_ID = 0
      ), ENDER AS(
        SELECT
          LOJA_ID, TERMINAL_ID, PESSOA_ID, ORDEM, LOGRADOURO, NUMERO,
          COMPLEMENTO, BAIRRO, UF_SIGLA, CEP, MUNICIPIO_IBGE_ID,
          DDD, FONE1, FONE2, FONE3, CONTATO, REFERENCIA,
          CRIADO_EM, ALTERADO_EM
        FROM
          ENDERECO
        WHERE
          ORDEM = 0
      ), FUNCI AS(
        SELECT LOJA_ID, TERMINAL_ID, PESSOA_ID FROM FUNCIONARIO 
      ), USU AS(
        SELECT LOJA_ID, TERMINAL_ID, PESSOA_ID, NOME_DE_USUARIO, SENHA,
        CRY_VER
        FROM USUARIO
      ),
      PER AS (
        SELECT 
          PERFIL_DE_USO_ID, NOME, DE_SISTEMA
        FROM 
          PERFIL_DE_USO
      ),
      UTPER AS (
        SELECT 
          LOJA_ID, TERMINAL_ID, PESSOA_ID, PERFIL_DE_USO_ID
        FROM 
          USUARIO_TEM_PERFIL_DE_USO
      ) 
      
      SELECT
      ----------------------------
      --- SELECT CAMPOS INICIO
      ----------------------------
      
        PES.LOJA_ID,
        PES.TERMINAL_ID,
        PES.PESSOA_ID,
        
        PES.NOME,
        PES.NOME_FANTASIA,
        PES.APELIDO,
        
        GEN.GENERO_ID,
        GEN.DESCR GENERO_DESCR,
          
        ECIVIL.ESTADO_CIVIL_ID,
        ECIVIL.DESCR ESTADO_CIVIL_DESCR,
        
        PES.C,
        PES.I,
        PES.M,
        PES.M_UF,
        
        PES.EMAIL,
        PES.DT_NASC,
        PES.ATIVO,
        
        PES.CRIADO_EM PESS_CRIADO_EM,
        PES.ALTERADO_EM PESS_ALTERADO_EM,
        
        ENDER.ORDEM ENDER_ORDEM,
        ENDER.LOGRADOURO,
        ENDER.NUMERO,
        ENDER.COMPLEMENTO,
        ENDER.BAIRRO,
        
        ENDER.UF_SIGLA,
        ENDER.CEP,
        
        ENDER.MUNICIPIO_IBGE_ID,
        MU.NOME MUNICIPIO_NOME,
        
        ENDER.DDD,
        ENDER.FONE1,
        ENDER.FONE2,
        ENDER.FONE3,
        
        ENDER.CONTATO,
        ENDER.REFERENCIA,
        
        ENDER.CRIADO_EM ENDER_CRIADO_EM,
        ENDER.ALTERADO_EM ENDER_ALTERADO_EM,
    
        USU.NOME_DE_USUARIO,
        USU.SENHA,
        USU.CRY_VER,
        LIST(PER.NOME, ', ') AS PERFIL_DE_USO_DESCRS
          
      ----------------------------
      --- SELECT CAMPOS FIM
      ----------------------------
      FROM PES
      
      LEFT JOIN GEN ON
        GEN.GENERO_ID = PES.GENERO_ID
      
      LEFT JOIN ECIVIL ON
        ECIVIL.ESTADO_CIVIL_ID = PES.ESTADO_CIVIL_ID
      
      LEFT JOIN ENDER ON 
        ENDER.LOJA_ID = PES.LOJA_ID
        AND ENDER.TERMINAL_ID = PES.TERMINAL_ID
        AND ENDER.PESSOA_ID = PES.PESSOA_ID

      LEFT JOIN MU ON 
        ENDER.MUNICIPIO_IBGE_ID = MU.MUNICIPIO_IBGE_ID
      
      JOIN FUNCI ON
        FUNCI.LOJA_ID = PES.LOJA_ID
        AND FUNCI.TERMINAL_ID = PES.TERMINAL_ID
        AND FUNCI.PESSOA_ID = PES.PESSOA_ID
        
      LEFT JOIN USU ON
        USU.LOJA_ID = PES.LOJA_ID
        AND USU.TERMINAL_ID = PES.TERMINAL_ID
        AND USU.PESSOA_ID = PES.PESSOA_ID 
        
      LEFT JOIN UTPER ON 
        UTPER.LOJA_ID = PES.LOJA_ID AND UTPER.TERMINAL_ID = PES.TERMINAL_ID AND UTPER.PESSOA_ID = PES.PESSOA_ID

      LEFT JOIN PER ON
        PER.PERFIL_DE_USO_ID = UTPER.PERFIL_DE_USO_ID


      ----------------------------
      --- WHERE INICIO
      ----------------------------

      WHERE 
        :LOJA_ID_FILTRO = 0
        OR 
        (
        PES.LOJA_ID = :LOJA_ID_FILTRO
        AND PES.TERMINAL_ID = :TERMINAL_ID_FILTRO
        AND PES.PESSOA_ID = :PESSOA_ID_FILTRO
        )

      ----------------------------
      --- WHERE FIM
      ----------------------------



      GROUP BY
      ----------------------------
      --- GROUP BY CAMPOS INICIO
      ----------------------------
        PES.LOJA_ID,
        PES.TERMINAL_ID,
        PES.PESSOA_ID,
        
        PES.NOME,
        PES.NOME_FANTASIA,
        PES.APELIDO,
        
        GEN.GENERO_ID,
        GEN.DESCR,
          
        ECIVIL.ESTADO_CIVIL_ID,
        ECIVIL.DESCR,
        
        PES.C,
        PES.I,
        PES.M,
        PES.M_UF,
        
        PES.EMAIL,
        PES.DT_NASC,
        PES.ATIVO,
        
        PES.CRIADO_EM,
        PES.ALTERADO_EM,
        
        ENDER.ORDEM,
        ENDER.LOGRADOURO,
        ENDER.NUMERO,
        ENDER.COMPLEMENTO,
        ENDER.BAIRRO,
        
        ENDER.UF_SIGLA,
        ENDER.CEP,
        
        ENDER.MUNICIPIO_IBGE_ID,
        MU.NOME,
        
        ENDER.DDD,
        ENDER.FONE1,
        ENDER.FONE2,
        ENDER.FONE3,
        
        ENDER.CONTATO,
        ENDER.REFERENCIA,
        
        ENDER.CRIADO_EM,
        ENDER.ALTERADO_EM,
    
        USU.NOME_DE_USUARIO,
        USU.SENHA,
        USU.CRY_VER
      ----------------------------
      --- GROUP BY CAMPOS FIM
      ----------------------------
    INTO 
      :LOJA_ID,
      :TERMINAL_ID,
      :PESSOA_ID,
      
      :NOME,
      :NOME_FANTASIA,
      :APELIDO,
      
      :GENERO_ID,
      :GENERO_DESCR,
      
      :ESTADO_CIVIL_ID,
      :ESTADO_CIVIL_DESCR,
      
      :C,
      :I,
      :M,
      :M_UF,
      
      :EMAIL,
      :DT_NASC,
      :ATIVO,
      
      :PESS_CRIADO_EM,
      :PESS_ALTERADO_EM,

      :ENDER_ORDEM,
      :LOGRADOURO,
      :NUMERO,
      :COMPLEMENTO,
      :BAIRRO,
      
      :UF_SIGLA,
      :CEP,
      
      :MUNICIPIO_IBGE_ID,
      :MUNICIPIO_NOME,
      
      :DDD,
      :FONE1,
      :FONE2,
      :FONE3,
      
      :CONTATO,
      :REFERENCIA,
      
      :ENDER_CRIADO_EM,
      :ENDER_ALTERADO_EM,
      
      :NOME_DE_USUARIO,
      :SENHA,
      :CRY_VER,
      :PERFIL_DE_USO_DESCRS      
    DO 
      SUSPEND;
  END
  
  PROCEDURE PERFIL_DE_USO_IDS_GET (
    LOJA_ID ID_SHORT_DOM NOT NULL,
    TERMINAL_ID ID_SHORT_DOM NOT NULL,
    PESSOA_ID ID_DOM NOT NULL
  )
  RETURNS (
    PERFIL_DE_USO_ID ID_DOM,
    NOME NOME_REDU_DOM,
    TEM BOOLEAN
  )
  AS
  BEGIN
    FOR
      WITH P AS (
        SELECT PERFIL_DE_USO_ID, NOME
        FROM PERFIL_DE_USO
      ), UTP AS (
        SELECT PERFIL_DE_USO_ID
        FROM USUARIO_TEM_PERFIL_DE_USO
        WHERE LOJA_ID = :LOJA_ID
          AND TERMINAL_ID = :TERMINAL_ID
          AND PESSOA_ID = :PESSOA_ID
      )
      SELECT 
        P.PERFIL_DE_USO_ID,
        P.NOME,
        (UTP.PERFIL_DE_USO_ID IS NOT NULL) AS TEM
      FROM P
      LEFT JOIN UTP ON
        P.PERFIL_DE_USO_ID = UTP.PERFIL_DE_USO_ID
      ORDER BY P.NOME  
      INTO
        :PERFIL_DE_USO_ID,
        :NOME,
        :TEM
    DO
      SUSPEND;
  END
END^
SET TERM ;^