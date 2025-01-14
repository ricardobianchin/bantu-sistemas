/*
DROP PACKAGE VENDA_PDV_INS_PA;

in "C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Estoque\VENDA_PDV_INS_PA.sql";

SELECT *
FROM VENDA_PDV_INS_PA.PEGUE_ITEM(
    1 -- LOJA_ID
    , 1 -- TERMINAL_ID
    , NULL -- EST_MOV_ID

    , 1 -- SESS_LOJA_ID
    , 1 -- SESS_TERMINAL_ID
    , 3 -- SESS_ID
    , 1
    , '7869549490313'
   );

select * from prod where prod_id = 3;
select PROD_ID, DESCR_RED from prod where prod_id < 7;

select FIRST(5) * from prod_BARRAS;




SQL> select PROD_ID, DESCR_RED from prod where prod_id < 7;

     PROD_ID DESCR_RED
============ =============================
           2 CANETA P CELULA FASHIO MOBILE
           3 CANETA PARA CELULAR
           4 OTG CONECTION S-K07
           5 OTG GALAX TAB CONNE KIT S-K03
           6 ADAPTADOR DE CHIP NOOSY

SQL>
SQL>
SQL>
SQL> select FIRST(5) * from prod_BARRAS;

COD_BARRAS          PROD_ID
============== ============
8617627500060             2
7869549490313             3
7862052001816             4
4260113520673             5
7869549465311             6







-- VENDA_ITEM_INS CRIA ITEM PRIMEIRO

SELECT * FROM VENDA_PDV_INS_PA.VENDA_ITEM_INS
  (
    1 -- LOJA_ID ID_SHORT_DOM NOT NULL
    , 1 -- TERMINAL_ID ID_SHORT_DOM NOT NULL
    , NULL -- EST_MOV_ID BIGINT
    , NULL -- EST_MOV_ITEM_ORDEM SMALLINT
    , NULL -- VENDA_ID ID_DOM

    , 1 -- SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , 1 -- SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , 1 -- SESS_ID ID_DOM NOT NULL

    , 3 -- PROD_ID ID_DOM NOT NULL
    , 4 -- QTD QTD_DOM NOT NULL

    , 1 -- CUSTO_UNIT NUMERIC(12, 4) NOT NULL
    , 1 -- CUSTO NUMERIC(12,2) NOT NULL
    
    , 2 -- PRECO_UNIT_ORIGINAL NUMERIC(12, 2) NOT NULL
    , 2 -- PRECO_UNIT_PROMO NUMERIC(12, 2) NOT NULL
    , 2 -- PRECO_UNIT NUMERIC(12, 2) NOT NULL
    , 2 -- PRECO_BRUTO NUMERIC(12, 2) NOT NULL
    
    , 0 -- DESCONTO NUMERIC(12, 2) NOT NULL
    , 2 -- PRECO NUMERIC(12, 2) NOT NULL
    , 'TESTE PRIM' -- LOG_STR VARCHAR(200)
  );



-- VENDA_ITEM_INS CRIA ITEM SEGUNDO

SELECT * FROM VENDA_PDV_INS_PA.VENDA_ITEM_INS
  (
    1 -- LOJA_ID ID_SHORT_DOM NOT NULL
    , 1 -- TERMINAL_ID ID_SHORT_DOM NOT NULL
    , 1 -- EST_MOV_ID BIGINT
    , NULL -- EST_MOV_ITEM_ORDEM SMALLINT
    , 1 -- VENDA_ID ID_DOM

    , 1 -- SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , 1 -- SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , 1 -- SESS_ID ID_DOM NOT NULL

    , 3 -- PROD_ID ID_DOM NOT NULL
    , 4 -- QTD QTD_DOM NOT NULL

    , 1 -- CUSTO_UNIT NUMERIC(12, 4) NOT NULL
    , 1 -- CUSTO NUMERIC(12,2) NOT NULL
    
    , 2 -- PRECO_UNIT_ORIGINAL NUMERIC(12, 2) NOT NULL
    , 2 -- PRECO_UNIT_PROMO NUMERIC(12, 2) NOT NULL
    , 2 -- PRECO_UNIT NUMERIC(12, 2) NOT NULL
    , 2 -- PRECO_BRUTO NUMERIC(12, 2) NOT NULL
    
    , 0 -- DESCONTO NUMERIC(12, 2) NOT NULL
    , 2 -- PRECO NUMERIC(12, 2) NOT NULL
    , 'TESTE SEG' -- LOG_STR VARCHAR(200)
  );









DELETE FROM VENDA_ITEM;
DELETE FROM EST_MOV_ITEM;
DELETE FROM VENDA;
DELETE FROM EST_MOV;
COMMIT;
ALTER SEQUENCE VENDA_SEQ RESTART WITH 1;
ALTER SEQUENCE  EST_MOV_SEQ RESTART WITH 1;



---- EST_MOV
SELECT * FROM EST_MOV;

---- EST_MOV_ITEM
SELECT * FROM EST_MOV_ITEM;

---- VENDA_
SELECT * FROM VENDA;

---- VENDA_ITEM
SELECT * FROM VENDA_ITEM;

SELECT * FROM VENDA_PDV_INS_PA.BY_PROD_ID(2);

8617627500060             2
7869549490313             3

SELECT * FROM VENDA_PDV_INS_PA.BY_BARRAS('7869549490313');

in "C:\Pr\app\bantu\bantu-sis\Src\Externos\DBUpdates Complementos\Complementos\Estoque\VENDA_PDV_INS_PA.sql";


SELECT *
FROM VENDA_PDV_INS_PA.PEGUE_ITEM(
    1 -- LOJA_ID
    , 1 -- TERMINAL_ID
    , NULL -- EST_MOV_ID
    , NULL -- VENDA_ID
    , 1 -- SESS_LOJA_ID
    , 1 -- SESS_TERMINAL_ID
    , 1 -- SESS_ID
    , 1
    , '3'
   );


       EST_MOV_ID_RET EST_MOV_ITEM_ORDEM_RET VENDA_ID_RET      PROD_ID DESCR_RED                     FABR_NOME            UNID_SIGLA BAL_USO                 CUSTO                 PRECO ENCONTRADO MENSAGEM                                                                                             LOG_STR_RET                                                                                                                                                                            
===================== ====================== ============ ============ ============================= ==================== ========== ======= ===================== ===================== ========== ==================================================================================================== ========================================================================================================================================================================================================
                    1                      0            1            3 CANETA PARA CELULAR           PADRAO               PC               0                2.5000                 9.900 <true>                                                                                                          PROD_ID=3;VAI VENDA_ITEM_INS;EST_MOV_ID_RET=1;EST_MOV_ITEM_ORDEM_RET=0;VENDA_ID_RET=1     


SELECT *
FROM VENDA_PDV_INS_PA.PEGUE_ITEM(
    1 -- LOJA_ID
    , 1 -- TERMINAL_ID
    , 1 -- EST_MOV_ID
    , 1 -- VENDA_ID
    , 1 -- SESS_LOJA_ID
    , 1 -- SESS_TERMINAL_ID
    , 1 -- SESS_ID
    , 1
    , '3'
   );



       EST_MOV_ID_RET EST_MOV_ITEM_ORDEM_RET VENDA_ID_RET      PROD_ID DESCR_RED                     FABR_NOME            UNID_SIGLA BAL_USO                 CUSTO                 PRECO ENCONTRADO MENSAGEM                                                                                             LOG_STR_RET                                                                                                                                                                            
===================== ====================== ============ ============ ============================= ==================== ========== ======= ===================== ===================== ========== ==================================================================================================== ========================================================================================================================================================================================================
                    1                      1            1            3 CANETA PARA CELULAR           PADRAO               PC               0                2.5000                 9.900 <true>                                                                                                          PROD_ID=3;VAI VENDA_ITEM_INS;EST_MOV_ID_RET=1;EST_MOV_ITEM_ORDEM_RET=1;VENDA_ID_RET=1                                                                                                  
*/

