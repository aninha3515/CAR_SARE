require 'faker'
usuario = "55613853720"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

Dado("que possua Retificacao na situacao Aguarda Assinatura") do
    visit(link)
    RealizaLogin.acesso(usuario)
    PreencheSare.AcessaCadastraProjetos
    PreencheSare.CadastroInicial(nomeSare = "Projeto GW " +  Faker::Name.first_name, link)
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Compromissário", tipoPessoa = "Jurídica")
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Compromissário", tipoPessoa = "Física")
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Representante legal", tipoPessoa = "Física")
    @numeroSare = find(:id, "ctl00_conteudo_lblNumeroSARE").text
    puts("Projeto: " + @numeroSare + " Gerado no link: " + link)
    RealizaLogin.logoff
    RealizaLogin.acesso(usuario = "karinaac")
    PreencheSare.RetornaSare
    PreencheSare.AlteraSituacao(usuario = "karinaac")
    PreencheSare.GeraTermo(usuario = "karinaac" ,tipoTermo = "TCRE")
    termoGrid = find("#ctl00_conteudo_TabNavegacao_TBTermo_sareTermo_TabNavegacaoTermo_TBSubTermos_gvPesquisa > tbody > tr.ModuloItem > td:nth-child(6)").text
    @numTermoConvertido = termoGrid.sub(/TCRE nº /, '')
    SareTermos.AbaArquivos(@numTermoConvertido,tipoAnexo = "TermoOrgaoEmissor")
    SareTermos.SituacaoTermo(sitAlterada = "DispAssinatura")
    RealizaLogin.logoff
    RealizaLogin.acesso(usuario = "55613853720")
    PreencheSare.AcessaMeusProjetos
    RealizaBusca.SareUsuarioExt(@numeroSare)
    SareTermos.AbaArquivos(@numTermoConvertido,tipoAnexo = "DisponivelAssinatura")
    SareTermos.SituacaoTermo(sitAlterada = "firmado")
    RealizaLogin.logoff
    RealizaLogin.acesso(usuario = "karinaac")
    PreencheSare.RetornaSare
    SareRetificacao.GeraRetificacao
    SareRetificacao.SituacaoRetificacao(sitAlterada = "RetificacaoOrgaoEmissor")
    SareRetificacao.AbaArquivos(tipoAnexoRetif = "RetifOrgaoEmissor")
    SareRetificacao.SituacaoRetificacao(sitAlterada = "RetificacaoDisponivelAssinatura")
end
  
Quando("o Prazo de Assinatura do usuario vencer") do
    numRetificacao = find("#ctl00_conteudo_TabNavegacao_TBTermo_sareTermo_TabNavegacaoTermo_TBRetificacao_SareTermoRetificacao_gvPesquisa > tbody > tr.ModuloItem > td:nth-child(6)").text
    numRetificacao = numRetificacao.sub(/0/, '')
    numRetificacao = numRetificacao.sub(/2018/, '')
    numRetificacaoBD = numRetificacao.to_i
    ConectaBanco.acesso
    ConectaBanco.alteraPrazoAssinaturaRetif(numRetificacaoBD)
end
  
E("o robo for executado") do
    RealizaLogin.logoff
    ExecutaRobo.SuspendeRetificacao
end
  
Então("o sistema deverá alterar a situacao da retificacao para Suspensa") do
    visit(link)
    RealizaLogin.acesso(usuario = "55613853720")
    PreencheSare.AcessaMeusProjetos
    RealizaBusca.SareUsuarioExt(@numeroSare)
    SareRetificacao.SituacaoRetificacao(sitAlterada = "RetificacaoSuspensa")
end