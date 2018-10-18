require 'faker'
usuario = "55613853720"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

Dado("que possua termo na situacao disponível para asssinatura") do
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
    numeroSare = find(:id, "ctl00_conteudo_lblNumeroSARE").text
    @numeroSareGlobal = numeroSare
    puts("Projeto: " + numeroSare + " Gerado no link: " + link)
    RealizaLogin.logoff
    RealizaLogin.acesso(usuario = "karinaac")
    PreencheSare.RetornaSare
    PreencheSare.AlteraSituacao(usuario = "karinaac")
    PreencheSare.GeraTermo(usuario = "karinaac" ,tipoTermo = "TCRE")
    #Metodo para ober o numero do termo:
    sleep(3)
    termoGrid = find("#ctl00_conteudo_TabNavegacao_TBTermo_sareTermo_TabNavegacaoTermo_TBSubTermos_gvPesquisa > tbody > tr.ModuloItem > td:nth-child(6)").text
    numTermoConvertido = termoGrid.sub(/TCRE nº /, '')
    #Metodo para aba arquivo
    find("[id*='TabNavegacaoTermo_TBAnexo']", visible: true, :match => :first).click
    find("[id*='ucAnexo_cmdAdiciona']").click
    sleep(5)
    tipoanexo = find("[value='191']", visible: true, :match => :first).text
    puts("Situação atual do Termo: " + tipoanexo)
    find("[value='191']", visible:true).click
    select(numTermoConvertido, :from => "ctl00$conteudo$TabNavegacao$TBTermo$sareTermo$TabNavegacaoTermo$TBAnexo$ucAnexo$ddlNumeroDoc")
    find("[id*='desConteudo']").set("Inserindo anexo pelo teste automatizado...")
    attach_file('ctl00$conteudo$TabNavegacao$TBTermo$sareTermo$TabNavegacaoTermo$TBAnexo$ucAnexo$fileUpload$ctl02', File.absolute_path('anexos/Teste.pdf'))
    find("[id*='ucAnexo_cmdAtualiza']").click
    Desenha.verificaPopUp
    sleep(3)
    find("[id*='TBSubTermos']", visible: true, :match => :first).click
    situacaoTermo = find("#ctl00_conteudo_TabNavegacao_TBTermo_sareTermo_TabNavegacaoTermo_TBSubTermos_gvPesquisa > tbody > tr.ModuloItem > td:nth-child(12)").text
    puts("Termo alterado para a situação: " + situacaoTermo)
end
  
Quando("o prazo para assinatura vencer") do
   numeroSare = find(:id, "ctl00_conteudo_lblNumeroSARE").text
   idProjeto = numeroSare
   ConectaBanco.acesso
   ConectaBanco.alteraPrazoAssinatura(idProjeto)
end
  
Então("o sistema deverá alterar o termo para suspenso") do
    RealizaLogin.logoff
    linkRobo = "http://exec-dev01.sma.local/SMA-EST-CAR_test/WebServices/SareTermos.asmx"
    visit(linkRobo)
    find(:link, "Termo_Suspenso").click
    click_button("Invoke")
    sleep(5)
    VerificaAbas.fechaAbas
    visit(link)
    RealizaLogin.acesso(usuario = "55613853720")
    find(:id,"ctl00_lnkLogo").click
    find("[src='imagens/logo/SARE.png']").click
    find(:id, "ctl00_conteudo_ctl00_rptrMenu_ctl01_imgLogo").click
    numeroSare = @numeroSareGlobal
    RealizaBusca.SareUsuarioExt(numeroSare)
    find("[id*='cmdEdita']", visible: true).click
    find("[id*='TBTermo']", visible: true, :match => :first).click
    TermoSuspenso = find("#ctl00_conteudo_TabNavegacao_TBTermo_sareTermo_TabNavegacaoTermo_TBSubTermos_gvPesquisa > tbody > tr.ModuloItem > td:nth-child(9)").text
    puts("Situação do Termo alterada para: " + TermoSuspenso)
end