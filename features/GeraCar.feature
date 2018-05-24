#language: pt
#utf-8

@GeraCar


Funcionalidade: Gerar CAR
  Eu como usuario do CAR
  Quero executar um script
  Para criar CAR UC

@deslogar_sigam @tira_print

  Cenario: Criar CAR UC
  	Dado que esteja na tela de cadastro do CAR
  	Quando preencher todas as informações
  	Então o sistema criará o CAR