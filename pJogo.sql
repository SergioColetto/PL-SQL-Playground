CREATE OR REPLACE PACKAGE pJogo AS
  --
  PROCEDURE marcaGol (pinIdJogo        jogo.id_jogo%TYPE,
                       pinIdJogador    jogador.id_jogador%TYPE,
                       pisContraSN     gol.contra%TYPE);
  --
  PROCEDURE marcaCartao (pinIdJogo     jogo.id_jogo%type,
                         pinIdJogador  jogador.id_jogador%type,
                         pinIdCartao   cartao.id_cartao%type);
  --
  PROCEDURE inserir (pinIdTimeA        time.id_time%TYPE,
                     pinIdTimeB        time.id_time%TYPE);
  --
END;

--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pJogo AS

  PROCEDURE print
  (
    --
    pisMensagem VARCHAR2
    --
  )AS
  BEGIN
    --
    DBMS_OUTPUT.PUT_LINE('[pJogo] = ' || pisMensagem);
    --
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
  END;

  PROCEDURE marcaGol
  (
    --
    pinIdJogo    jogo.id_jogo%TYPE,
    pinIdJogador jogador.id_jogador%TYPE,
    pisContraSN  gol.contra%TYPE
    --
  ) AS
    --
    vbTemJogo        BOOLEAN;
    vbTemJogador     BOOLEAN;
    vnIdJogoJogador  jogo_jogador.id_jogo_jogador%TYPE;
    vsContraSNUpper  gol.contra%TYPE;
   --
  BEGIN
    --
    vsContraSNUpper := UPPER(pisContraSN);
    vbTemJogo       := PVALIDACAO.VALIDARJOGOEXISTENTE(pinIdJogo);
    vbTemJogador    := PVALIDACAO.VALIDARJOGADOREXISTENTE(pinIdJogador);
    --
    BEGIN
      --
      IF vbTemJogo AND vbTemJogador THEN
      --
        SELECT j.ID_JOGADOR
          INTO vnIdJogoJogador
          FROM jogo_jogador j
         WHERE j.ID_JOGADOR = pinIdJogador AND
               j.ID_JOGO    = pinIdJogo;
      --
      END IF;
    --
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      --
      print('Jogador não escalado para este jogo [pinIdJogador]!');
      --
    END;
    --
    IF NOT vbTemJogo THEN
      --
      print('Jogo não encontrado [pinIdJogo]!');
      --
    ELSIF NOT vbTemJogador THEN
      --
      print('Jogador não encontrado [vnCountJogador]!');
      --
    ELSIF vsContraSNUpper NOT IN ('S','N') then
      --
      print('Contra só aceira valores S ou N [pisContraSN]!');
      --
    ELSE
      --
      INSERT INTO gol(id_gol, id_jogo_jogador, contra)
      VALUES         (seq_gol.nextval, vnIdJogoJogador, vsContraSNUpper);
      --
      print('Goooollll!');
      --
    END if;
    --
  EXCEPTION
    WHEN OTHERS THEN
      --
      print('Erro ao marcar gol. Erro:['|| SQLERRM ||'].');
      --
  END;
  ------------------------------------------------------------------------------
  PROCEDURE marcaCartao
  (
    --
    pinIdJogo    jogo.id_jogo%type,
    pinIdJogador jogador.id_jogador%type,
    pinIdCartao  cartao.id_cartao%type
    --
  ) AS
   --
   vbTemJogo         BOOLEAN;
   vbTemJogador      BOOLEAN;
   vbTemCartao       BOOLEAN;
   vnQtdeCartao      NUMBER;
   vnCountQtdeCartao NUMBER;
   vnIdJogoJogador   jogo_jogador.id_jogo_jogador%type;
   --
  BEGIN
    --
    vbTemJogo    := PVALIDACAO.VALIDARJOGOEXISTENTE(pinIdJogo);
    vbTemJogador := PVALIDACAO.VALIDARJOGADOREXISTENTE(pinIdJogador);
    vbTemCartao  := PVALIDACAO.VALIDARCARTAOEXISTENTE(pinIdCartao);
    --
    BEGIN
      --
      IF vbTemJogo AND vbTemJogador THEN
      --
      SELECT j.id_jogador
        INTO vnIdJogoJogador
        FROM jogo_jogador j
       WHERE j.id_jogador = pinIdJogador AND
             j.id_jogo    = pinIdJogo;
      --
      END IF;
    --
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      --
      print('Jogador não escalado para este jogo [pinIdJogador]!');
      --
    END ;
    --
    BEGIN
      --
      IF vbTemCartao then
      --
        SELECT qtde
        INTO   vnQtdeCartao
        FROM   cartao c
        WHERE  c.id_cartao = pinIdCartao;
      --
        SELECT count(1)
        INTO   vnCountQtdeCartao
        FROM   JOGO_JOGADOR_CARTAO jjc
        WHERE  jjc.ID_JOGO_JOGADOR = vnIdJogoJogador AND
               jjc.ID_CARTAO       = pinIdCartao;
      --
      END IF ;
    --
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
      --
      print('Jogador não escalado para este jogo [pinIdJogador]!');
      --
    end;
    --
    IF NOT vbTemJogo THEN
      --
      print('Jogo não encontrado [pinIdJogo]!');
      --
    ELSIF NOT vbTemJogador THEN
      --
      print('Jogador não encontrado [vnIdJogador]!');
      --
    ELSIF NOT vbTemCartao THEN
      --
      print('Cartão não encontrado [pinIdCartao]!');
      --
    ELSIF vnIdJogoJogador = null THEN
      --
      print('Jogador não escalado!');
      --
    ELSIF vnCountQtdeCartao = vnQtdeCartao THEN
      --
      print('Limite de cartões marcados!');
      --
    ELSE
      --
      INSERT INTO JOGO_JOGADOR_CARTAO (ID_JOGO_JOGADOR_CARTAO, id_jogo_jogador, id_cartao)
      VALUES (SEQ_JOGO_JOGADOR_CARTAO.nextval, vnIdJogoJogador, pinIdCartao);
      --
      print('Cartão registrado!');
      --
    END IF;
    --
  EXCEPTION
    WHEN OTHERS THEN
      print('Erro ao marcar cartão. Erro:['|| SQLERRM ||'].');
      --
  end;
  ------------------------------------------------------------------------------
  PROCEDURE inserir 
  (
    --
    pinIdTimeA time.id_time%TYPE,
    pinIdTimeB time.id_time%TYPE
    --
  )AS
    --
    vbTemTimeA BOOLEAN;
    vbtemTimeB BOOLEAN;
    --
  BEGIN
    --
    IF pinIdTimeA = pinIdTimeB THEN
    --
      print('TIME SAO IGUAIS.');
    --
    ELSE
    --
      vbTemTimeA := PVALIDACAO.VALIDARTIMEEXISTENTE(pinIdTimeA);
      vbtemTimeB := PVALIDACAO.VALIDARTIMEEXISTENTE(pinIdTimeB);
      --
      IF NOT vbTemTimeA THEN
        --
        print('TIME A NAO ENCONTRADO.');
        --
      ELSIF NOT vbtemTimeB THEN
        --
        print('TIME A NAO ENCONTRADO.');
        --
      ELSE
        --
        INSERT INTO jogo (ID_JOGO, ID_TIME_A, ID_TIME_B)
                  VALUES (SEQ_JOGO.nextval, pinIdTimeA, pinIdTimeB);
        --
        print('JOGO INSERIDO COM SUCESSO.');
        --
      END IF;
      --
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
    --
    print('ERRO: OTHERS' || SQLERRM);
    --
  END;

END;