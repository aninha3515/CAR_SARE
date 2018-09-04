require 'faker'
usuario = "55613853720"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sigam-adequacao-test/"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

Dado("que esteja na tela do CAR") do
	visit(link)
	RealizaLogin.acesso(usuario)
end
Quando("preencher todas as informações necessarias") do
	InsereDados.inicio(nomeCAR = "Exc GW UC Fazenda " +  Faker::Name.first_name)
	find(:id, "__tab_ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDeclaracao").click
	find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDeclaracao_carDeclaracao_gvConsulta_ctl07_chkDeclara").click
	InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico")
	InsereDados.InserePessoa(cpfPessoa = "03416907833", permissao = "Representante")
	InsereDados.AnexaProcuracao
	InsereDados.DesenhaPropriedade
	InsereDados.NaoExiste(link, artigo = "")
	InsereDados.DesenhaUC(usuario)
	InsereDados.final(possuiAreas = "")
end
Então("o sistema criará o CAR UC em Homlog") do
	@numCar = find(:id, "ctl00_conteudo_lblCAR").text
	puts("CAR Excedente criado com sucesso no link " + link + " e seu número é: " +  @numCar)
end