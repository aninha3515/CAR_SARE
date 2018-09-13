#language: pt
#utf-8

@GeraCarDeficitRL


Funcionalidade: Vincular CAR com Deficit de RL em um CAR excedente
  Eu como usuario do CAR
  Quero executar um script
  Para criar um car com Deficit de RL

  @tira_print

  Cenario: Criar CAR deficitario RL
  	Dado que possua um CAR deficitário
	  E um CAR Excedente
  	Quando realizar o vínculo
  	Então o CAR deficitario estará vinculado ao excedente