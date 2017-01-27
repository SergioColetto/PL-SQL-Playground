DROP SEQUENCE seq_cartao;
DROP SEQUENCE seq_gol;
DROP SEQUENCE seq_jogo;
DROP SEQUENCE seq_jogador;
DROP SEQUENCE seq_jogo_jogador;
DROP SEQUENCE seq_jogo_jogador_cartao;
DROP SEQUENCE seq_tecnico;
DROP SEQUENCE seq_time;
--
ALTER TABLE jogador DROP CONSTRAINT fk_time_jogador;
ALTER TABLE tecnico DROP CONSTRAINT fk_time_tecnico;
ALTER TABLE jogo DROP CONSTRAINT fk_jogo_time_a;
ALTER TABLE jogo DROP CONSTRAINT fk_jogo_time_b;
ALTER TABLE jogo_jogador DROP CONSTRAINT fk_jj_jogo;
ALTER TABLE jogo_jogador DROP CONSTRAINT fk_jj_jogador;
ALTER TABLE jogo_jogador DROP CONSTRAINT uk_escalacao;
ALTER TABLE gol DROP CONSTRAINT fk_gol_jj;
ALTER TABLE gol DROP CONSTRAINT ck_gol_contra;
ALTER TABLE jogo_jogador_cartao DROP CONSTRAINT fk_jjc_jj;
ALTER TABLE jogo_jogador_cartao DROP CONSTRAINT fk_jjc_cartao;
ALTER TABLE cartao DROP CONSTRAINT pk_cartao;
ALTER TABLE gol DROP CONSTRAINT pk_gol;
ALTER TABLE jogo_jogador_cartao DROP CONSTRAINT pk_jjc;
ALTER TABLE jogador DROP CONSTRAINT pk_jogador;
ALTER TABLE jogo DROP CONSTRAINT pk_jogo;
ALTER TABLE jogo_jogador DROP CONSTRAINT pk_jogo_jogador;
ALTER TABLE tecnico DROP CONSTRAINT pk_tecnico;
ALTER TABLE time DROP CONSTRAINT pk_time;
--
DROP TABLE cartao;
DROP TABLE gol;
DROP TABLE jogo;
DROP TABLE jogador;
DROP TABLE jogo_jogador;
DROP TABLE jogo_jogador_cartao;
DROP TABLE tecnico;
DROP TABLE time;
--
DROP TRIGGER TR_ATUALIZA_PLACAR;
--
DROP PACKAGE pCartao;
DROP PACKAGE pJogo;
DROP PACKAGE pJogador;
DROP PACKAGE pTecnico;
DROP PACKAGE pTest;
DROP PACKAGE pTime;
DROP PACKAGE pValidacao;