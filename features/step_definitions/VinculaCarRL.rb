require 'faker'
usuario = "03416907833"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

Dado("que possua um CAR deficitário") do
    visit(link)
    RealizaLogin.acesso(usuario)
    InsereDados.inicio(nomeCAR = "Def GW RL Fazenda " +  Faker::Name.first_name, muni = "ILHABELA")
	InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico") # cpf da maracs
	InsereDados.InserePessoa(cpfPessoa = "32660716897", permissao = "Representante") #cpf da leilacm
    InsereDados.AnexaProcuracao
    InsereDados.DesenhaPropriedade
    Desenha.Informacoes(tipo = 'ReservaLegal',  coordenadas = [557,261,575,231,605,263,561,264])
    InsereDados.NaoExiste(link, artigo = "Def_RL")
    InsereDados.final(possuiAreas = "")
    @numCarDeficitario = find(:id, "ctl00_conteudo_lblCAR").text
    puts("CAR Deficitário RL criado com sucesso no ambiente " + link + " e seu número é: " +  @numCarDeficitario)
    InsereDados.ObtemDeficit
    RealizaLogin.logoff
end
  
E("um CAR Excedente") do
    visit(link)
    RealizaLogin.acesso(usuario = "55613853720")
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
end
  
Quando("realizar o vínculo") do
    InsereDados.SolicitaAlteracao(alteracao = "")
    InsereDados.VinculaCAR(numCarDeficitario = @numCarDeficitario)
end
  
Então("o CAR deficitario estará vinculado ao excedente") do
    puts("O car deficitário de número " + @numCarDeficitario + " foi vinculado no car Excedente: " + @numCarExcedente)
end
  