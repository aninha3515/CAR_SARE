require 'faker'
usuario = "55613853720"
link = "http://exec-dev01.sma.local/SMA-EST-CAR_test/"
#link = "http://exec-dev01.sma.local/sigam-adequacao-test/"

Dado("que esteja preenchendo o cadastro do CAR") do
	visit(link)
	RealizaLogin.acesso(usuario)
end

Quando("preencher todas as informações requeridas") do
	InsereDados.inicio(nomeCAR = "Def Fazenda " +  Faker::Name.first_name + " SARE")
		InsereDados.DesenhaPropriedade
		InsereDados.NaoExiste
end

Então("o sistema criará o CAR sem UC em Homlog") do
	InsereDados.final
	@numCar = find(:id, "ctl00_conteudo_lblCAR").text
	puts("CAR Deficitário criado com sucesso no ambiente de homologação e seu número é: " +  @numCar)	
end