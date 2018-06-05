require 'faker'
usuario = "55613853720"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sigam-adequacao-test/"

Dado("que esteja cadastrando o CAR") do                                      
    visit(link)
    RealizaLogin.acesso(usuario)
    InsereDados.inicio(nomeCAR = "Exc Fazenda " +  Faker::Name.first_name)
end                                                                          
                                                                               
  Quando("preencher todos os campos") do                                       
    numProtocolo = find(:id, "ctl00_conteudo_lblID").text
    puts("Car sendo gerado... Número do Protocolo: " + numProtocolo)
    find(:id, "__tab_ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDeclaracao").click
    find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDeclaracao_carDeclaracao_gvConsulta_ctl07_chkDeclara").click
    InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico") # cpf da maracs
    InsereDados.InserePessoa(cpfPessoa = "32660716897", permissao = "Representante") #cpf da leilacm
    InsereDados.AnexaProcuracao
  end                                                                          
                                                                               
  E("realizar todos os desenhos") do                                      
    InsereDados.DesenhaPropriedade
    Desenha.Informacoes(tipo = 'ServidaoAdm', pt1x = 754, pt1y = 355, pt2x = 769, pt2y = 315, pt3x = 786 , pt3y = 346, pt4x = 749 , pt4y = 353)
    Desenha.Informacoes(tipo = 'RiosMais', pt1x = 468, pt1y = 216, pt2x = 514, pt2y = 205, pt3x = 513 , pt3y = 232, pt4x = 466 , pt4y = 219)
    Desenha.Informacoes(tipo = 'RiosMedia', pt1x = 758 , pt1y = 237, pt2x = 789 , pt2y = 177, pt3x = 832 , pt3y = 229, pt4x = 758 , pt4y = 241)
    Desenha.Informacoes(tipo = 'Nascente', pt1x = 645 , pt1y = 217, pt2x = 665 , pt2y = 182, pt3x = 687 , pt3y = 223 , pt4x = 645 , pt4y = 220)
    Desenha.Informacoes(tipo = 'LagoLagoa', pt1x = 781 , pt1y = 184, pt2x = 787 , pt2y = 154, pt3x = 810 , pt3y = 174 , pt4x = 782 , pt4y = 185)
    Desenha.Informacoes(tipo = 'OutrosCorpos', pt1x = 814 , pt1y = 345, pt2x = 815 , pt2y = 319, pt3x = 840 , pt3y = 341 , pt4x = 816 , pt4y = 350)
    Desenha.Informacoes(tipo = 'OutrasApps', pt1x = 643 , pt1y = 273, pt2x = 665 , pt2y = 248, pt3x = 682 , pt3y = 283 , pt4x = 646 , pt4y = 277)
    Desenha.Informacoes(tipo = 'Vegetacao', pt1x = 721 , pt1y = 293 , pt2x = 730 , pt2y = 258, pt3x = 753 , pt3y = 293 , pt4x = 720 , pt4y = 296)
    Desenha.Informacoes(tipo = 'ReservaLegal', pt1x = 557 , pt1y = 261 , pt2x = 575 , pt2y = 231 , pt3x = 605 , pt3y = 263 , pt4x = 561 , pt4y = 264)
    Desenha.Informacoes(tipo = 'Declividade', pt1x = 794 , pt1y = 368 , pt2x = 800 , pt2y = 347 , pt3x = 832 , pt3y = 362 , pt4x = 796 , pt4y = 371)
    Desenha.Informacoes(tipo = 'UsoConsolidado', pt1x = 794 , pt1y = 368 , pt2x = 800 , pt2y = 347 , pt3x = 832 , pt3y = 362 , pt4x = 796 , pt4y = 371)
    Desenha.Informacoes(tipo = 'RLCompensacao', pt1x = 782 , pt1y = 284 , pt2x = 797 , pt2y = 255 , pt3x = 824 , pt3y = 281 , pt4x = 779 , pt4y = 279)
    Desenha.Informacoes(tipo = 'ServidaoAmb', pt1x = 717 , pt1y = 208 , pt2x = 715 , pt2y = 161 , pt3x = 758 , pt3y = 181 , pt4x = 718 , pt4y = 211)
    Desenha.Informacoes(tipo = 'AreaEmUC', pt1x = 664 , pt1y = 319 , pt2x = 644 , pt2y = 297 , pt3x = 674 , pt3y = 297 , pt4x = 662 , pt4y = 320)
   
  end                                                                          
                                                                               
  Então("o sistema criará o CAR completo") do                                
    InsereDados.final
    @numCar = find(:id, "ctl00_conteudo_lblCAR").text
	  puts("CAR Excedente criado com sucesso no ambiente de Teste e seu número é: " +  @numCar)
  end                                                                          