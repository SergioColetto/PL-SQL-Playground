CREATE OR REPLACE PACKAGE pTime IS

  PROCEDURE inserir(pisNome time.nome%TYPE);

  PROCEDURE alterar(pinId time.id_time%TYPE, pisNome time.nome%TYPE);

  PROCEDURE remover(pinId time.ID_TIME%TYPE);

END;

CREATE OR REPLACE PACKAGE BODY pTime IS

  PROCEDURE inserir
  (
    pisNome time.nome%TYPE
  )AS
    --
    vnContTime NUMBER;
    --
  BEGIN

    IF trim(pisNome) IS NULL THEN
      --
      DBMS_OUTPUT.PUT_LINE('NOME DO TIME NÃO PODE TER NOME VAZIO OU NULO.');
      --
    ELSE
      --
      SELECT COUNT(1)
        INTO vnContTime
        FROM time t
       WHERE t.nome = pisNome;

      IF vnContTime = 0 THEN
        --
        INSERT INTO time (ID_TIME, NOME)
                  VALUES (SEQ_TIME.nextval,pisNome);
        --
        DBMS_OUTPUT.PUT_LINE('TIME SALVO COM SUCESSO.');
        --
      ELSE
        --
        DBMS_OUTPUT.PUT_LINE('JA EXISTE UM TIME COM ESSE NOME CADASTRADO.');
        --
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: OTHERS' || SQLERRM);
    --
  END;
  ------------------------------------------------------------------------------------------------------------

  PROCEDURE alterar
  (
    --
    pinId   time.id_time%TYPE,
    pisNome time.NOME%TYPE
    --
  )AS
    --
    vnContTime NUMBER;
    --
  BEGIN
    --
    IF trim(pisNome) IS NULL THEN
      --
      DBMS_OUTPUT.PUT_LINE('NOME DO TIME NÃO PODE TER NOME VAZIO OU NULO.');
      --
    ELSE
      --
      SELECT COUNT(1)
        INTO vnContTime
        FROM time t
       WHERE t.ID_TIME = pinId;

      IF vnContTime = 1 THEN
        --
        UPDATE time t
           SET t.NOME = pisNome
         WHERE t.ID_TIME = pinId;
        --
        DBMS_OUTPUT.PUT_LINE('TIME ATUALIZADO COM SUCESSO');
        --
      ELSIF vnContTime = 0 THEN
        --
        DBMS_OUTPUT.PUT_LINE('NÃO EXISTE UM TIME COM ESSE ID CADASTRADO.');
        --
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: OTHERS' || SQLERRM);
    --
  END;
  ------------------------------------------------------------------------------------------------------------
  PROCEDURE remover
  (
    --
    pinId time.ID_TIME%TYPE
    --
  )AS
    --
    vnContTime        NUMBER;
    vnContTimeJogador NUMBER;
    vnContTimeTecnico NUMBER;
    --
  BEGIN
    --
    SELECT count(1)
      INTO vnContTime
      FROM TIME t
     WHERE t.ID_TIME = pinId;
    --
    IF vnContTime = 1 THEN
      --
      SELECT count(1)
        INTO vnContTimeJogador
        FROM jogador j
       WHERE j.ID_TIME = pinId;
      --
      SELECT count(1)
        INTO vnContTimeTecnico
        FROM TECNICO t
       WHERE t.ID_TIME = pinId;
      --
      IF vnContTimeJogador = 0 AND vnContTimeTecnico = 0 THEN
        --
        DELETE time t
         WHERE t.ID_TIME = pinId;
        --
        DBMS_OUTPUT.PUT_LINE('TIME REMOVIDO COM SUCESSO');
        --
      ELSE
        --
        DBMS_OUTPUT.PUT_LINE('O TIME NÃO PODE SER REMOVIDO PORQUE EXITE JOGADORES OU TECNICO LIGADO A ELE.');
        --
      END IF ;
      --
    ELSE
      --
      DBMS_OUTPUT.PUT_LINE('NÃO EXISTE UM TIME COM ESSE ID CADASTRADO.');
      --
    END IF;
    --
  EXCEPTION
    WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: OTHERS' || SQLERRM);
    --
  END;

END;