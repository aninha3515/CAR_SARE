#language: pt
#utf-8

@GeraCarHomolog


Funcionalidade: Gerar CAR UC ambiente de Homologacão
  Eu como usuario do sistema CAR
  Quero executar um script automatizado
  Para criar CAR UC no ambiente de Homolog

@deslogar_sigam

  Cenario: Criar CAR UC Homolog
  	Dado que esteja na tela do CAR
  	Quando preencher todas as informações necessarias
  	Então o sistema criará o CAR UC em Homlog
