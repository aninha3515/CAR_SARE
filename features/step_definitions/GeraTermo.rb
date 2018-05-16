require 'faker'
#link = "http://exec-dev01.sma.local/sigam-adequacao-test"
#link = "http://exec-dev01.sma.local/sigam-homologacao1"
link = "http://exec-dev01.sma.local/sma-est-car_test/"

usuario = "karinaac"
Dado("que esteja tela de cadastro do Sare") do
   visit(link)
   RealizaLogin.acesso(usuario)
   find(:id,"ctl00_lnkLogo").click
   find("[src='imagens/logo/SARE.png']").click
   find(:id, "ctl00_conteudo_ctl00_rptrMenu_ctl00_imgLogo").click
  end
  
  Quando("preencher todos os campos do projeto") do
    PreencheSare.CadastroInicial(nomeSare = "Projeto " +  Faker::Name.first_name, link)
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Compromissário", tipoPessoa = "Jurídica")
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Compromissário", tipoPessoa = "Física")
    PreencheSare.Pessoa(nomPessoa = Faker::Name.name , funcaoPessoa = "Representante legal", tipoPessoa = "Física")
    PreencheSare.AlteraSituacao(usuario)
    PreencheSare.GeraTermo(usuario,tipoTermo = "TCRE")
    PreencheSare.DesenhaPropSare
    PreencheSare.InsereCamposProp
    PreencheSare.NaoExiste
    #PreencheSare.DesenhaRestauracao
  end
  Então("o sistema criará o Projeto SARE") do
    #
  end