Dado("que esteja na tela de login") do
    visit("http://exec-dev01.sma.local/SMA-EST-CAR_test/")
    find('.Login').click
  end
  
  Quando("informar {string} válido") do |string|
    fill_in('username', :with => string)
  end
  
  E("inserir {string} válida") do |string|
    fill_in('password', :with => string)
  end
  
  Então("o sistema deve permitir a autenticação do usuário") do
    find(:id, "login").click
    sleep(2)
    find(:id, "ctl00_cmdLogin").click
    find(:link, "aqui").click
    sleep(2)
  end
  
  Dado("que esteja na tela de login do sistema") do
    visit("http://exec-dev01.sma.local/SMA-EST-CAR_test/")
    find('.Login').click
  end
  
  Quando("informar {string} inválido") do |string|
    fill_in('username', :with => string)
  end
  
  E("inserir {string} inválida") do |string|
    fill_in('password', :with => string)
  end

  Então("o sistema não deve permitir a autenticação do usuário") do
    find(:id, "login").click
    resultado = assert_text("Erro: Nome de usuário ou senha inválido")
      if (resultado)
          puts("Erro: Nome de usuário ou senha inválido")
      end
  end