require 'faker'
usuario = "55613853720"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sigam-adequacao-test/"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

Dado("que esteja cadastrando o CAR") do                                      
    visit(link)
    RealizaLogin.acesso(usuario)
    InsereDados.inicio(nomeCAR = "Exc GW MapaComp Fazenda " +  Faker::Name.first_name,  muni = "ILHABELA")
end                                                                          
                                                                               
  Quando("preencher todos os campos") do                                       
    find(:id, "__tab_ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDeclaracao").click
    find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDeclaracao_carDeclaracao_gvConsulta_ctl07_chkDeclara").click
    InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico") # cpf da maracs
    InsereDados.InserePessoa(cpfPessoa = "32660716897", permissao = "Representante") #cpf da leilacm
    InsereDados.AnexaProcuracao
  end                                                                          
                                                                               
  E("realizar todos os desenhos") do                                      
    InsereDados.DesenhaPropriedade
    Desenha.Informacoes(tipo = 'ServidaoAdm',   coordenadas = [754,355,769,315,786,346,749,353])
    Desenha.Informacoes(tipo = 'RiosMais',      coordenadas = [468,216,514,205,513,232,466,219])
    Desenha.Informacoes(tipo = 'RiosMedia',     coordenadas = [758,237,789,177,832,229,758,241])
    Desenha.Informacoes(tipo = 'Nascente',      coordenadas = [645,217,665,182,687,223,645,220])
    Desenha.Informacoes(tipo = 'LagoLagoa',     coordenadas = [781,184,787,154,810,174,782,185])
    Desenha.Informacoes(tipo = 'OutrosCorpos',  coordenadas = [814,345,815,319,840,341,816,350])
    Desenha.Informacoes(tipo = 'OutrasApps',    coordenadas = [643,273,665,248,682,283,646,277])
    Desenha.Informacoes(tipo = 'Vegetacao',     coordenadas = [721,293,730,258,753,293,720,296])
    Desenha.Informacoes(tipo = 'ReservaLegal',  coordenadas = [557,261,575,231,605,263,561,264])
    Desenha.Informacoes(tipo = 'Declividade',   coordenadas = [794,368,800,347,832,362,796,371])
    Desenha.Informacoes(tipo = 'UsoConsolidado',coordenadas = [794,368,800,347,832,362,796,371])
    Desenha.Informacoes(tipo = 'RLCompensacao', coordenadas = [782,284,797,255,824,281,779,279])
    Desenha.Informacoes(tipo = 'ServidaoAmb',   coordenadas = [717,208,715,161,758,181,718,211])
    Desenha.Informacoes(tipo = 'AreaEmUC',      coordenadas = [664,319,644,297,674,297,662,320])
  end                                                                          
                                                                               
  Então("o sistema criará o CAR completo") do                                
    InsereDados.final(possuiAreas = "")
    @numCar = find(:id, "ctl00_conteudo_lblCAR").text
	  puts("CAR Excedente criado com sucesso no ambiente " + link + " e seu número é: " +  @numCar)
  end                                                                          