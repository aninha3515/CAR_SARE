require 'faker'
usuario = "55613853720"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"


Dado("que possua um CAR com áreas a recompor") do
    visit(link)
    RealizaLogin.acesso(usuario)
    InsereDados.inicio(nomeCAR = "PRADA GW Fazenda " +  Faker::Name.first_name,  muni = "ALTAIR")
	InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico") # cpf da maracs
	InsereDados.InserePessoa(cpfPessoa = "32660716897", permissao = "Representante") #cpf da leilacm
    InsereDados.AnexaProcuracao
    Desenha.Importa(tipoImportacao = "Propriedade")
    Desenha.Importa(tipoImportacao = "ReservaLegal")
    InsereDados.NaoExiste(link, artigo = "PRADA")
    InsereDados.final(possuiAreas = "")
    
end
  
Quando("finalizar o cadastro do CAR") do
    @numCarPrada = find(:id, "ctl00_conteudo_lblCAR").text
    puts("CAR com Prada criado com sucesso no ambiente " + link + " e seu número é: " +  @numCarPrada)
end

E("finalizar a adequação ambiental") do
    first("[id*='AdequacaoAmbiental']", visible: true).click
    PreencheAdequacao.compromissosAnteriores
    PreencheAdequacao.PassivosAmbientais
    PreencheAdequacao.Finalizar
end

Então("o sistema irá gerar CAR com projeto PRADA") do
   
end