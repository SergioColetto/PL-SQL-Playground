CREATE OR REPLACE PACKAGE pValidacao AS

  FUNCTION validarCampoObrigatorioString(pisValor VARCHAR2)
  RETURN BOOLEAN;

  FUNCTION validarCampoObrigatorioNumber(pinValor NUMBER)
  RETURN BOOLEAN;

  FUNCTION validarCampoObrigatorioDate(pidValor DATE)
  RETURN BOOLEAN;

  FUNCTION validarTimeExistente(pinValor NUMBER)
  RETURN BOOLEAN;

  FUNCTION validarJogadorExistente(pinValor NUMBER)
  RETURN BOOLEAN;

  FUNCTION validarJogoExistente(pinValor NUMBER)
  RETURN BOOLEAN;

  FUNCTION validarCartaoExistente(pinValor NUMBER)
  RETURN BOOLEAN;

END;

----------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pValidacao AS

  FUNCTION validarCampoObrigatorioString (pisValor VARCHAR2)
  RETURN BOOLEAN AS
  BEGIN
    --
    IF pisValor IS NULL THEN
      --
      RETURN FALSE;
      --
    ELSIF TRIM(pisValor) IS NULL THEN
      --
      RETURN FALSE;
      --
    ELSE
      --
      RETURN TRUE;
      --
    END IF;
    --
  EXCEPTION
  WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: [' || SQLERRM || ']');
    --
  END;

  FUNCTION validarCampoObrigatorioNumber (pinValor NUMBER)
  RETURN BOOLEAN AS
  BEGIN
    --
    IF pinValor IS NULL OR pinValor <= 0 THEN
      --
      RETURN FALSE;
      --
    ELSIF TRIM(pinValor) IS NULL THEN
      --
      RETURN FALSE;
      --
    ELSE
      --
      RETURN TRUE;
      --
    END IF;
    --
  EXCEPTION
  WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: [' || SQLERRM || ']');
    --
  END;

  FUNCTION validarCampoObrigatorioDate(pidValor DATE)
  RETURN BOOLEAN AS
  BEGIN
    --
    IF pidValor IS NULL THEN
      --
      RETURN FALSE;
      --
    ELSIF pidValor >= SYSDATE THEN
      --
      RETURN FALSE;
      --
    ELSE
      --
      RETURN TRUE;
      --
    END IF;
    --
  EXCEPTION
  WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: [' || SQLERRM || ']');
    --
  END;



  FUNCTION ValidarTimeExistente(pinValor NUMBER)
  RETURN BOOLEAN AS
    --
    pnCountTime NUMBER;
    --
  BEGIN
    --
    SELECT COUNT(1)INTO pnCountTime
      FROM time
     WHERE id_time = pinValor;
     --
    IF pinValor IS NULL THEN
      --
      RETURN FALSE;
      --
    ELSIF pnCountTime = 0 THEN
      --
      RETURN FALSE;
      --
    ELSE
      --
      RETURN TRUE;
      --
    END IF;

  EXCEPTION
  WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: [' || SQLERRM || ']');
    --
  END;

  FUNCTION validarJogadorExistente(pinValor NUMBER)
  RETURN BOOLEAN AS
    --
    pnCountJogador NUMBER;
    --
  BEGIN
    --
    SELECT COUNT(1)INTO pnCountJogador
      FROM jogador
     WHERE id_jogador = pinValor;
    --
    IF pinValor IS NULL THEN
      --
      RETURN FALSE;
      --
    ELSIF pnCountJogador =0 THEN
      --
      RETURN FALSE;
      --
    ELSE
      --
      RETURN TRUE;
      --
    END IF;
    --
  EXCEPTION
  WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: [' || SQLERRM || ']');
    --
  END;

  FUNCTION validarJogoExistente (pinValor NUMBER)
  RETURN BOOLEAN AS
    --
    vinJogo NUMBER;
    --
  BEGIN
    --
    SELECT COUNT(1)
      INTO vinJogo
      FROM jogo j
     WHERE pinValor IS NOT NULL
           AND j.id_jogo = pinValor;
    --
    IF vinJogo <= 0 THEN
      --
      RETURN FALSE;
      --
    ELSE
      --
      RETURN TRUE;
      --
    END IF;
    --
  EXCEPTION
  WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: [' || SQLERRM || ']');
    --
  END;

  FUNCTION validarCartaoExistente(pinValor NUMBER)
  RETURN BOOLEAN AS
    --
    vnCartao cartao.id_cartao%TYPE;
    --
  BEGIN
    --
    SELECT COUNT(1)
      INTO vnCartao
      FROM cartao c
     WHERE C.ID_CARTAO = pinVALOR;
    --
    IF VNCARTAO = 1 THEN
      --
      RETURN TRUE;
      --
    ELSE
      --
      RETURN FALSE;
      --
    END IF;
    --
  EXCEPTION
  WHEN OTHERS THEN
  --
    DBMS_OUTPUT.PUT_LINE('ERRO: [' || SQLERRM || ']');
  --
  END;

END;