require 'faker'
usuario = "55613853720"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sigam-adequacao-test/"
Dado("que esteja na tela de cadastro do CAR") do
	visit(link)
	RealizaLogin.acesso(usuario)
end

Quando("preencher todas as informações") do
	InsereDados.inicio(nomeCAR = "Exc Fazenda " +  Faker::Name.first_name)
	numProtocolo = find(:id, "ctl00_conteudo_lblID").text
	puts("Car sendo gerado... Número do Protocolo: " + numProtocolo)
	find(:id, "__tab_ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDeclaracao").click
	find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDeclaracao_carDeclaracao_gvConsulta_ctl07_chkDeclara").click
	InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico") # cpf da maracs
	InsereDados.InserePessoa(cpfPessoa = "32660716897", permissao = "Representante") #cpf da leilacm
	InsereDados.AnexaProcuracao
	InsereDados.DesenhaPropriedade
	InsereDados.NaoExiste(link)
	InsereDados.DesenhaUC(usuario)
	InsereDados.final
end

Então("o sistema criará o CAR") do
	@numCar = find(:id, "ctl00_conteudo_lblCAR").text
	puts("CAR Excedente criado com sucesso no ambiente de Teste e seu número é: " +  @numCar)
end