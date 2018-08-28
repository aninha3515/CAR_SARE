require 'faker'
usuario = "55613853720"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sigam-adequacao-test/"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

Dado("que o CAR esteja como Inscrito") do
    visit(link)
    RealizaLogin.acesso(usuario)
    InsereDados.inicio(nomeCAR = "Def GW Fazenda " +  Faker::Name.first_name)
    InsereDados.InserePessoa(cpfPessoa = "88258394800", permissao = "Tecnico")
    InsereDados.InserePessoa(cpfPessoa = "03416907833", permissao = "Representante")
    InsereDados.AnexaProcuracao
    InsereDados.DesenhaPropriedade
    InsereDados.NaoExiste(link, artigo = "")
    InsereDados.final
    @numCar = find(:id, "ctl00_conteudo_lblCAR").text
    puts("CAR Deficitário criado com sucesso no ambiente de homologação e seu número é: " +  @numCar)
  end
  
  Quando("preencher todas as informações da aba Parecer") do
    RealizaLogin.logoff
    RealizaLogin.acesso(usuario = "karinaac")
    first(".Atendimento", text: "SiCAR/SP", visible: true).click
    find(:link, "Consulta Gerencial").click
    RealizaBusca.CAR(@numCar)
    AnaliseParec.IniciaAnalise
    AnaliseParec.LiberaAbas
    naoAplica = "Não Se Aplica"
    AnaliseParec.RespInfoBasicas(naoAplica)
    AnaliseParec.RespLimite(naoAplica)
    AnaliseParec.App(naoAplica)
    AnaliseParec.VegetNativa(naoAplica)
    AnaliseParec.ReservaLegal(naoAplica)
    AnaliseParec.AdeqFinal(naoAplica)
    AnaliseParec.Salva

  end
  
  Então("o CAR estará disponível para analisar") do
    AnaliseParec.ConcluiAnalise(@numCar)
  end