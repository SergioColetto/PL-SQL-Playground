CREATE OR REPLACE TRIGGER TR_ATUALIZA_PLACAR
AFTER INSERT ON GOL
FOR EACH ROW 
BEGIN
  --
  IF :NEW.CONTRA = 'N' THEN
  --
    UPDATE JOGO JU SET NR_GOL_A = NVL(NR_GOL_A, 0) + 1
    WHERE EXISTS (
    SELECT * FROM JOGO_JOGADOR JJ, JOGO J, JOGADOR JOG
    WHERE JJ.ID_JOGO_JOGADOR = :NEW.ID_JOGO_JOGADOR
      AND JJ.ID_JOGO = J.ID_JOGO
      AND JJ.ID_JOGADOR = JOG.ID_JOGADOR
      AND JOG.ID_TIME = J.ID_TIME_A
      AND JU.ID_JOGO = J.ID_JOGO);
    
    UPDATE JOGO JU SET NR_GOL_B = NVL(NR_GOL_B, 0) + 1
    WHERE EXISTS (
    SELECT * FROM JOGO_JOGADOR JJ, JOGO J, JOGADOR JOG
    WHERE JJ.ID_JOGO_JOGADOR = :NEW.ID_JOGO_JOGADOR
      AND JJ.ID_JOGO = J.ID_JOGO
      AND JJ.ID_JOGADOR = JOG.ID_JOGADOR
      AND JOG.ID_TIME = J.ID_TIME_B
      AND JU.ID_JOGO = J.ID_JOGO);
  --
  ELSE
	--
    UPDATE JOGO JU SET NR_GOL_A = NVL(NR_GOL_A, 0) + 1
    WHERE EXISTS (
    SELECT * FROM JOGO_JOGADOR JJ, JOGO J, JOGADOR JOG
    WHERE JJ.ID_JOGO_JOGADOR = :NEW.ID_JOGO_JOGADOR
      AND JJ.ID_JOGO = J.ID_JOGO
      AND JJ.ID_JOGADOR = JOG.ID_JOGADOR
      AND JOG.ID_TIME = J.ID_TIME_B
      AND JU.ID_JOGO = J.ID_JOGO);
    
    UPDATE JOGO JU SET NR_GOL_B = NVL(NR_GOL_B, 0) + 1
    WHERE EXISTS (
    SELECT * FROM JOGO_JOGADOR JJ, JOGO J, JOGADOR JOG
    WHERE JJ.ID_JOGO_JOGADOR = :NEW.ID_JOGO_JOGADOR
      AND JJ.ID_JOGO = J.ID_JOGO
      AND JJ.ID_JOGADOR = JOG.ID_JOGADOR
      AND JOG.ID_TIME = J.ID_TIME_A
      AND JU.ID_JOGO = J.ID_JOGO);
   --
   END IF;

END;