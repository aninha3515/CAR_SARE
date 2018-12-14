require 'faker'
usuario = "55613853720"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sigam-adequacao-test/"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

Dado("que esteja preenchendo o cadastro do CAR") do
	visit(link)
	RealizaLogin.acesso(usuario)
end

Quando("preencher todas as informações requeridas") do
	InsereDados.inicio(nomeCAR = "Def GW SemUC Fazenda " +  Faker::Name.first_name,  muni = "ILHABELA")
	InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico")
	InsereDados.InserePessoa(cpfPessoa = "03416907833", permissao = "Representante")
	InsereDados.AnexaProcuracao
	InsereDados.DesenhaPropriedade
	InsereDados.NaoExiste(link, artigo = "")
	InsereDados.final(possuiAreas = "")
end

Então("o sistema criará o CAR sem UC em Homlog") do
	@numCar = find(:id, "ctl00_conteudo_lblCAR").text
	puts("CAR Deficitário criado com sucesso no ambiente " + link + " e seu número é: " +  @numCar)	
end