SET TERM ^;
CREATE OR ALTER PACKAGE VENDA_PDV_INS_PA
AS
BEGIN
  PROCEDURE VENDA_INS
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL
    , VENDA_ID ID_DOM
    , SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
  )
  RETURNS
  (
    VENDA_ID_RET ID_DOM
  );
PROCEDURE VENDA_ITEM_INS
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT
    , VENDA_ID ID_DOM NOT NULL
    
    , SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
    
    , PROD_ID ID_DOM NOT NULL
    , QTD QTD_DOM NOT NULL
    
    , CUSTO_UNIT NUMERIC(12, 4) NOT NULL
    , CUSTO NUMERIC(12,2) NOT NULL
    
    , PRECO_UNIT_ORIGINAL NUMERIC(12, 2) NOT NULL
    , PRECO_UNIT_PROMO NUMERIC(12, 2) NOT NULL
    , PRECO_UNIT NUMERIC(12, 2) NOT NULL
    , PRECO_BRUTO NUMERIC(12, 2) NOT NULL
    
    , DESCONTO NUMERIC(12, 2) NOT NULL
    , PRECO NUMERIC(12, 2) NOT NULL
    , LOG_STR VARCHAR(200) NOT NULL
  )
  RETURNS
  (
    EST_MOV_ID_RET BIGINT
    , DTH_DOC_RET TIMESTAMP
    , EST_MOV_CRIADO_EM_RET TIMESTAMP
    
    , VENDA_ID_RET ID_DOM
    , ORDEM_RET SMALLINT
    , LOG_STR_RET VARCHAR(200)
  );
  PROCEDURE BY_PROD_ID
  (
    PROD_ID ID_DOM
  )
  RETURNS
  (
    PROD_ID_RET ID_DOM,
    DESCR_RED PROD_DESCR_RED_DOM,
    FABR_NOME NOME_REDU_DOM,
    UNID_SIGLA CHAR(6),
    BAL_USO SMALLINT,
    CUSTO_UNIT CUSTO_DOM,
    PRECO_UNIT PRECO_DOM,
    ENCONTRADO BOOLEAN,
    MENSAGEM VARCHAR(30)
  );
   PROCEDURE BY_BARRAS
  (
    STR_BUSCA VARCHAR(30)
  )
  RETURNS
  (
    PROD_ID_RET ID_DOM,
    DESCR_RED PROD_DESCR_RED_DOM,
    FABR_NOME NOME_REDU_DOM,
    UNID_SIGLA CHAR(6),
    BAL_USO SMALLINT,
    CUSTO_UNIT CUSTO_DOM,
    PRECO_UNIT PRECO_DOM,
    ENCONTRADO BOOLEAN,
    MENSAGEM VARCHAR(30)
  );
  
  PROCEDURE ITEM_PEGUE
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL
    , VENDA_ID ID_DOM NOT NULL
    , SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
    , PROD_ID ID_DOM NOT NULL
    , QTD QTD_DOM NOT NULL
    , CUSTO_UNIT NUMERIC(12, 4) NOT NULL
    , CUSTO CUSTO_DOM NOT NULL
    , PRECO_UNIT_ORIGINAL NUMERIC(12, 3) NOT NULL
    , PRECO_UNIT_PROMO NUMERIC(12, 3) NOT NULL
    , PRECO_UNIT NUMERIC(12, 3) NOT NULL
    , PRECO_BRUTO NUMERIC(12, 2) NOT NULL
    , DESCONTO NUMERIC(12, 2) NOT NULL
    , PRECO PRECO_DOM
    , LOG_STR VARCHAR(200)
  )
  RETURNS
  (
    EST_MOV_ID_RET BIGINT
    , ORDEM_RET SMALLINT
    , VENDA_ID_RET ID_DOM
    , DTH_DOC_RET TIMESTAMP
    , EST_MOV_CRIADO_EM_RET TIMESTAMP
    , MENSAGEM VARCHAR(30)
    , LOG_STR_RET VARCHAR(200)
  );

 PROCEDURE ITEM_BUSQUE
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL
    , VENDA_ID ID_DOM NOT NULL
    , SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
    , QTD QTD_DOM NOT NULL
    , STR_BUSCA VARCHAR(30)
  )
  RETURNS
  (
    EST_MOV_ID_RET BIGINT
    , ORDEM_RET SMALLINT
    , VENDA_ID_RET ID_DOM
    , DTH_DOC_RET TIMESTAMP
    , EST_MOV_CRIADO_EM_RET TIMESTAMP
    , PROD_ID ID_DOM
    , DESCR_RED PROD_DESCR_RED_DOM
    , FABR_NOME NOME_REDU_DOM
    , UNID_SIGLA CHAR(6)
    , BAL_USO SMALLINT
    , CUSTO_UNIT CUSTO_DOM
    , CUSTO CUSTO_DOM
    , PRECO_UNIT_ORIGINAL PRECO_DOM
    , PRECO_UNIT_PROMO PRECO_DOM
    , PRECO_UNIT PRECO_DOM
    , PRECO PRECO_DOM
    , ENCONTRADO BOOLEAN
    , MENSAGEM VARCHAR(30)
    , LOG_STR_RET VARCHAR(200)
  );
