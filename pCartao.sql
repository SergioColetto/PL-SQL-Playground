CREATE OR REPLACE PACKAGE pCartao AS

  PROCEDURE inserir(pisDescricao cartao.descricao%type,
                    pinQtde      cartao.qtde%type);

  PROCEDURE alterar(pinIdCartao  cartao.id_cartao%type,
                    pisDescricao cartao.descricao%type,
                    pinQtde      cartao.qtde%type);

  PROCEDURE remover(pinIdCartao  cartao.id_cartao%type);

END pCartao;

--------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY pCartao AS

  PROCEDURE print
  (
    --
    pisMensagem VARCHAR2
    --
  )AS
  BEGIN
    --
    DBMS_OUTPUT.PUT_LINE('[pCartao] = ' || pisMensagem);
    --
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
  END;

  PROCEDURE inserir
  (
    --
    pisDescricao cartao.descricao%type,
    pinQtde      cartao.qtde%type
    --
  ) AS
    --
  BEGIN
    --
    IF NOT PVALIDACAO.VALIDARCAMPOOBRIGATORIOSTRING(pisDescricao) THEN
      --
      print('Não pode inserir descrição null');
      --
    ELSIF NOT PVALIDACAO.VALIDARCAMPOOBRIGATORIONUMBER(pinQtde) THEN
      --
      print('Não pode inserir quantidade null');
      --
    ELSE
      --
      INSERT INTO cartao (id_cartao, descricao, qtde)
                  VALUES (seq_cartao.nextval, pisDescricao, pinQtde);
      --
      print('Cartão inserido com sucesso');
      --
    END IF;
    --
  EXCEPTION
    WHEN OTHERS THEN
      print('Erro ao inserir cartão. ' || SQLERRM);
  END;
  ------------------------------------------------------------------------------
  PROCEDURE alterar
  (
    --
    pinIdCartao  cartao.id_cartao%type,
    pisDescricao cartao.descricao%type,
    pinQtde      cartao.qtde%type
    --
  ) AS
    --
    vbTemCartao BOOLEAN;
    --
  BEGIN
    --
    vbTemCartao := PVALIDACAO.VALIDARCARTAOEXISTENTE(pinIdCartao);
    --
    IF NOT vbTemCartao THEN
      --
      print('Cartão inexistente');
      --
    ELSIF NOT PVALIDACAO.VALIDARCAMPOOBRIGATORIOSTRING(pisDescricao) THEN
      --
      print('Não pode inserir descrição null');
      --
    ELSIF NOT PVALIDACAO.VALIDARCAMPOOBRIGATORIONUMBER(pinQtde) THEN
      --
      print('Não pode inserir quantidade null');
      --
    ELSE
      --
      UPDATE cartao c
         SET c.descricao = pisDescricao,
                  c.qtde = pinQtde
       WHERE c.id_cartao = pinIdCartao;
      --
      print('Cartão atualizado com sucesso');
      --
    END IF;
    --
  EXCEPTION
    WHEN OTHERS THEN
      print('Erro ao atualizar cartão. ' || SQLERRM);
  END;
  ------------------------------------------------------------------------------
  PROCEDURE remover
  (
    --
    pinIdCartao cartao.id_cartao%type
    --
  )AS
    --
    vbTemCartao BOOLEAN;
    --
  BEGIN
    --
    vbTemCartao := PVALIDACAO.VALIDARCARTAOEXISTENTE(pinIdCartao);
    --
    IF NOT vbTemCartao THEN
      --
      print('Cartão inexistente');
      --
    ELSE
      --
      DELETE cartao c
       WHERE c.id_cartao = pinIdCartao;
      --
      print('Cartão excluído com sucesso');
      --
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      print('Erro ao excluir cartão. ' || SQLERRM);
  END;

END;