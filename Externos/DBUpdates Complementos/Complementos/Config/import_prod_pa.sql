/*
in "C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Config\import_prod_pa.sql";

execute procedure IMPORT_PROD_PA.APAGAR_DO;
*/

SET TERM ^;
CREATE OR ALTER PACKAGE IMPORT_PROD_PA
AS
BEGIN
  PROCEDURE APAGAR_DO;
END^

----- body -----

RECREATE PACKAGE BODY IMPORT_PROD_PA
AS
BEGIN
  PROCEDURE APAGAR_DO
  AS
  BEGIN
    DELETE FROM PROD_BARRAS;
    DELETE FROM PROD_COMPL;

    DELETE FROM PROD_CUSTO;
    DELETE FROM PROD_CUSTO_HIST;

    DELETE FROM PROD_PRECO;
    DELETE FROM PROD_PRECO_HIST;
    DELETE FROM PROD_PRECO_TABELA;

    DELETE FROM PROD;

    DELETE FROM LOG_PK;
    DELETE FROM LOG;

    DELETE FROM FABR WHERE FABR_ID > 0;
    DELETE FROM ICMS WHERE ICMS_ID > 3;
    DELETE FROM PROD_NATU;
    DELETE FROM PROD_TIPO;
    DELETE FROM UNID WHERE UNID_ID > 0;

    EXECUTE STATEMENT('ALTER SEQUENCE FABR_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE ICMS_SEQ RESTART WITH  4;');
    EXECUTE STATEMENT('ALTER SEQUENCE LOG_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE MACHINE_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE PAGAMENTO_FORMA_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE PESSOA_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE PROD_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE PROD_TIPO_SEQ RESTART WITH  1;');
    EXECUTE STATEMENT('ALTER SEQUENCE UNID_SEQ RESTART WITH  1;');
  END
END^
SET TERM ;^
