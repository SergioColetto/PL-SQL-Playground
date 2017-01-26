CREATE OR REPLACE PACKAGE pJogo AS
  --
  PROCEDURE marcaGol (pinIdJogo     jogo.id_jogo%TYPE,
                       pinIdJogador jogador.id_jogador%TYPE,
                       pisContraSN  gol.contra%TYPE);
  --
  PROCEDURE marcaCartao (pinIdJogo    jogo.id_jogo%type,
                         pinIdJogador jogador.id_jogador%type,
                         pinIdCartao  cartao.id_cartao%type);
  --
  PROCEDURE escalaJogador(pinJogo    jogo.id_jogo%TYPE,
                          pinJogador jogador.id_jogador%TYPE);
  --
END;
------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pJogo AS

  PROCEDURE marcaGol
  (
    --
    pinIdJogo    jogo.id_jogo%TYPE,
    pinIdJogador jogador.id_jogador%TYPE,
    pisContraSN  gol.contra%TYPE
    --
  ) AS
    --
    vnCountJogo        NUMBER;
    vnCountJogador     NUMBER;
    vnIdJogoJogador    jogo_jogador.id_jogo_jogador%TYPE;
    vsContraSNUpper    gol.contra%TYPE;
   --
  BEGIN
    --
    vsContraSNUpper := UPPER(pisContraSN);
    --
    SELECT count(1)
      INTO vnCountJogo
      FROM jogo j
     WHERE j.id_jogo = pinIdJogo;
    --
    SELECT COUNT(1)
      INTO vnCountJogador
      FROM jogador j
     WHERE j.ID_JOGADOR = pinIdJogador;
    --
    BEGIN
      --
      IF (vnCountJogo > 0 AND vnCountJogador > 0) THEN
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
    WHEN no_data_found THEN
      --
      DBMS_OUTPUT.PUT_LINE('Jogador não escalado para este jogo [pinIdJogador]!');
      --
    END;
    --
    IF vnCountJogo = 0 THEN
      --
      DBMS_OUTPUT.PUT_LINE('Jogo não encontrado [pinIdJogo]!');
      --
    ELSIF vnCountJogador = 0 THEN
      --
      DBMS_OUTPUT.PUT_LINE('Jogador não encontrado [vnCountJogador]!');
      --
    ELSIF vsContraSNUpper not in ('S','N') then
      --
      DBMS_OUTPUT.PUT_LINE('Contra só aceira valores S ou N [pisContraSN]!');
      --
    ELSE
      --
      INSERT INTO gol(id_gol, id_jogo_jogador, contra)
      VALUES         (seq_gol.nextval, vnIdJogoJogador, vsContraSNUpper);
      --
      DBMS_OUTPUT.PUT_LINE('Goooollll!');
      --
    END if;
    --
  EXCEPTION
    WHEN OTHERS THEN
      --
      DBMS_OUTPUT.PUT_LINE('Erro ao marcar gol. Erro:['|| SQLERRM ||'].');
      --
  END;
------------------------------------------------------------------------------------------------------------
  PROCEDURE marcaCartao
  (
    --
    pinIdJogo    jogo.id_jogo%type,
    pinIdJogador jogador.id_jogador%type,
    pinIdCartao  cartao.id_cartao%type
    --
  ) as
   --
   vnCountJogo        number;
   vnCountJogador     number;
   vnCountCartao      number;
   vnQtdeCartao       number;
   vnCountQtdeCartao  number;
   vnIdJogoJogador    jogo_jogador.id_jogo_jogador%type;
   --
  begin
    --
    select count(1)
    into   vnCountJogo
    from   jogo j
    where  j.id_jogo = pinIdJogo;
    --
    select count(1)
    into   vnCountJogador
    from   jogador j
    where  j.id_jogador = pinIdJogador;
    --
    select count(1)
    into   vnCountCartao
    from   cartao c
    where  c.id_cartao = pinIdCartao;
    --
    begin
      --
      if vnCountJogo > 0 and vnCountJogador > 0 then
      --
        select j.id_jogador
        into   vnIdJogoJogador
        from   jogo_jogador j
        where  j.id_jogador = pinIdJogador and
               j.id_jogo    = pinIdJogo;
      --
      end if;
    --
    exception
      when no_data_found then
      --
      dbms_output.put_line('Jogador não escalado para este jogo [pinIdJogador]!');
      --
    end;
    --
    begin
      --
      if vnCountCartao > 0 then
      --
        select qtde
        into   vnQtdeCartao
        from   cartao c
        where  c.id_cartao = pinIdCartao;
      --
      end if;
      --
      if vnCountCartao > 0 then
      --
        select count(1)
        into   vnCountQtdeCartao
        from   JOGO_JOGADOR_CARTAO jjc
        where  jjc.ID_JOGO_JOGADOR = vnIdJogoJogador
        and    jjc.ID_CARTAO       = pinIdCartao;
      --
      end if;
    --
    exception
      when no_data_found then
      --
      dbms_output.put_line('Jogador não escalado para este jogo [pinIdJogador]!');
      --
    end;
    --
    if vnCountJogo = 0 then
      --
      dbms_output.put_line('Jogo não encontrado [pinIdJogo]!');
      --
    elsif vnCountJogador = 0 then
      --
      dbms_output.put_line('Jogador não encontrado [vnIdJogador]!');
      --
    elsif vnCountCartao = 0 then
      --
      dbms_output.put_line('Cartão não encontrado [pinIdCartao]!');
      --
    elsif vnIdJogoJogador = null then
      --
      dbms_output.put_line('Jogador não escalado!');
      --
    elsif vnCountQtdeCartao = vnQtdeCartao then
      --
      dbms_output.put_line('Limite de cartões marcados!');
      --
    else
      --
      insert into JOGO_JOGADOR_CARTAO (ID_JOGO_JOGADOR_CARTAO, id_jogo_jogador, id_cartao)
      values (SEQ_JOGO_JOGADOR_CARTAO.nextval, vnIdJogoJogador, pinIdCartao);
      --
      dbms_output.put_line('Cartão registrado!');
      --
    end if;
    --
  exception
    when others then
      --
      dbms_output.put_line('Erro ao marcar cartão. Erro:['|| SQLERRM ||'].');
      --
  end;
------------------------------------------------------------------------------------------------------------
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