CREATE OR REPLACE PACKAGE pTest AS

  PROCEDURE timeTest;
  PROCEDURE jogadorTest;
  PROCEDURE tecnicoTest;
  PROCEDURE cartaoTest;
  PROCEDURE jogoTest;

END;

--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pTest AS

  PROCEDURE timeTest AS
  -- test time
  -- SELECT * FROM TIME;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('- 01 - deve inserir time');
    PTIME.INSERIR('SAO PAULO');
    DBMS_OUTPUT.PUT_LINE('- 02 - nao deixa inserir duplicado');
    PTIME.INSERIR('SAO PAULO');
    DBMS_OUTPUT.PUT_LINE('- 03 - nao deixa inserir vazio');
    PTIME.INSERIR('');
    DBMS_OUTPUT.PUT_LINE('- 04 - nao deixa inserir nulo');
    PTIME.INSERIR(NULL);
    DBMS_OUTPUT.PUT_LINE('- 05 - deve alterar time');
    PTIME.ALTERAR(2,'VASCO');
    DBMS_OUTPUT.PUT_LINE('- 06 - nao deve alterar com nome nulo');
    PTIME.ALTERAR(2, NULL);
    DBMS_OUTPUT.PUT_LINE('- 07 - nao deve alterar com nome vazio');
    PTIME.ALTERAR(2,'');
    DBMS_OUTPUT.PUT_LINE('- 08 - deve remover time');
    PTIME.REMOVER(SEQ_TIME.currval);
    DBMS_OUTPUT.PUT_LINE('- 09 - nao deve remover com jogadores');
    PTIME.REMOVER(2);
    DBMS_OUTPUT.PUT_LINE('- 10 - nao existe id');
    PTIME.REMOVER(90);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
  END;
  -------------------------------------------------------
  PROCEDURE jogadorTest AS
  -- test jogador
  -- SELECT * FROM JOGADOR;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('- 01 - deve inserir jogador');
    PJOGADOR.INSERIR('DUDO', '01-01-1989', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 02 - nao deixa inserir duplicado');
    PJOGADOR.INSERIR('DUDO', '01-01-1989', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 03 - nao deixa inserir nome vazio');
    PJOGADOR.INSERIR('', '01-01-1989', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 04 - nao deixa inserir nome nulo');
    PJOGADOR.INSERIR(NULL, '01-01-1989', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 05 - nao deixa inserir data vazio');
    PJOGADOR.INSERIR('DUDU', '', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 06 - nao deixa inserir data nulo');
    PJOGADOR.INSERIR('DUDU', NULL, 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 07 - nao deixa inserir time inesistente');
    PJOGADOR.INSERIR('DUDU', '01-01-1989', 2000, 90);

    DBMS_OUTPUT.PUT_LINE('- 08 - deve alterar jogador');
    PJOGADOR.ALTERAR(1, 'MANE', '01-01-1989', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 10 - nao deixa inserir nome vazio');
    PJOGADOR.ALTERAR(1, '', '01-01-1989', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 11 - nao deixa alterar nome nulo');
    PJOGADOR.ALTERAR(1, NULL, '01-01-1989', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 12 - nao deixa alterar data vazio');
    PJOGADOR.ALTERAR(1, 'MANE', '', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 13 - nao deixa alterar data nulo');
    PJOGADOR.ALTERAR(1, 'MANE', NULL, 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 14 - nao deixa alterar time inesistente');
    PJOGADOR.ALTERAR(1, 'MANE', '01-01-1989', 2000, 90);

    DBMS_OUTPUT.PUT_LINE('- 16 - nao existe id');
    PJOGADOR.REMOVER(90);
    
    DBMS_OUTPUT.PUT_LINE('- 01 - escalação ja realizada');
    PJOGADOR.ESCALAR(1,1);
    DBMS_OUTPUT.PUT_LINE('- 02 - deve escalar normamente');
    PJOGADOR.ESCALAR(2,17);
    DBMS_OUTPUT.PUT_LINE('- 03 - jogador invalido');
    PJOGADOR.ESCALAR(2,90);
    DBMS_OUTPUT.PUT_LINE('- 04 - jogo invalido');
    PJOGADOR.ESCALAR(90,2);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------');
  END;
  -------------------------------------------------------
  PROCEDURE tecnicoTest AS
  -- test tecnico
  -- SELECT * FROM TECNICO;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('- 01 - deve inserir tecnico');
    PTECNICO.INSERIR('TITE', '01-01-1955', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 02 - nao deixa inserir duplicado');
    PTECNICO.INSERIR('TITE', '01-01-1955', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 03 - nao deixa inserir nome vazio');
    PTECNICO.INSERIR('', '01-01-1955', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 04 - nao deixa inserir nome nulo');
    PTECNICO.INSERIR(NULL, '01-01-1955', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 05 - nao deixa inserir data vazio');
    PTECNICO.INSERIR('TITE', '', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 06 - nao deixa inserir data nulo');
    PTECNICO.INSERIR('TITE', NULL, 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 07 - nao deixa inserir time inesistente');
    PTECNICO.INSERIR('TITE', '01-01-1955', 2000, 90);

    DBMS_OUTPUT.PUT_LINE('- 08 - deve alterar tecnico');
    PTECNICO.ALTERAR(1, 'MURICI', '01-01-1955', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 10 - nao deixa inserir nome vazio');
    PTECNICO.ALTERAR(1, '', '01-01-1955', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 11 - nao deixa alterar nome nulo');
    PTECNICO.ALTERAR(1, NULL, '01-01-1955', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 12 - nao deixa alterar data vazio');
    PTECNICO.ALTERAR(1, 'MURICI', '', 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 13 - nao deixa alterar data nulo');
    PTECNICO.ALTERAR(1, 'MURICI', NULL, 2000, 1);
    DBMS_OUTPUT.PUT_LINE('- 14 - nao deixa alterar time inesistente');
    PTECNICO.ALTERAR(1, 'MURICI', '01-01-1955', 2000, 90);

    DBMS_OUTPUT.PUT_LINE('- 15 - deve remover tecnico');
    PTECNICO.REMOVER(2);
    DBMS_OUTPUT.PUT_LINE('- 16 - nao existe id');
    PTECNICO.REMOVER(90);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
  END;
  -------------------------------------------------------
  PROCEDURE cartaoTest AS
  -- test cartao
  -- SELECT * FROM CARTAO;
  BEGIN
    --
    DBMS_OUTPUT.PUT_LINE('[pCartao] = deve inserir cartao');
    PCARTAO.INSERIR('AMARELO', 1);
    DBMS_OUTPUT.PUT_LINE('[pCartao] = nao deixa inserir descricao vazio');
    PCARTAO.INSERIR('', 1);
    DBMS_OUTPUT.PUT_LINE('[pCartao] = nao deixa inserir descricao nulo');
    PCARTAO.INSERIR(NULL, 1);
    DBMS_OUTPUT.PUT_LINE('[pCartao] = nao deixa inserir qtde nulo');
    PCARTAO.INSERIR('VERMELHO', NULL);
    --
    DBMS_OUTPUT.PUT_LINE('[pCartao] = deve alterar cartao');
    PCARTAO.ALTERAR(2,'VERDE', 2);
    DBMS_OUTPUT.PUT_LINE('[pCartao] = nao deve alterar com nome nulo');
    PCARTAO.ALTERAR(2, NULL, 2);
    DBMS_OUTPUT.PUT_LINE('[pCartao] = nao deve alterar com nome vazio');
    PCARTAO.ALTERAR(2,'', 2);
    DBMS_OUTPUT.PUT_LINE('[pCartao] = nao deve alterar com qtde nulo');
    PCARTAO.ALTERAR(2,'AZUL', NULL);
    --
    DBMS_OUTPUT.PUT_LINE('[pCartao] = deve remover time');
    PCARTAO.REMOVER(2);
    DBMS_OUTPUT.PUT_LINE('[pCartao] = nao existe id');
    PCARTAO.REMOVER(90);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    --
  END;
  -------------------------------------------------------
  PROCEDURE jogoTest AS
  -- test jogo
  -- SELECT * FROM jogo;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('- 01 - deve inserir jogo');
    PJOGO.INSERIR(1,1);
    DBMS_OUTPUT.PUT_LINE('- 02 - nao deve inserir jogo, time a nao existe');
    PJOGO.INSERIR(90,1);
    DBMS_OUTPUT.PUT_LINE('- 03 - deve inserir jogo, time b nao existe');
    PJOGO.INSERIR(1,90);
    DBMS_OUTPUT.PUT_LINE('- 04 - times sao iguais');
    PJOGO.INSERIR(1,1);
    --
    DBMS_OUTPUT.PUT_LINE('- 05 - marcar gol certo');
    PJOGO.MARCAGOL(1, 1, 'N');
    DBMS_OUTPUT.PUT_LINE('- 06 - marcar gol contra');
    PJOGO.MARCAGOL(1, 1, 'S');
    DBMS_OUTPUT.PUT_LINE('- 07 - jogo nao existe');
    PJOGO.MARCAGOL(90, 1, 'N');
    DBMS_OUTPUT.PUT_LINE('- 08 - jogador nao existe');
    PJOGO.MARCAGOL(1, 90, 'N');
    DBMS_OUTPUT.PUT_LINE('- 09 - tipo de gol invalido');
    PJOGO.MARCAGOL(1, 1, 'X');
    --
    DBMS_OUTPUT.PUT_LINE('- 10 - marca cartao amarelo');
    PJOGO.MARCACARTAO(2, 1, 1);
    DBMS_OUTPUT.PUT_LINE('- 11 - marca cartao vermelho');
    PJOGO.MARCACARTAO(1, 2, 2);
    DBMS_OUTPUT.PUT_LINE('- 12 - cartao nao existe');
    PJOGO.MARCACARTAO(2, 1, 90);
    DBMS_OUTPUT.PUT_LINE('- 13 - jogo nao existe');
    PJOGO.MARCACARTAO(90, 1, 1);
    DBMS_OUTPUT.PUT_LINE('- 14 - jogador nao exite');
    PJOGO.MARCACARTAO(2, 90, 1);
  END;
END;