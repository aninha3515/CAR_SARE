#language: pt
#utf-8

@AlteraSituacaoCAR

Funcionalidade: Apresentar mensagem ao cancelar CAR
  Eu como usuario do sistema 
  Quero que o sistema apresente mensagens ao cancelar um CAR 
  Para lembrar ao técnico que necessita cancelar a Adequação e o SARE

 #Ao cancelar o CAR, é necessário cancelar a Adequação Ambiental e o projeto de PRA/Adequação Ambiental no SARE associadoa este CAR

  Cenario: Situação Cancelado Parecer
  	Dado que o técnico esteja logado
    E esteja acessando um CAR
  	Quando alterar a situação para cancelado
  	Então o sistema apresentará o pop-up com botão OK
    
  Cenario: Situação Cancelado consulta Gerencial
		Dado que o técnico esteja logado no sigam
    E localize um CAR 
  	Quando alterar a situação para cancelado pela aba Alterar Situação
  	Então o sistema apresentará um pop-up com botão OK

  Cenario: Situação invalido Parecer
		Dado que o técnico esteja logado no sistema
    E busque um CAR 
  	Quando alterar a situação para invalido
  	Então o sistema apresentará pop-up com botão OK

  Cenario: Situação invalido Consulta Gerencial
		Dado que o técnico esteja logado no SICAR
    E encontre um CAR 
  	Quando alterar a situação para invalido pela aba Alterar Situação
  	Então o sistema exibirá pop-up com botão OK