END^

--- BODY

RECREATE PACKAGE BODY VENDA_PDV_INS_PA
AS
BEGIN
  PROCEDURE VENDA_INS
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL
    , VENDA_ID ID_DOM
    , SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
  )
  RETURNS
  (
    VENDA_ID_RET ID_DOM
  )
  AS
  BEGIN
    :VENDA_ID_RET = COALESCE(:VENDA_ID, 0);
    IF (:VENDA_ID_RET = 0) THEN
    BEGIN
      :VENDA_ID_RET = NEXT VALUE FOR VENDA_SEQ;
      INSERT INTO VENDA
      (
        LOJA_ID
        , TERMINAL_ID
        , EST_MOV_ID
        , VENDA_ID
        , SESS_LOJA_ID
        , SESS_TERMINAL_ID
        , SESS_ID
      )
      VALUES
      (
        :LOJA_ID
        , :TERMINAL_ID
        , :EST_MOV_ID
        , :VENDA_ID_RET
        , :SESS_LOJA_ID
        , :SESS_TERMINAL_ID
        , :SESS_ID
      );
    END
    SUSPEND;
  END
  
  PROCEDURE VENDA_ITEM_INS
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT
    , VENDA_ID ID_DOM NOT NULL
    
    , SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
    
    , PROD_ID ID_DOM NOT NULL
    , QTD QTD_DOM NOT NULL
    
    , CUSTO_UNIT NUMERIC(12, 4) NOT NULL
    , CUSTO NUMERIC(12,2) NOT NULL
    
    , PRECO_UNIT_ORIGINAL NUMERIC(12, 2) NOT NULL
    , PRECO_UNIT_PROMO NUMERIC(12, 2) NOT NULL
    , PRECO_UNIT NUMERIC(12, 2) NOT NULL
    , PRECO_BRUTO NUMERIC(12, 2) NOT NULL
    
    , DESCONTO NUMERIC(12, 2) NOT NULL
    , PRECO NUMERIC(12, 2) NOT NULL
    , LOG_STR VARCHAR(200) NOT NULL
  )
  RETURNS
  (
    EST_MOV_ID_RET BIGINT
    , DTH_DOC_RET TIMESTAMP
    , EST_MOV_CRIADO_EM_RET TIMESTAMP
    
    , VENDA_ID_RET ID_DOM
    , ORDEM_RET SMALLINT
    , LOG_STR_RET VARCHAR(200)
  )
  AS
  BEGIN
    LOG_STR_RET = LOG_STR;
    SELECT EST_MOV_ID_RET, DTH_DOC_RET, EST_MOV_CRIADO_EM_RET, ORDEM_RET
    FROM EST_MOV_MANUT_PA.EST_MOV_ITEM_INS
    (
      :LOJA_ID
      , :TERMINAL_ID
      , :EST_MOV_ID
      , '"' -- EST_MOV_TIPO_ID #34 VENDA
      , '1.1.1900' -- EST_MOV_DTH_DOC
      , '1.1.1900' -- EST_MOV_CRIADO_EM
      , :PROD_ID
      , :QTD
    )
    INTO :EST_MOV_ID_RET, :DTH_DOC_RET, :EST_MOV_CRIADO_EM_RET, :ORDEM_RET;
    
    
    :LOG_STR_RET = :LOG_STR_RET ||';EST_MOV_ID_RET='||:EST_MOV_ID_RET;
    :LOG_STR_RET = :LOG_STR_RET ||';ORDEM_RET='||:ORDEM_RET;
    SELECT VENDA_ID_RET FROM VENDA_INS
    (
      :LOJA_ID
      , :TERMINAL_ID
      , :EST_MOV_ID_RET
      , :VENDA_ID
      , :SESS_LOJA_ID
      , :SESS_TERMINAL_ID
      , :SESS_ID
    )
    INTO :VENDA_ID_RET;
    :LOG_STR_RET = :LOG_STR_RET ||';VENDA_ID_RET='||:VENDA_ID_RET;
    INSERT INTO VENDA_ITEM
    (
      LOJA_ID
      , TERMINAL_ID
      , EST_MOV_ID
      , ORDEM
      , CUSTO_UNIT
      , CUSTO
      , PRECO_UNIT_ORIGINAL
      , PRECO_UNIT_PROMO
      , PRECO_UNIT
      , PRECO_BRUTO
      , DESCONTO
      , PRECO
    )
    VALUES
    (
      :LOJA_ID
      , :TERMINAL_ID
      , :EST_MOV_ID_RET
      , :ORDEM_RET
      , :CUSTO_UNIT
      , :CUSTO
      , :PRECO_UNIT_ORIGINAL
      , :PRECO_UNIT_PROMO
      , :PRECO_UNIT
      , :PRECO_BRUTO
      , :DESCONTO
      , :PRECO
    );
    SUSPEND;
  END
  PROCEDURE BY_PROD_ID
  (
    PROD_ID ID_DOM
  )
  RETURNS
  (
    PROD_ID_RET ID_DOM,
    DESCR_RED PROD_DESCR_RED_DOM,
    FABR_NOME NOME_REDU_DOM,
    UNID_SIGLA CHAR(6),
    BAL_USO SMALLINT,
    CUSTO_UNIT CUSTO_DOM,
    PRECO_UNIT PRECO_DOM,
    ENCONTRADO BOOLEAN,
    MENSAGEM VARCHAR(30)
  )
  AS
  BEGIN
    SELECT
      P.PROD_ID,
      P.DESCR_RED,
      P.FABR_NOME,
      P.UNID_SIGLA,
      P.BAL_USO,
      P.CUSTO,
      P.PRECO,
      TRUE AS ENCONTRADO,
      'CODIGO ENCONTRADO' AS MENSAGEM
    FROM
      PROD P
    WHERE
      P.PROD_ID = :PROD_ID
      AND (NOT P.DE_SISTEMA) AND P.ATIVO
    INTO
      :PROD_ID_RET,
      :DESCR_RED,
      :FABR_NOME,
      :UNID_SIGLA,
      :BAL_USO,
      :CUSTO_UNIT,
      :PRECO_UNIT,
      :ENCONTRADO,
      :MENSAGEM
      ;
    IF (ROW_COUNT = 0) THEN
    BEGIN
        :ENCONTRADO = FALSE;
        :MENSAGEM = 'CODIGO NAO ENCONTRADO';
    END
    SUSPEND;
  END
  
  PROCEDURE BY_BARRAS
  (
    STR_BUSCA VARCHAR(30)
  )
  RETURNS
  (
    PROD_ID_RET ID_DOM,
    DESCR_RED PROD_DESCR_RED_DOM,
    FABR_NOME NOME_REDU_DOM,
    UNID_SIGLA CHAR(6),
    BAL_USO SMALLINT,
    CUSTO_UNIT CUSTO_DOM,
    PRECO_UNIT PRECO_DOM,
    ENCONTRADO BOOLEAN,
    MENSAGEM VARCHAR(30)
  )
  AS
  BEGIN
    SELECT
      P.PROD_ID,
      P.DESCR_RED,
      P.FABR_NOME,
      P.UNID_SIGLA,
      P.BAL_USO,
      P.CUSTO,
      P.PRECO,
      TRUE AS ENCONTRADO,
      'CODIGO ENCONTRADO' AS MENSAGEM
    FROM
      PROD P
    JOIN
      PROD_BARRAS PB ON P.PROD_ID = PB.PROD_ID
    WHERE
      PB.COD_BARRAS = :STR_BUSCA
      AND (NOT P.DE_SISTEMA) AND P.ATIVO
    INTO
      :PROD_ID_RET,
      :DESCR_RED,
      :FABR_NOME,
      :UNID_SIGLA,
      :BAL_USO,
      :CUSTO_UNIT,
      :PRECO_UNIT,
      :ENCONTRADO,
      :MENSAGEM
      ;
    IF (ROW_COUNT = 0) THEN
    BEGIN
        ENCONTRADO = FALSE;
        MENSAGEM = 'CODIGO NAO ENCONTRADO';
    END
    SUSPEND;
  END

  PROCEDURE ITEM_PEGUE
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL
    , VENDA_ID ID_DOM NOT NULL
    , SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
    , PROD_ID ID_DOM NOT NULL
    , QTD QTD_DOM NOT NULL
    , CUSTO_UNIT NUMERIC(12, 4) NOT NULL
    , CUSTO CUSTO_DOM NOT NULL
    , PRECO_UNIT_ORIGINAL NUMERIC(12, 3) NOT NULL
    , PRECO_UNIT_PROMO NUMERIC(12, 3) NOT NULL
    , PRECO_UNIT NUMERIC(12, 3) NOT NULL
    , PRECO_BRUTO NUMERIC(12, 2) NOT NULL
    , DESCONTO NUMERIC(12, 2) NOT NULL
    , PRECO PRECO_DOM
    , LOG_STR VARCHAR(200)
  )
  RETURNS
  (
    EST_MOV_ID_RET BIGINT
    , ORDEM_RET SMALLINT
    , VENDA_ID_RET ID_DOM
    , DTH_DOC_RET TIMESTAMP
    , EST_MOV_CRIADO_EM_RET TIMESTAMP
    , MENSAGEM VARCHAR(30)
    , LOG_STR_RET VARCHAR(200)
  )
  AS
  BEGIN
    :LOG_STR_RET = :LOG_STR || ';VAI VENDA_ITEM_INS';
    SELECT
      EST_MOV_ID_RET, DTH_DOC_RET, EST_MOV_CRIADO_EM_RET
      , VENDA_ID_RET, ORDEM_RET, LOG_STR_RET
    FROM
      VENDA_ITEM_INS
    (
      :LOJA_ID
      , :TERMINAL_ID
      , :EST_MOV_ID
      , :VENDA_ID
      , :SESS_LOJA_ID
      , :SESS_TERMINAL_ID
      , :SESS_ID
      , :PROD_ID
      , :QTD
      , :CUSTO_UNIT
      , :CUSTO
      , :PRECO_UNIT_ORIGINAL
      , :PRECO_UNIT_PROMO
      , :PRECO_UNIT
      , :PRECO_BRUTO
      , :DESCONTO
      , :PRECO
      , :LOG_STR
    )
    INTO 
      :EST_MOV_ID_RET
      , :DTH_DOC_RET
      , :EST_MOV_CRIADO_EM_RET
      , :VENDA_ID_RET
      , :ORDEM_RET
      , :LOG_STR_RET
      ;      
    SUSPEND;
  END   
  
  PROCEDURE ITEM_BUSQUE
  (
    LOJA_ID ID_SHORT_DOM NOT NULL
    , TERMINAL_ID ID_SHORT_DOM NOT NULL
    , EST_MOV_ID BIGINT NOT NULL
    , VENDA_ID ID_DOM NOT NULL
    , SESS_LOJA_ID ID_SHORT_DOM NOT NULL
    , SESS_TERMINAL_ID ID_SHORT_DOM NOT NULL
    , SESS_ID ID_DOM NOT NULL
    , QTD QTD_DOM NOT NULL
    , STR_BUSCA VARCHAR(30)
  )
  RETURNS
  (
    EST_MOV_ID_RET BIGINT
    , ORDEM_RET SMALLINT
    , VENDA_ID_RET ID_DOM
    , DTH_DOC_RET TIMESTAMP
    , EST_MOV_CRIADO_EM_RET TIMESTAMP
    , PROD_ID ID_DOM
    , DESCR_RED PROD_DESCR_RED_DOM
    , FABR_NOME NOME_REDU_DOM
    , UNID_SIGLA CHAR(6)
    , BAL_USO SMALLINT
    , CUSTO_UNIT CUSTO_DOM
    , CUSTO CUSTO_DOM
    , PRECO_UNIT_ORIGINAL PRECO_DOM
    , PRECO_UNIT_PROMO PRECO_DOM
    , PRECO_UNIT PRECO_DOM
    , PRECO PRECO_DOM
    , ENCONTRADO BOOLEAN
    , MENSAGEM VARCHAR(30)
    , LOG_STR_RET VARCHAR(200)
  )
  AS
  /*
    DECLARE CUSTO_UNIT NUMERIC(12, 4);
    DECLARE PRECO_UNIT_ORIGINAL NUMERIC(12, 3);
    DECLARE PRECO_UNIT_PROMO NUMERIC(12, 3);
    DECLARE PRECO_UNIT NUMERIC(12, 3);
    */
    DECLARE PRECO_BRUTO NUMERIC(12, 2);
    DECLARE DESCONTO NUMERIC(12, 2);
  BEGIN
    IF (CHARACTER_LENGTH (:STR_BUSCA) < 8) THEN
    BEGIN
      SELECT PROD_ID_RET, DESCR_RED, FABR_NOME, UNID_SIGLA, BAL_USO,
        CUSTO_UNIT, PRECO_UNIT, ENCONTRADO, MENSAGEM
      FROM BY_PROD_ID(CAST(:STR_BUSCA AS ID_DOM))
      INTO :PROD_ID, :DESCR_RED, :FABR_NOME, :UNID_SIGLA, :BAL_USO,
        :CUSTO_UNIT, :PRECO_UNIT, :ENCONTRADO, :MENSAGEM;
    END
    ELSE
    BEGIN
      SELECT PROD_ID_RET, DESCR_RED, FABR_NOME, UNID_SIGLA, BAL_USO,
        CUSTO_UNIT, PRECO_UNIT, ENCONTRADO, MENSAGEM
      FROM BY_BARRAS(:STR_BUSCA)
      INTO PROD_ID, :DESCR_RED, :FABR_NOME, :UNID_SIGLA, :BAL_USO,
        :CUSTO_UNIT, :PRECO_UNIT, :ENCONTRADO, :MENSAGEM;
    END
    LOG_STR_RET = 'PROD_ID=' || CAST(PROD_ID AS VARCHAR(7));
    IF (:BAL_USO = 0 AND :ENCONTRADO) THEN
    BEGIN
      :CUSTO = ROUND(:CUSTO_UNIT * :QTD, 2);
      :PRECO_UNIT_ORIGINAL = :PRECO_UNIT;
      :PRECO_UNIT_PROMO = 0;
      :PRECO_BRUTO = ROUND(:PRECO_UNIT * :QTD, 2);
      :DESCONTO = 0;
      :PRECO = :PRECO_BRUTO - :DESCONTO;
      :LOG_STR_RET = :LOG_STR_RET || ';VAI ITEM_PEGUE';
      
      SELECT
        EST_MOV_ID_RET
        , ORDEM_RET
        , VENDA_ID_RET
        , DTH_DOC_RET
        , EST_MOV_CRIADO_EM_RET
        , MENSAGEM
        , LOG_STR_RET
      FROM 
        ITEM_PEGUE
      (
        :LOJA_ID
        , :TERMINAL_ID
        , :EST_MOV_ID
        , :VENDA_ID
        , :SESS_LOJA_ID
        , :SESS_TERMINAL_ID
        , :SESS_ID
        , :PROD_ID
        , :QTD
        , :CUSTO_UNIT
        , :CUSTO
        , :PRECO_UNIT_ORIGINAL
        , :PRECO_UNIT_PROMO
        , :PRECO_UNIT
        , :PRECO_BRUTO
        , :DESCONTO
        , :PRECO
        , :LOG_STR_RET
      )
      INTO
        :EST_MOV_ID_RET
        , :ORDEM_RET
        , :VENDA_ID_RET
        , :DTH_DOC_RET
        , :EST_MOV_CRIADO_EM_RET
        , :MENSAGEM
        , LOG_STR_RET
        ;
      
/*      SELECT EST_MOV_ID_RET, DTH_DOC_RET, EST_MOV_CRIADO_EM_RET
        , VENDA_ID_RET, ORDEM_RET, LOG_STR_RET
      FROM VENDA_ITEM_INS
      (
        :LOJA_ID
        , :TERMINAL_ID
        , :EST_MOV_ID
        , :VENDA_ID
        , :SESS_LOJA_ID
        , :SESS_TERMINAL_ID
        , :SESS_ID
        , :PROD_ID
        , :QTD
        , :CUSTO_UNIT
        , :CUSTO
        , :PRECO_UNIT_ORIGINAL
        , :PRECO_UNIT_PROMO
        , :PRECO_UNIT
        , :PRECO_BRUTO
        , :DESCONTO
        , :PRECO
        , :LOG_STR_RET
      )
      INTO 
        :EST_MOV_ID_RET
        , :DTH_DOC_RET
        , :EST_MOV_CRIADO_EM_RET
        , :VENDA_ID_RET
        , :ORDEM_RET
        , :LOG_STR_RET
        ;      */
    END
    SUSPEND;
  END
END^
SET TERM ;^
