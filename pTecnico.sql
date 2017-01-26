CREATE OR REPLACE PACKAGE pTecnico IS
  --
  PROCEDURE inserir (pisNome              tecnico.nome%TYPE,
                     pidDataDeNascimento  tecnico.dt_nascimento%TYPE,
                     pinSalario           tecnico.salario%TYPE,
                     pinIdTime            tecnico.id_time%TYPE);
  --
  PROCEDURE alterar (pinId                tecnico.ID_TECNICO%TYPE,
                     pisNome              tecnico.nome%TYPE,
                     pidDataDeNascimento  tecnico.dt_nascimento%TYPE,
                     pinSalario           tecnico.salario%TYPE,
                     pinIdTime            tecnico.id_time%TYPE);
  --
  PROCEDURE remover (pinId                tecnico.ID_TECNICO%TYPE);
  --
END;

CREATE OR REPLACE PACKAGE BODY pTecnico IS

  PROCEDURE inserir
  (
    --
    pisNome              tecnico.nome%TYPE,
    pidDataDeNascimento  tecnico.dt_nascimento%TYPE,
    pinSalario           tecnico.salario%TYPE,
    pinIdTime            tecnico.id_time%TYPE
    --
  ) AS
    --
    viContTecnico NUMBER;
    viContTime    NUMBER;
    --
  BEGIN
    --
    SELECT COUNT(1)
      INTO viContTime
      FROM time t
     WHERE t.ID_TIME = pinIdTime;
    --
    IF viContTime > 0 THEN
      --
      IF TRIM(pisNome) IS NULL THEN
        --
        DBMS_OUTPUT.PUT_LINE('NOME NÃO PODE SER VAZIO OU NULO.');
        --
      ELSIF pidDataDeNascimento > SYSDATE OR pidDataDeNascimento IS NULL THEN
        --
        DBMS_OUTPUT.PUT_LINE('DATA DE NASCIMENTO NÃO PODE SER MAIOR QUE A DATA ATUAL OU NULA.');
        --
      ELSIF pinIdTime < 0 OR pinIdTime IS NULL THEN
        --
        DBMS_OUTPUT.PUT_LINE('NUMERO DO TIME NÃO PODE SE NULO, NEGATIVO OU ZERO.');
        --
      ELSE
        --
        SELECT COUNT(1)
          INTO viContTecnico
          FROM TECNICO t
         WHERE t.NOME = pisNome
           AND t.ID_TIME = pinIdTime;
        --
        IF viContTecnico = 0 THEN
          --
          INSERT INTO TECNICO (ID_TECNICO, NOME, DT_NASCIMENTO, SALARIO, ID_TIME)
                       VALUES (SEQ_TECNICO.nextval, pisNome, pidDataDeNascimento, pinSalario, pinIdTime);
          --
          DBMS_OUTPUT.PUT_LINE('REGISTRO SALVO COM SUCESSO.');
          --
        ELSE
          --
          DBMS_OUTPUT.PUT_LINE('JA EXISTE UM REGISTRO COM ESSE NOME E TIME CADASTRADO.');
          --
        END IF;
        --
      END IF;
      --
    ELSE
      --
      DBMS_OUTPUT.PUT_LINE('O TIME INFORMADO NÃO EXISTE.');
      --
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: OTHERS [' || SQLERRM || ']');
    --
  END;
  ------------------------------------------------------------------------------------------------------------
  PROCEDURE alterar
  (
    pinId                TECNICO.ID_TECNICO%TYPE,
    pisNome              TECNICO.nome%TYPE,
    pidDataDeNascimento  TECNICO.dt_nascimento%TYPE,
    pinSalario           TECNICO.salario%TYPE,
    pinIdTime            TECNICO.id_time%TYPE
  )AS
    --
    viContTecnico NUMBER;
    viContTime    NUMBER;
    --
  BEGIN
    --
    SELECT COUNT(1)
      INTO viContTime
      FROM time t
     WHERE t.ID_TIME = pinIdTime;
    --
    IF viContTime > 0 THEN
      --
      IF TRIM(pisNome) IS NULL THEN
        --
        DBMS_OUTPUT.PUT_LINE('NOME NÃO PODE SER VAZIO OU NULO.');
        --
      ELSIF pidDataDeNascimento > SYSDATE OR pidDataDeNascimento IS NULL THEN
        --
        DBMS_OUTPUT.PUT_LINE('DATA DE NASCIMENTO NÃO PODE SER MAIOR QUE A DATA ATUAL OU NULA.');
        --
      ELSIF pinIdTime < 0 OR pinIdTime IS NULL THEN
        --
        DBMS_OUTPUT.PUT_LINE('NUMERO DO TIME NÃO PODE SE NULO, NEGATIVO OU ZERO.');
        --
      ELSE
        --
        SELECT COUNT(1)
          INTO viContTecnico
          FROM TECNICO t
         WHERE t.ID_TECNICO = pinId;
        --
        IF viContTecnico = 1 THEN
          --
          UPDATE TECNICO T
            SET NOME          = pisNome,
                DT_NASCIMENTO = pidDataDeNascimento,
                SALARIO       = pinSalario,
                ID_TIME       = pinIdTime
          WHERE T.ID_TECNICO  = pinId;
          --
          DBMS_OUTPUT.PUT_LINE('REGISTRO ALTERADO COM SUCESSO.');
          --
        ELSE
          --
          DBMS_OUTPUT.PUT_LINE('ERRO AO LOCALIZAR O TECNICO.');
          --
        END IF;
        --
      END IF;
      --
    ELSE
      --
      DBMS_OUTPUT.PUT_LINE('O TIME INFORMADO NÃO EXISTE.');
      --
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: OTHERS [' || SQLERRM || ']');
    --
  END;
  ------------------------------------------------------------------------------------------------------------
  PROCEDURE remover
  (
    --
    pinId TECNICO.ID_TECNICO%TYPE
    --
  )AS
    --
    vnContTime        NUMBER;
    vnContTecnico NUMBER;
    --
  BEGIN
    --
    SELECT COUNT(1)
      INTO vnContTecnico
      FROM TECNICO t
     WHERE t.ID_TECNICO = pinId;
    --
    IF vnContTecnico = 1 THEN
      --
      DELETE TECNICO t
       WHERE t.ID_TECNICO = pinId;
      --
      DBMS_OUTPUT.PUT_LINE('TECNICO REMOVIDO COM SUCESSO');
      --
    ELSE
      --
      DBMS_OUTPUT.PUT_LINE('NÃO EXISTE UM TECNICO COM ESSE ID CADASTRADO.');
      --
    END IF;
    --
  EXCEPTION
    WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: OTHERS' || SQLERRM);
    --
  END;
  --
END;