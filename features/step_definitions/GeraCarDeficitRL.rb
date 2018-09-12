require 'faker'
usuario = "55613853720"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sigam-adequacao-test/"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

Dado("que esteja criando o CAR deficitario") do
    #visit(link)
    #RealizaLogin.acesso(usuario)
    #InsereDados.inicio(nomeCAR = "Def GW RL Fazenda " +  Faker::Name.first_name, muni = "ILHABELA")
	#InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico") # cpf da maracs
	#InsereDados.InserePessoa(cpfPessoa = "32660716897", permissao = "Representante") #cpf da leilacm
	#InsereDados.AnexaProcuracao
end
  
Quando("Desenhar os polígonos de RL") do
    #InsereDados.DesenhaPropriedade
    #Desenha.Informacoes(tipo = 'ReservaLegal',  coordenadas = [557,261,575,231,605,263,561,264])
    #InsereDados.NaoExiste(link, artigo = "Def_RL")
    #InsereDados.final(possuiAreas = "")
    #@numCarDeficitario = find(:id, "ctl00_conteudo_lblCAR").text
    @numCarDeficitario = "35204000329611"
    #puts("CAR Deficitário RL criado com sucesso no ambiente " + link + " e seu número é: " +  @numCarDeficitario)
    #RealizaLogin.logoff
end
  
Então("o CAR estará com deficit de RL") do
    visit(link)
    RealizaLogin.acesso(usuario)
    InsereDados.inicio(nomeCAR = "Exc GW RL Fazenda " +  Faker::Name.first_name,  muni = "ALTAIR")
	InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico") # cpf da maracs
	InsereDados.InserePessoa(cpfPessoa = "32660716897", permissao = "Representante") #cpf da leilacm
    InsereDados.AnexaProcuracao
    Desenha.Importa(tipoImportacao = "Propriedade")
    Desenha.Importa(tipoImportacao = "ReservaLegal")
    Desenha.Importa(tipoImportacao = "RLCompensacao")
    Desenha.Importa(tipoImportacao = "ServidaoAmb")
    InsereDados.NaoExiste(link, artigo = "Exc_RL")
    InsereDados.final(possuiAreas = "RL")
    @numCarExcedente = find(:id, "ctl00_conteudo_lblCAR").text
    puts("CAR Excedente de RL criado com sucesso no ambiente " + link + " e seu número é: " +  @numCarExcedente)
    InsereDados.SolicitaAlteracao
    InsereDados.VinculaCAR(numCarDeficitario = @numCarDeficitario)
    puts("O car deficitário de número " + @numCarDeficitario + " foi vinculado no car Excedente: " + @numCarExcedente)
end