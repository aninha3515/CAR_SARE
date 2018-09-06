#language: pt
#utf-8

@GeraCarSemUC


Funcionalidade: Gerar CAR sem UC
  Eu como usuario do sistema SiCAR
  Quero executar um roteiro automatizado
  Para criar CAR sem UC no ambiente de Homolog

  @tira_print

  Cenario: Criar CAR sem UC Homolog
  	Dado que esteja preenchendo o cadastro do CAR
  	Quando preencher todas as informações requeridas
  	Então o sistema criará o CAR sem UC em Homlog
