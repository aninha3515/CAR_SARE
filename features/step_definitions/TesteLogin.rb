Dado("que esteja na tela de login") do
    visit("http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/")
    find('.Login').click
  end
  
  Quando("informar {string} válido") do |usuario|
    fill_in('username', :with => usuario)
  end
  
  E("inserir {string} válida") do |senha|
    fill_in('password', :with => senha)
  end
  
  Então("o sistema deve permitir a autenticação do usuário") do
    find(:id, "login").click
    sleep(2)
    find(:id, "ctl00_cmdLogin").click
    find(:link, "aqui").click
    sleep(2)
  end
  
  Dado("que esteja na tela de login do sistema") do
    visit("http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/")
    find('.Login').click
  end
  
  Quando("informar {string} inválido") do |usuario|
    fill_in('username', :with => usuario)
  end
  
  E("inserir {string} inválida") do |senha|
    fill_in('password', :with => senha)
  end

  Então("o sistema não deve permitir a autenticação do usuário") do
    find(:id, "login").click
    resultado = assert_text("Erro: Nome de usuário ou senha inválido")
      if (resultado)
          puts("Mensagem apresentada: Erro: Nome de usuário ou senha inválido")
      end
  end