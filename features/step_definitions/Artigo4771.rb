require 'faker'
usuario = "55613853720"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sigam-adequacao-test/"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"


Dado("que esteja criando o CAR") do
    visit(link)
	RealizaLogin.acesso(usuario)
    InsereDados.inicio(nomeCAR = "GW 4771 Fazenda " +  Faker::Name.first_name)
	#InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico") # cpf da maracs
	#InsereDados.InserePessoa(cpfPessoa = "32660716897", permissao = "Representante") #cpf da leilacm
	#InsereDados.AnexaProcuracao
end
  
Quando("Desenhar os polígonos para o artigo") do
    InsereDados.DesenhaPropriedadeMenor4
    Desenha.Informacoes(tipo = 'ReservaLegal',  coordenadas = [557,261,575,231,605,263,561,264])
    Desenha.Informacoes(tipo = 'ReservaLegal',    coordenadas = [575,210,577,184,604,201,580,212])
    Desenha.Informacoes(tipo = 'Vegetacao',     coordenadas = [557,261,575,231,605,263,561,264])
    Desenha.Informacoes(tipo = 'OutrasApps',    coordenadas = [643,273,665,248,682,283,646,277])
    Desenha.Informacoes(tipo = 'Vegetacao',     coordenadas = [643,273,665,248,682,283,646,277])
    InsereDados.NaoExiste(link, artigo = "4771")
end
  
Então("o CAR estará disponível com o artigo") do
    binding.pry
    InsereDados.final
end