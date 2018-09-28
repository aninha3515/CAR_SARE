#language: pt
#utf-8

@vinculaCarUC


Funcionalidade: Vincular CAR Deficitário de UC em Excedente de UC
  Eu como usuario do CAR
  Quero executar um script
  Para vincular CAR Deficitário de UC em Excedente de UC

  Cenario: Vincular CAR UC
  	Dado que possua CAR Deficitário de UC
    E Excedente de UC
  	Quando realiazar o vínculo de UC
  	Então o sistema irá apresentar os CARs UC vinculados