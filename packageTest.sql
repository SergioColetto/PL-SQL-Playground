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

  DBMS_OUTPUT.PUT_LINE('- 15 - deve remover jogador');
  PJOGADOR.REMOVER(SEQ_TIME.currval);
  DBMS_OUTPUT.PUT_LINE('- 16 - nao existe id');
  PJOGADOR.REMOVER(90);
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
-------------------------------------------------------
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
  PTECNICO.REMOVER(SEQ_TIME.currval);
  DBMS_OUTPUT.PUT_LINE('- 16 - nao existe id');
  PTECNICO.REMOVER(90);
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
-------------------------------------------------------
-- test cartao
-- SELECT * FROM CARTAO;
BEGIN
  DBMS_OUTPUT.PUT_LINE('- 01 - deve inserir cartao');
  PCARTAO.INSERIR('AMARELO', 1);
  DBMS_OUTPUT.PUT_LINE('- 02 - nao deixa inserir vazio');
  PCARTAO.INSERIR('', 1);
  DBMS_OUTPUT.PUT_LINE('- 03 - nao deixa inserir nulo');
  PCARTAO.INSERIR(NULL, 1);
  DBMS_OUTPUT.PUT_LINE('- 04 - nao deixa inserir qtde nulo');
  PCARTAO.INSERIR('VERMELHO', NULL);

  DBMS_OUTPUT.PUT_LINE('- 05 - deve alterar cartao');
  PCARTAO.ALTERAR(2,'VERDE', 2);
  DBMS_OUTPUT.PUT_LINE('- 06 - nao deve alterar com nome nulo');
  PCARTAO.ALTERAR(2, NULL, 2);
  DBMS_OUTPUT.PUT_LINE('- 07 - nao deve alterar com nome vazio');
  PCARTAO.ALTERAR(2,'', 2);
  DBMS_OUTPUT.PUT_LINE('- 08 - nao deve alterar com qtde nulo');
  PCARTAO.ALTERAR(2,'AZUL', NULL);

  DBMS_OUTPUT.PUT_LINE('- 09 - deve remover time');
  PCARTAO.REMOVER(2);
  DBMS_OUTPUT.PUT_LINE('- 10 - nao existe id');
  PCARTAO.REMOVER(90);
  DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;


ROLLBACK;