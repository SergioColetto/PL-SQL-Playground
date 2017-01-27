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
  PROCEDURE escalar (pinJogo              jogo.id_jogo%TYPE,
                        pinJogador        jogador.id_jogador%TYPE);
  --
END;

--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pJogador IS

  PROCEDURE print
  (
    --
    pisMensagem VARCHAR2
    --
  )AS
  BEGIN
    --
    DBMS_OUTPUT.PUT_LINE('[pJogador] = ' || pisMensagem);
    --
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
  END;

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
    vbTemTime    BOOLEAN;
    --
  BEGIN
    --
    vbTemTime := PVALIDACAO.VALIDARTIMEEXISTENTE(pinIdTime);
    --
    IF vbTemTime THEN
      --
      IF NOT PVALIDACAO.VALIDARCAMPOOBRIGATORIOSTRING(pisNome) THEN
        --
        print('NOME NÃO PODE SER VAZIO OU NULO.');
        --
      ELSIF NOT PVALIDACAO.VALIDARCAMPOOBRIGATORIODATE(pidDataDeNascimento) THEN
        --
        print('DATA DE NASCIMENTO NÃO PODE SER MAIOR QUE A DATA ATUAL OU NULA.');
        --
      ELSIF NOT PVALIDACAO.VALIDARCAMPOOBRIGATORIONUMBER(pinIdTime) THEN
        --
        print('NUMERO DO TIME NÃO PODE SE NULO, NEGATIVO OU ZERO.');
        --
      ELSE
        --
        INSERT INTO jogador (ID_JOGADOR, NOME, DT_NASCIMENTO, SALARIO, ID_TIME)
                     VALUES (SEQ_JOGADOR.nextval, pisNome, pidDataDeNascimento, pinSalario, pinIdTime);
        --
        print('REGISTRO SALVO COM SUCESSO.');
        --
      END IF;
      --
    ELSE
      --
      print('O TIME INFORMADO NÃO EXISTE.');
      --
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
    --
    print('ERRO: OTHERS [' || SQLERRM || ']');
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
    vbTemJogador BOOLEAN;
    vbTemTime    BOOLEAN;
    --
  BEGIN
    --
    vbTemTime := PVALIDACAO.VALIDARTIMEEXISTENTE(pinIdTime);
    --
    IF vbTemTime THEN
      --
      IF NOT PVALIDACAO.VALIDARCAMPOOBRIGATORIOSTRING(pisNome) THEN
        --
        print('NOME NÃO PODE SER VAZIO OU NULO.');
        --
      ELSIF NOT PVALIDACAO.VALIDARCAMPOOBRIGATORIODATE(pidDataDeNascimento) THEN
        --
        print('DATA DE NASCIMENTO NÃO PODE SER MAIOR QUE A DATA ATUAL OU NULA.');
        --
      ELSIF NOT PVALIDACAO.VALIDARCAMPOOBRIGATORIONUMBER(pinIdTime)THEN
        --
        print('NUMERO DO TIME NÃO PODE SE NULO, NEGATIVO OU ZERO.');
        --
      ELSE
        --
        vbTemJogador := PVALIDACAO.VALIDARJOGADOREXISTENTE(pinId);
        --
        IF vbTemJogador THEN
          --
          UPDATE JOGADOR J
            SET NOME          = pisNome,
                DT_NASCIMENTO = pidDataDeNascimento,
                SALARIO       = pinSalario,
                ID_TIME       = pinIdTime
          WHERE J.ID_JOGADOR  = pinId;
          --
          print('REGISTRO ALTERADO COM SUCESSO.');
          --
        ELSE
          --
          print('ERRO AO LOCALIZAR O JOGADOR.');
          --
        END IF;
        --
      END IF;
      --
    ELSE
      --
      print('O TIME INFORMADO NÃO EXISTE.');
      --
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
    --
    print('ERRO: OTHERS [' || SQLERRM || ']');
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
    vbTemJogador BOOLEAN;
    --
  BEGIN
    --
    vbTemJogador := PVALIDACAO.VALIDARJOGADOREXISTENTE(pinId);
    --
    IF vbTemJogador THEN
      --
      DELETE JOGADOR J
       WHERE J.ID_JOGADOR = pinId;
      --
      print('jogador REMOVIDO COM SUCESSO');
      --
    ELSE
      --
      print('NÃO EXISTE UM JOGADOR COM ESSE ID CADASTRADO.');
      --
    END IF;
    --
  EXCEPTION
    WHEN OTHERS THEN
    --
    print('ERRO: OTHERS' || SQLERRM);
    --
  END;
  ------------------------------------------------------------------------------
  PROCEDURE escalar (
    --
    pinJogo    IN jogo.id_jogo%TYPE,
    pinJogador IN jogador.id_jogador%TYPE
    --
  ) AS
    --
    vbTemJogo    BOOLEAN;
    vbTemJogador BOOLEAN;
    --
  BEGIN
    --
    vbTemJogo    := PVALIDACAO.VALIDARJOGOEXISTENTE(pinJogo);
    vbTemJogador := PVALIDACAO.VALIDARJOGADOREXISTENTE(pinJogador);
    --
    IF NOT vbTemJogo THEN
      --
      print('Código do Jogo Inválido');
      --
    ELSIF NOT vbTemJogador THEN
      --
      print('Código do Jogador Inválido');
      --
    ELSE
      --
      INSERT INTO JOGO_JOGADOR (id_jogo_jogador, id_jogo, id_jogador)
                        VALUES (seq_jogo_jogador.nextval, pinJogo, pinJogador);
      --
      print('Escalação salva com sucesso');
      --
    END IF;
    --
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      print('Escalação já realizada.');
      --
    WHEN OTHERS THEN
      print('Erro ao escalar jogador. ' || SQLERRM);
      --
  END;

END;