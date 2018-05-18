require 'faker'
usuario = "55613853720"
#link = "http://exec-dev01.sma.local/SMA-EST-CAR_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sigam-adequacao-test/"
#link = "http://exec-dev01.sma.local/sigam-homologacao1"

Dado("que esteja preenchendo o cadastro do CAR") do
	visit(link)
	RealizaLogin.acesso(usuario)
end

Quando("preencher todas as informações requeridas") do
	InsereDados.inicio(nomeCAR = "Def Fazenda " +  Faker::Name.first_name)
	InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico")
	InsereDados.InserePessoa(cpfPessoa = "03416907833", permissao = "Representante")
	InsereDados.AnexaProcuracao
	InsereDados.DesenhaPropriedade
	InsereDados.NaoExiste(link)
end

Então("o sistema criará o CAR sem UC em Homlog") do
	InsereDados.final
	@numCar = find(:id, "ctl00_conteudo_lblCAR").text
	puts("CAR Deficitário criado com sucesso no ambiente de homologação e seu número é: " +  @numCar)	
end