require 'faker'
usuario = "55613853720"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

Dado("que possua termo na situacao disponível para asssinatura") do
    visit(link)
    RealizaLogin.acesso(usuario)
    PreencheSare.AcessaCadastraProjetos
    PreencheSare.CadastroInicial(nomeSare = "Projeto GW " +  Faker::Name.first_name, link)
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Compromissário", tipoPessoa = "Jurídica")
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Compromissário", tipoPessoa = "Física")
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Representante legal", tipoPessoa = "Física")
    #PreencheSare.DesenhaPropSare
    #PreencheSare.InsereCamposProp
    #PreencheSare.NaoExiste
    #PreencheSare.DesenhaRestauracao
    numeroSare = find(:id, "ctl00_conteudo_lblNumeroSARE").text
    @numeroSareGlobal = numeroSare
    puts("Projeto: " + numeroSare + " Gerado no link: " + link)
    RealizaLogin.logoff
    RealizaLogin.acesso(usuario = "karinaac")
    PreencheSare.RetornaSare
    PreencheSare.AlteraSituacao(usuario = "karinaac")
    PreencheSare.GeraTermo(usuario = "karinaac" ,tipoTermo = "TCRE")
    sleep(3)
    termoGrid = find("#ctl00_conteudo_TabNavegacao_TBTermo_sareTermo_TabNavegacaoTermo_TBSubTermos_gvPesquisa > tbody > tr.ModuloItem > td:nth-child(6)").text
    numTermoConvertido = termoGrid.sub(/TCRE nº /, '')
    SareTermos.AbaArquivos(numTermoConvertido,tipoAnexo = "TermoOrgaoEmissor")
    SareTermos.SituacaoTermo(sitAlterada = "DispAssinatura")
end
  
Quando("o prazo para assinatura vencer") do
   numeroSare = find(:id, "ctl00_conteudo_lblNumeroSARE").text
   idProjeto = numeroSare
   ConectaBanco.acesso
   ConectaBanco.alteraPrazoAssinatura(idProjeto)
end
  
Então("o sistema deverá alterar o termo para suspenso") do
    RealizaLogin.logoff
    ExecutaRobo.SuspendeTermo
    visit(link)
    RealizaLogin.acesso(usuario = "55613853720")
    PreencheSare.AcessaMeusProjetos
    numeroSare = @numeroSareGlobal
    RealizaBusca.SareUsuarioExt(numeroSare)
    SareTermos.SituacaoTermo(sitAlterada = "suspenso")
end