require 'faker'
usuario = "55613853720"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

Dado("que esteja cadastrando o car Excedente de Rl") do
    visit(link)
    RealizaLogin.acesso(usuario)
    InsereDados.inicio(nomeCAR = "Exc GW RL SV Fazenda " +  Faker::Name.first_name,  muni = "ALTAIR")
  	InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico") # cpf da maracs
  	InsereDados.InserePessoa(cpfPessoa = "32660716897", permissao = "Representante") #cpf da leilacm
    InsereDados.AnexaProcuracao
  end
  
  Quando("desenhar a Reserva Legal maior que {int}%") do |int|
    Desenha.Importa(tipoImportacao = "Propriedade")
    Desenha.Importa(tipoImportacao = "ReservaLegal")
    Desenha.Importa(tipoImportacao = "RLCompensacao")
    Desenha.Importa(tipoImportacao = "ServidaoAmb")
    InsereDados.NaoExiste(link, artigo = "Exc_RL")
    InsereDados.final(possuiAreas = "RL")
  end
  
  Então("o car será Excedente de Reserva Legal") do
    @numCarExcedente = find(:id, "ctl00_conteudo_lblCAR").text
    puts("CAR Excedente de RL criado com sucesso no ambiente " + link + " e seu número é: " +  @numCarExcedente)
  end