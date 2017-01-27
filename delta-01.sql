CREATE TABLE time(
  id_time NUMBER NOT NULL,
  nome VARCHAR2(400)
);
--
CREATE TABLE jogador(
  id_jogador NUMBER NOT NULL,
  nome VARCHAR2(400) NOT NULL,
  dt_nascimento DATE NOT NULL,
  salario NUMBER(18,2),
  id_time NUMBER NOT NULL
);
--
CREATE TABLE tecnico(
  id_tecnico NUMBER NOT NULL,
  nome VARCHAR2(400) NOT NULL,
  dt_nascimento DATE NOT NULL,
  salario NUMBER(18,2),
  id_time NUMBER NOT NULL
);
--
CREATE TABLE jogo(
  id_jogo NUMBER NOT NULL,
  id_time_a NUMBER NOT NULL,
  id_time_b NUMBER NOT NULL,
  nr_gol_a NUMBER,
  nr_gol_b NUMBER,
  dh_inicio DATE,
  dh_fim DATE
);
--
CREATE TABLE cartao (
  id_cartao NUMBER NOT NULL,
  descricao VARCHAR2(400) NOT NULL,
  qtde NUMBER NOT NULL
);
--
CREATE TABLE jogo_jogador (
  id_jogo_jogador NUMBER NOT NULL,
  id_jogo NUMBER NOT NULL,
  id_jogador NUMBER NOT NULL
);
--
CREATE TABLE gol (
  id_gol NUMBER NOT NULL,
  id_jogo_jogador NUMBER NOT NULL,
  contra CHAR(1) NOT NULL
);
--
CREATE TABLE jogo_jogador_cartao (
  id_jogo_jogador_cartao NUMBER NOT NULL,
  id_jogo_jogador NUMBER NOT NULL,
  id_cartao NUMBER NOT NULL
);