require 'faker'
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sigam-adequacao-test/"
link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/"
#link = "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

usuario = "55613853720"
Dado("que esteja tela de cadastro do Sare") do
   visit(link)
   RealizaLogin.acesso(usuario)
   find(:id,"ctl00_lnkLogo").click
   find("[src='imagens/logo/SARE.png']").click
   find(:id, "ctl00_conteudo_ctl00_rptrMenu_ctl00_imgLogo").click
  end
  
  Quando("preencher todos os campos do projeto") do
    PreencheSare.CadastroInicial(nomeSare = "Projeto GW " +  Faker::Name.first_name, link)
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Compromissário", tipoPessoa = "Jurídica")
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Compromissário", tipoPessoa = "Física")
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Representante legal", tipoPessoa = "Física")
    #PreencheSare.DesenhaPropSare
    #PreencheSare.InsereCamposProp
    #PreencheSare.NaoExiste
    #PreencheSare.DesenhaRestauracao
    RealizaLogin.logoff
    RealizaLogin.acesso(usuario = "karinaac")
    PreencheSare.RetornaSare
    PreencheSare.AlteraSituacao(usuario = "karinaac")
    PreencheSare.GeraTermo(usuario = "karinaac" ,tipoTermo = "TCRE")
  end
  Então("o sistema criará o Projeto SARE") do
    numeroSare = find(:id, "ctl00_conteudo_lblNumeroSARE").text
    puts("Termo: " + numeroSare + " Gerado no link: " + link)
  end