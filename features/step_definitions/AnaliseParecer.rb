require 'faker'
usuario = "55613853720"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sigam-adequacao-test/"
#link = "http://exec-dev01.sma.local/sigam-homologacao1"
#link = "http://exec-dev01.sma.local/sigam-adequacao-testS3/"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"

Dado("que o CAR esteja como Inscrito") do
   visit(link)
   RealizaLogin.acesso(usuario)
   InsereDados.inicio(nomeCAR = "Def GW Fazenda " +  Faker::Name.first_name)
	InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico")
	InsereDados.InserePessoa(cpfPessoa = "03416907833", permissao = "Representante")
	InsereDados.AnexaProcuracao
	InsereDados.DesenhaPropriedade
	InsereDados.NaoExiste(link)
    InsereDados.final
    @numCar = find(:id, "ctl00_conteudo_lblCAR").text
	puts("CAR Deficitário criado com sucesso no ambiente de homologação e seu número é: " +  @numCar)
  end
  
  Quando("preencher todas as informações da aba Parecer") do
    RealizaLogin.logoff
    RealizaLogin.acesso(usuario = "karinaac")
    first(".Atendimento", text: "SiCAR/SP", visible: true).click
    find(:link, "Consulta Gerencial").click
    select("Número do CAR", :from => "ctl00_conteudo_ctl00_SqlWhere_fields")
    fill_in("onetext_1", with:  @numCar, :match => :prefer_exact)
    click_button("Adiciona")
    first(:link, "Pesquisar").click
    first(:link, "Analisar").click
    first(:link, "Iniciar Análise").click
    first(:link, "Sim").click
    find("[title='Parecer']").click


    check("Propriedade")
    check("Mapa")

    check("Compromissos Anteriores")
    check("Reserva Legal")

    click_link("Alterar liberação de abas")
    find("[id*=cmdLiberacaoAbas]").click


    #textos das abas

        infoBasicas1 = "Os proprietários e posseiros declarados parecem estar corretos e parecem ser os reais ocupantes do espaço?"
        infoBasicas2 = "O tipo de dominio foi corretamente declarado como propriedade e/ou posse?"
        infoBasicas3 = "A área declarada da propriedade na data de 22 de julho de 2008 parece estar corretamente informada, inexistindo evidências de desmembramento após 2008 que implique na mudança do enquadramento das obrigações do Programa de Regularização Ambiental para o imóvel em questão?"
        infoBasicas4 = "As declarações assinaladas, inclusive a referente à utilização principal da propriedade, parecem estar corretas e refletir as reais características do imóvel rural?"
        infoBasicas5 = "As informações relativas a espólio e/ou usufruto declarados parecem estar corretas?"
        infoBasicas6 = "O imóvel aparenta ter sido corretamente declarado como urbano ou rural?"
        infoBasicas7 = "Todos os campos obrigatórios foram preenchidos corretamente?"
        infoBasicas8 = "As informações e documentos apresentados no presente cadastro estão corretos, adequados e completos?"


        Limite1 = "O limite da propriedade parece refletir a realidade de acordo com a imagem e/ou com a área declarada, e/ou com documentação apresentada pelo proprietário e/ou produzida pela SMA?" 	
        Limite2 = "Eventuais servidões administrativas parecem estar corretamente demarcadas?"	 	
        Limite3 = "A área declarada e a área constante no mapa são suficientemente aproximadas?"

        App1 =  "Todos os corpos d'água parecem estar corretamente demarcados, de acordo com a imagem e com outras fontes de informação disponíveis?"
        App2 = 	"Todas as informações associadas aos corpos d'água declarados (largura de rios, tipo de corpo d'água) parecem estar adequadas em relação à imagem?"
        App3 = 	"As APPs de rios, córregos e nascentes foram geradas/demarcadas conforme determinado em legislação?"
        App4 = 	"Eventuais APPs de Outros Corpos d'Água, Declividade, Topo de Morro, Borda de Tabuleiro ou Chapada, Altitude, Manguezal, Restinga e outras parecem estar corretamente demarcadas?"
        App5 = 	"Os limites e usos das áreas de Uso Consolidado em APP declaradas parecem estar adequados em relação à imagem base de 2008 e outros materiais de referência disponíveis?"
        App6 = 	"Eventuais áreas de Declividade entre 25° e 45° parecem estar corretamente demarcadas?"
        App7 = 	"Os limites e o uso declarado das áreas de Uso Consolidado em Áreas de Declividade entre 25° e 45° parecem estar adequados em relação à imagem base de 2012?"
        App8 = 	"Os limites e uso das áreas de Uso Consolidado declaradas em RL parecem estar adequados em relação à imagem base de 2008?"
        
        VegetNativa1 = "Todos os fragmentos de vegetação nativa parecem ter sido corretamente demarcados de acordo com as imagens disponíveis?"
        VegetNativa2 = "Durante a análise com os materiais disponíveis, a vegetação nativa existente em 2008 parece ter sido mantida, de acordo com a legislação pertinente?"

        rlFinal = "A área total de RL instituída ou proposta sob todas as formas alcança os percentuais mínimos definidos na legislação para o imóvel em questão, e sua localização, forma de instituição e projetos de restauração ecológica foram aprovados?"


        AdeqFinal1 = "O(a) responsável selecionou a opção ‘Adequação Conforme Lei 4771/65 na aba Passivos Ambientais?"
        AdeqFinal2 = "O(a) responsável selecionou a opção de adesão ao PRA na aba Passivos Ambientais e o imóvel não possui áreas a recompor?"
        AdeqFinal3 = "O(a) responsável selecionou optou por não aderir ao PRA e o imóvel não possui áreas a recompor?"


        Nao = "Não Se Aplica"

        marcaNao = find(".ModuloItem", text: infoBasicas1).choose(Nao)

        marcaNao = find(".ModuloAlternado", text: infoBasicas2).choose(Nao)

        marcaNao = find(".ModuloItem", text: infoBasicas3).choose(Nao)

        marcaNao = find(".ModuloAlternado", text: infoBasicas4).choose(Nao)

        
        marcaNao = find(".ModuloItem", text: infoBasicas5).choose(Nao)

        marcaNao = find(".ModuloAlternado", text: infoBasicas6).choose(Nao)

        marcaNao = find(".ModuloItem", text: infoBasicas7).choose(Nao)

        marcaNao = find(".ModuloAlternado", text: infoBasicas8).choose(Nao)

        find(:link, "Limite da Propriedade e Servidão Administrativa").click

        marcaNao = find(".ModuloItem", text: Limite1).choose(Nao)

        marcaNao = find(".ModuloAlternado", text: Limite2).choose(Nao)

        marcaNao = find(".ModuloItem", text: Limite3).choose(Nao)

        find(:link, "APP e Uso Restrito").click

        marcaNao = find(".ModuloItem", text: App1).choose(Nao)

        marcaNao = find(".ModuloAlternado", text: App2).choose(Nao)

        marcaNao = find(".ModuloItem", text: App3).choose(Nao)

        marcaNao = find(".ModuloAlternado", text: App4).choose(Nao)
        
        marcaNao = find(".ModuloItem", text: App5).choose(Nao)
    
        marcaNao = find(".ModuloAlternado", text: App6).choose(Nao)
        
        marcaNao = find(".ModuloItem", text: App7).choose(Nao)
    
        marcaNao = find(".ModuloAlternado", text: App8).choose(Nao)

        find(:link, "Vegetação Nativa").click
        
        marcaNao = find(".ModuloItem", text: VegetNativa1).choose(Nao)
    
        marcaNao = find(".ModuloAlternado", text: VegetNativa2).choose(Nao)

        find(:link, "RL").click

        find(:link, "RL Final").click
    
        marcaNao = find(".ModuloItem", text: rlFinal).choose(Nao)

        find(:link, "Adequação Final").click

        marcaNao = find(".ModuloItem", text: AdeqFinal1).choose(Nao)
    
        marcaNao = find(".ModuloAlternado", text: AdeqFinal2).choose(Nao)

        marcaNao = find(".ModuloItem", text: AdeqFinal3).choose(Nao)

        find(:link, "Salvar respostas do Parecer").click
  end
  
  Então("o CAR estará disponível para analisar") do

    find(:link, "Iniciar/Concluir Análise").click
    
    find(:link, "Verificar Problemas").click

    verificaProblema = find("#ctl00_conteudo_TabContainer1_TBIniciar_carAnalise_lblMensagem", visible:true).text

    if verificaProblema == "Análise verificado com sucesso! Nenhum problema Encontrado!"
        puts(verificaProblema)
        @numCar = find(:id, "ctl00_conteudo_lblCAR").text
        puts("CAR Deficitário de número: " +  @numCar + " disponível para análise")
    else
        puts("Algo deu errado!, acesse o CAR " + @numCar + " para verificar")
    end


  end
  