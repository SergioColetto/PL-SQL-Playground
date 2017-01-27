ALTER TABLE cartao ADD CONSTRAINT pk_cartao PRIMARY KEY(id_cartao);
ALTER TABLE gol ADD CONSTRAINT pk_gol PRIMARY KEY(id_gol);
ALTER TABLE jogo ADD CONSTRAINT pk_jogo PRIMARY KEY(id_jogo);
ALTER TABLE jogador ADD CONSTRAINT pk_jogador PRIMARY KEY (id_jogador);
ALTER TABLE jogo_jogador ADD CONSTRAINT pk_jogo_jogador PRIMARY KEY(id_jogo_jogador);
ALTER TABLE jogo_jogador_cartao ADD CONSTRAINT pk_jjc PRIMARY KEY (id_jogo_jogador_cartao);
ALTER TABLE time ADD CONSTRAINT pk_time PRIMARY KEY (id_time);
ALTER TABLE tecnico ADD CONSTRAINT pk_tecnico PRIMARY KEY (id_tecnico);
--
ALTER TABLE jogador ADD CONSTRAINT fk_time_jogador FOREIGN KEY(id_time) REFERENCES time(id_time);
ALTER TABLE jogo ADD CONSTRAINT fk_jogo_time_a FOREIGN KEY(id_time_a) REFERENCES time(id_time);
ALTER TABLE jogo ADD CONSTRAINT fk_jogo_time_b FOREIGN KEY(id_time_b) REFERENCES time(id_time);
ALTER TABLE jogo_jogador ADD CONSTRAINT fk_jj_jogo FOREIGN KEY(id_jogo) REFERENCES jogo(id_jogo);
ALTER TABLE jogo_jogador ADD CONSTRAINT fk_jj_jogador FOREIGN KEY(id_jogador) REFERENCES jogador(id_jogador);
ALTER TABLE gol ADD CONSTRAINT fk_gol_jj FOREIGN KEY(id_jogo_jogador) REFERENCES jogo_jogador(id_jogo_jogador);
ALTER TABLE jogo_jogador_cartao ADD CONSTRAINT fk_jjc_jj FOREIGN KEY(id_jogo_jogador) REFERENCES jogo_jogador(id_jogo_jogador);
ALTER TABLE jogo_jogador_cartao ADD CONSTRAINT fk_jjc_cartao FOREIGN KEY(id_cartao) REFERENCES cartao(id_cartao);
ALTER TABLE tecnico ADD CONSTRAINT fk_time_tecnico FOREIGN KEY(id_time) REFERENCES time(id_time);
--
ALTER TABLE gol ADD CONSTRAINT ck_gol_contra CHECK (contra = 'S' OR contra = 'N');
--
ALTER TABLE JOGO_JOGADOR ADD CONSTRAINT uk_escalacao UNIQUE (id_jogo, id_jogador);
--
ALTER TABLE cartao MODIFY qtde DEFAULT 1;
ALTER TABLE jogo MODIFY NR_GOL_A DEFAULT 0;
ALTER TABLE jogo MODIFY NR_GOL_b DEFAULT 0;
