require 'faker'
usuario = "03416907833"
link = "http://exec-dev01.sma.local/sigam-adequacao-test/"
#link = "http://exec-dev01.sma.local/SMA-EST-CAR_test/"
Dado("que esteja na tela do CAR") do
	visit(link)
	RealizaLogin.acesso(usuario)
end
Quando("preencher todas as informações necessarias") do
	InsereDados.inicio(nomeCAR = "Exc Fazenda " +  Faker::Name.first_name)
end
Então("o sistema criará o CAR UC em Homlog") do
	find(:id, "__tab_ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDeclaracao").click
	find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDeclaracao_carDeclaracao_gvConsulta_ctl07_chkDeclara").click
	InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico")
	InsereDados.InserePessoa(cpfPessoa = "03416907833", permissao = "Representante")
	InsereDados.AnexaProcuracao
	InsereDados.DesenhaPropriedade
	InsereDados.NaoExiste
	InsereDados.DesenhaUC(usuario)
	InsereDados.final
	@numCar = find(:id, "ctl00_conteudo_lblCAR").text
	puts("CAR Excedente criado com sucesso e seu número é: " +  @numCar)
end