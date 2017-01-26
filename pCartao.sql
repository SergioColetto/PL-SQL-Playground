CREATE OR REPLACE PACKAGE pCartao AS

  PROCEDURE inserir(pisDescricao cartao.descricao%type,
                    pinQtde      cartao.qtde%type);

  PROCEDURE alterar(pinIdCartao  cartao.id_cartao%type,
                    pisDescricao cartao.descricao%type,
                    pinQtde      cartao.qtde%type);

  PROCEDURE remover(pinIdCartao  cartao.id_cartao%type);

END pCartao;

CREATE OR REPLACE PACKAGE BODY pCartao AS

  PROCEDURE inserir
  (
    --
    pisDescricao cartao.descricao%type,
    pinQtde      cartao.qtde%type
    --
  ) AS
    --
    --
  BEGIN
    --
    IF pisDescricao IS null THEN
      --
      DBMS_OUTPUT.PUT_LINE('Não pode inserir descrição null');
      --
    ELSIF TRIM(pisDescricao) IS null THEN
      --
      DBMS_OUTPUT.PUT_LINE('Não pode inserir descrição vazia');
      --
    ELSIF pinQtde IS null THEN
      --
      DBMS_OUTPUT.PUT_LINE('Não pode inserir quantidade null');
      --
    ELSIF pinQtde <= 0 THEN
      --
      DBMS_OUTPUT.PUT_LINE('Não pode inserir quantidade menor ou igual a zero');
      --
    ELSE
      --
      INSERT INTO cartao (id_cartao, descricao, qtde)
                  VALUES (seq_cartao.nextval, pisDescricao, pinQtde);
      --
      DBMS_OUTPUT.PUT_LINE('Cartão inserido com sucesso');
      --
    END IF;
    --
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro ao inserir cartão. ' || SQLERRM);
  END;
  ---------------------------------------------------------------------------------------------------
  PROCEDURE alterar
  (
    --
    pinIdCartao  cartao.id_cartao%type,
    pisDescricao cartao.descricao%type,
    pinQtde      cartao.qtde%type
    --
  ) AS
    --
    vnCountCartao NUMBER;
    --
  BEGIN
    --
    SELECT COUNT(1)
      INTO vnCountCartao
      FROM cartao
     WHERE id_cartao = pinIdCartao;
    --
    IF vnCountCartao = 0 THEN
      --
      DBMS_OUTPUT.PUT_LINE('Cartão inexistente');
      --
    ELSIF pisDescricao IS null THEN
      --
      DBMS_OUTPUT.PUT_LINE('Não pode inserir descrição null');
      --
    ELSIF TRIM(pisDescricao) IS null THEN
      --
      DBMS_OUTPUT.PUT_LINE('Não pode inserir descrição vazia');
      --
    ELSIF pinQtde IS null THEN
      --
      DBMS_OUTPUT.PUT_LINE('Não pode inserir quantidade null');
      --
    ELSIF pinQtde <= 0 THEN
      --
      DBMS_OUTPUT.PUT_LINE('Não pode inserir quantidade menor ou igual a zero');
      --
    ELSE
      --
      UPDATE cartao c
         SET c.descricao = pisDescricao,
                  c.qtde = pinQtde
       WHERE c.id_cartao = pinIdCartao;
      --
      DBMS_OUTPUT.PUT_LINE('Cartão atualizado com sucesso');
      --
    END IF;
    --
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro ao atualizar cartão. ' || SQLERRM);
  END;
  ---------------------------------------------------------------------------------------------------
  PROCEDURE remover
  (
    --
    pinIdCartao cartao.id_cartao%type
    --
  )AS
    --
    vnCountCartao NUMBER;
    --
  BEGIN
    --
    SELECT COUNT(1)
      INTO vnCountCartao
      FROM cartao c
     WHERE c.id_cartao = pinIdCartao;
    --
    IF vnCountCartao = 0 THEN
      --
      DBMS_OUTPUT.PUT_LINE('Cartão inexistente');
      --
    ELSE
      --
      DELETE cartao c
       WHERE c.id_cartao = pinIdCartao;
      --
      DBMS_OUTPUT.PUT_LINE('Cartão excluído com sucesso');
      --
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Erro ao excluir cartão. ' || SQLERRM);
  END;

END pCartao;