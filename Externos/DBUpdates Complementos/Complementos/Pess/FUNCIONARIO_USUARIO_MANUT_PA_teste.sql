SET TERM ^;
CREATE OR ALTER PACKAGE FUNCIONARIO_USUARIO_MANUT_PA
AS
BEGIN 
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

RECREATE PACKAGE BODY FUNCIONARIO_USUARIO_MANUT_PA
AS 
BEGIN
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
      INTO
        :PERFIL_DE_USO_ID,
        :NOME,
        :TEM
    DO
      SUSPEND;
  END
END^
SET TERM ;^
