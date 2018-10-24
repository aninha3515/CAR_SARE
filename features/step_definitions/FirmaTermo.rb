require 'faker'
usuario = "55613853720"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

Dado("que possua projeto no Sare") do
    visit(link)
    RealizaLogin.acesso(usuario)
    find(:id,"ctl00_lnkLogo").click
    find("[src='imagens/logo/SARE.png']").click
    find(:id, "ctl00_conteudo_ctl00_rptrMenu_ctl00_imgLogo").click
    PreencheSare.CadastroInicial(nomeSare = "Projeto GW " +  Faker::Name.first_name, link)
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Compromissário", tipoPessoa = "Jurídica")
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Compromissário", tipoPessoa = "Física")
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Representante legal", tipoPessoa = "Física")
    #PreencheSare.DesenhaPropSare
    #PreencheSare.InsereCamposProp
    #PreencheSare.NaoExiste
    #PreencheSare.DesenhaRestauracao
    @numeroSare = find(:id, "ctl00_conteudo_lblNumeroSARE").text
    puts("Projeto: " + @numeroSare + " Gerado no link: " + link)
    RealizaLogin.logoff
end
  
Quando("Gestor Gerar o Termo") do
    RealizaLogin.acesso(usuario = "karinaac")
    PreencheSare.RetornaSare
    PreencheSare.AlteraSituacao(usuario = "karinaac")
    PreencheSare.GeraTermo(usuario = "karinaac" ,tipoTermo = "TCRE")
end
  
E("anexar os documentos") do
    termoGrid = find("#ctl00_conteudo_TabNavegacao_TBTermo_sareTermo_TabNavegacaoTermo_TBSubTermos_gvPesquisa > tbody > tr.ModuloItem > td:nth-child(6)").text
    numTermoConvertido = termoGrid.sub(/TCRE nº /, '')
    SareTermos.AbaArquivos(numTermoConvertido,tipoAnexo = "TermoOrgaoEmissor")
    SareTermos.SituacaoTermo
    RealizaLogin.logoff
    RealizaLogin.acesso(usuario = "55613853720")
    find(:id,"ctl00_lnkLogo").click
    find("[src='imagens/logo/SARE.png']").click
    find(:id, "ctl00_conteudo_ctl00_rptrMenu_ctl01_imgLogo").click
    RealizaBusca.SareUsuarioExt(@numeroSare)
    find("[id*='cmdEdita']", visible: true).click
    SareTermos.AbaArquivos(numTermoConvertido,tipoAnexo = "DisponivelAssinatura")
end
  
Então("o sistema irá firmar o Termo") do
    situacaoTermo = find("#ctl00_conteudo_TabNavegacao_TBTermo_sareTermo_TabNavegacaoTermo_TBSubTermos_gvPesquisa > tbody > tr.ModuloItem > td:nth-child(9)").text
    puts("Termo alterado para a situação: " + situacaoTermo)
end