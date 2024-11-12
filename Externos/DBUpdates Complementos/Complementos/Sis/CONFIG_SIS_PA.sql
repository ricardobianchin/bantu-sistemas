SET TERM ^;
CREATE OR ALTER PACKAGE CONFIG_SIS_PA
AS
BEGIN
  PROCEDURE GARANTIR
  (
    CHAVE VARCHAR(89) NOT NULL, 
    VALOR VARCHAR(144)
  );

  FUNCTION VALOR_GET
  (
    CHAVE VARCHAR(89),
    VALOR_DEFAULT VARCHAR(144) DEFAULT NULL
  ) RETURNS VARCHAR(144);
END^

RECREATE PACKAGE BODY CONFIG_SIS_PA
AS
BEGIN
  PROCEDURE GARANTIR
  (
    CHAVE VARCHAR(89) NOT NULL, 
    VALOR VARCHAR(144)
  )
  AS
  BEGIN
    UPDATE OR INSERT INTO CONFIG_SIS (CHAVE, VALOR)
    VALUES (:CHAVE, :VALOR)
    MATCHING (CHAVE);
  END
  
  FUNCTION VALOR_GET
  (
    CHAVE VARCHAR(89),
    VALOR_DEFAULT VARCHAR(144)-- DEFAULT NULL
  ) RETURNS VARCHAR(144) 
  AS
    DECLARE VARIABLE VALOR_RET VARCHAR(144);
  BEGIN
    SELECT VALOR 
    FROM CONFIG_SIS 
    WHERE CHAVE = :CHAVE 
    INTO :VALOR_RET;

    IF (VALOR_RET IS NULL) THEN
    BEGIN
      IF (VALOR_DEFAULT IS NOT NULL) THEN
      BEGIN
        EXECUTE PROCEDURE GARANTIR(:CHAVE, :VALOR_DEFAULT);
        VALOR_RET = :VALOR_DEFAULT;
      END
    END

    RETURN VALOR_RET;
  END
END^
SET TERM ;^
