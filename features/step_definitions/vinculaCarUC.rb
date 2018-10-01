require 'faker'
usuario = "55613853720"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"
visit(link)

Dado("que possua CAR Deficitário de UC") do
    visit(link)
    RealizaLogin.acesso(usuario)
    InsereDados.inicio(nomeCAR = "Def GW SemUC Vinc Fazenda " +  Faker::Name.first_name,  muni = "ILHABELA")
	InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico")
	InsereDados.InserePessoa(cpfPessoa = "03416907833", permissao = "Representante")
	InsereDados.AnexaProcuracao
	InsereDados.DesenhaPropriedade
	InsereDados.NaoExiste(link, artigo = "")
    InsereDados.final(possuiAreas = "")
    @numCarDeficitUC = find(:id, "ctl00_conteudo_lblCAR").text
    puts("CAR Deficitário criado com sucesso no ambiente " + link + " e seu número é: " +  @numCarDeficitUC)
    RealizaLogin.logoff
end
  
Dado("Excedente de UC") do
    visit(link)
    RealizaLogin.acesso(usuario)
    InsereDados.inicio(nomeCAR = "Exc GW UC Vinc Fazenda " +  Faker::Name.first_name,  muni = "ILHABELA")
	find(:id, "__tab_ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDeclaracao").click
	find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDeclaracao_carDeclaracao_gvConsulta_ctl07_chkDeclara").click
	InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico") # cpf da maracs
	InsereDados.InserePessoa(cpfPessoa = "32660716897", permissao = "Representante") #cpf da leilacm
	InsereDados.AnexaProcuracao
	InsereDados.DesenhaPropriedade
	InsereDados.NaoExiste(link, artigo = "")
	InsereDados.DesenhaUC(usuario)
    InsereDados.final(possuiAreas = "")
    @numCarExcedenteUC = find(:id, "ctl00_conteudo_lblCAR").text
    puts("CAR Excedente criado com sucesso no link " + link + " e seu número é: " +  @numCarExcedenteUC)
end
  
Quando("realiazar o vínculo de UC") do
    puts("Car Defícitário = " + @numCarDeficitUC)
    puts("Car Excedente = " + @numCarExcedenteUC)
    textoAreaEmUC = "Área Inserida em UC"
    RealizaLogin.logoff
    RealizaLogin.acesso(usuario = "marianab")
    InsereDados.AlteraProcessoAptidao(usuario = "marianab", numCar = @numCarExcedenteUC)
    RealizaLogin.logoff
    RealizaLogin.acesso(usuario = "55613853720")
    first(".Atendimento", text: "SiCAR/SP", visible: true).click

    RealizaBusca.CarUsuarioExterno(numCar = @numCarExcedenteUC)
    first(:link, "Consultar").click
    InsereDados.SolicitaAlteracao(alteracao = "UC")
    find(:link, "Mapa").click
    flegaArea = find('.ModuloItem', text: textoAreaEmUC)
    flegaArea.first(:css, 'a[href]').click
  
    InsereDados.VinculaUC(numCarDef = @numCarDeficitUC)
    find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBFinaliza_spanFinalizar").click
	find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBFinaliza_carFinaliza_cmdFinaliza").click
    sleep(5)
    Desenha.verificaPopUp
    Desenha.verificaPopUp
end
  
Então("o sistema irá apresentar os CARs UC vinculados") do
    puts("CAR Deficitário: " + @numCarDeficitUC + " vinculado ao CAR: " + @numCarExcedenteUC)        
end
