#language: pt
#utf-8

@GeraCarDeficitRL


Funcionalidade: Gerar Car com Deficit de RL
  Eu como usuario do CAR
  Quero executar um script
  Para criar um car com Deficit de RL

@deslogar_sigam @tira_print

  Cenario: Criar CAR deficitario RL
  	Dado que esteja criando o CAR deficitario
  	Quando Desenhar os polígonos de RL
  	Então o CAR estará com deficit de RL