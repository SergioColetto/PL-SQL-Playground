CREATE OR REPLACE PACKAGE pJogador IS
  --
  PROCEDURE inserir (pisNome              jogador.nome%TYPE,
                     pidDataDeNascimento  jogador.dt_nascimento%TYPE,
                     pinSalario           jogador.salario%TYPE,
                     pinIdTime            jogador.id_time%TYPE);
  --
  PROCEDURE alterar (pinId                jogador.id_jogador%TYPE,
                     pisNome              jogador.nome%TYPE,
                     pidDataDeNascimento  jogador.dt_nascimento%TYPE,
                     pinSalario           jogador.salario%TYPE,
                     pinIdTime            jogador.id_time%TYPE);
  --
  PROCEDURE remover (pinId                jogador.id_jogador%TYPE);
  --
  PROCEDURE escalaJogador(pinJogo    jogo.id_jogo%TYPE,
                        pinJogador jogador.id_jogador%TYPE);
  --
END;

--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pJogador IS

  PROCEDURE inserir
  (
    --
    pisNome              jogador.nome%TYPE,
    pidDataDeNascimento  jogador.dt_nascimento%TYPE,
    pinSalario           jogador.salario%TYPE,
    pinIdTime            jogador.id_time%TYPE
    --
  ) AS
    --
    viContJogador NUMBER;
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
          INTO viContJogador
          FROM jogador j
         WHERE j.nome = pisNome
           AND j.ID_TIME = pinIdTime;
        --
        IF viContJogador = 0 THEN
          --
          INSERT INTO jogador (ID_JOGADOR, NOME, DT_NASCIMENTO, SALARIO, ID_TIME)
                       VALUES (SEQ_JOGADOR.nextval, pisNome, pidDataDeNascimento, pinSalario, pinIdTime);
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
  ------------------------------------------------------------------------------
  PROCEDURE alterar
  (
    pinId                jogador.id_jogador%TYPE,
    pisNome              jogador.nome%TYPE,
    pidDataDeNascimento  jogador.dt_nascimento%TYPE,
    pinSalario           jogador.salario%TYPE,
    pinIdTime            jogador.id_time%TYPE
  )AS
    --
    viContJogador NUMBER;
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
          INTO viContJogador
          FROM jogador j
         WHERE j.ID_JOGADOR = pinId;
        --
        IF viContJogador = 1 THEN
          --
          UPDATE JOGADOR J
            SET NOME          = pisNome,
                DT_NASCIMENTO = pidDataDeNascimento,
                SALARIO       = pinSalario,
                ID_TIME       = pinIdTime
          WHERE J.ID_JOGADOR  = pinId;
          --
          DBMS_OUTPUT.PUT_LINE('REGISTRO ALTERADO COM SUCESSO.');
          --
        ELSE
          --
          DBMS_OUTPUT.PUT_LINE('ERRO AO LOCALIZAR O JOGADOR.');
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
  ------------------------------------------------------------------------------
  PROCEDURE remover
  (
    --
    pinId jogador.id_jogador%TYPE
    --
  )AS
    --
    vnContTime        NUMBER;
    vnContJogador NUMBER;
    --
  BEGIN
    --
    SELECT count(1)
      INTO vnContJogador
      FROM JOGADOR j
     WHERE j.ID_JOGADOR = pinId;
    --
    IF vnContJogador = 1 THEN
      --
      DELETE JOGADOR J
       WHERE J.ID_JOGADOR = pinId;
      --
      DBMS_OUTPUT.PUT_LINE('jogador REMOVIDO COM SUCESSO');
      --
    ELSE
      --
      DBMS_OUTPUT.PUT_LINE('NÃO EXISTE UM JOGADOR COM ESSE ID CADASTRADO.');
      --
    END IF;
    --
  EXCEPTION
    WHEN OTHERS THEN
    --
    DBMS_OUTPUT.PUT_LINE('ERRO: OTHERS' || SQLERRM);
    --
  END;
  ------------------------------------------------------------------------------
  PROCEDURE escalaJogador(
    --
    pinJogo IN jogo.id_jogo%TYPE,
    pinJogador IN jogador.id_jogador%TYPE
    --
  ) AS
    --
    vnJogo NUMBER;
    vnJogador NUMBER;
    --
  BEGIN
    --
    SELECT COUNT(1)
      INTO vnJogo
      FROM jogo j
     WHERE j.id_jogo = pinJogo;
    --
    SELECT COUNT(1)
      INTO vnJogador
      FROM jogador j
     WHERE j.id_jogador = pinJogador;
    --
    IF vnJogo = 0 THEN
      --
      DBMS_OUTPUT.PUT_LINE('Código do Jogo Inválido');
      --
    ELSIF vnJogador = 0 THEN
      --
      DBMS_OUTPUT.PUT_LINE('Código do Jogador Inválido');
      --
    ELSE
      --
      INSERT INTO JOGO_JOGADOR (id_jogo_jogador, id_jogo, id_jogador)
                        VALUES (seq_jogo_jogador.nextval, pinJogo, pinJogador);
      --
      DBMS_OUTPUT.PUT_LINE('Escalação salva com sucesso');
      --
    END IF;
    --
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      DBMS_OUTPUT.PUT_LINE('Escalação já realizada.');
      --
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro ao escalar jogador. ' || SQLERRM);
      --
  END;

END;