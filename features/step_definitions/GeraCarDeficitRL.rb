require 'faker'
usuario = "03416907833"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

Dado("que esteja cadastrando o car com deficit de Rl") do
    visit(link)
    RealizaLogin.acesso(usuario)
    InsereDados.inicio(nomeCAR = "Def GW RL SV Fazenda " +  Faker::Name.first_name, muni = "ILHABELA")
    InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico") # cpf da maracs
    InsereDados.InserePessoa(cpfPessoa = "32660716897", permissao = "Representante") #cpf da leilacm
    InsereDados.AnexaProcuracao
    InsereDados.DesenhaPropriedade
  end
  
  Quando("desenhar a Reserva Legal menor que {int}%") do |int|
    Desenha.Informacoes(tipo = 'ReservaLegal',  coordenadas = [557,261,575,231,605,263,561,264])
    InsereDados.NaoExiste(link, artigo = "Def_RL")
    InsereDados.final(possuiAreas = "")
  end
  
  Então("o car será deficitário de Reserva Legal") do
    @numCarDeficitario = find(:id, "ctl00_conteudo_lblCAR").text
    puts("CAR Deficitário RL criado com sucesso no ambiente " + link + " e seu número é: " +  @numCarDeficitario)
  end
  