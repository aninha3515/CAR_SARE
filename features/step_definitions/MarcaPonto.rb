Dado("que esteja na tela inicial") do
 visit("https://portal.globalweb.com.br/#!/_login")
  end
  
  Quando("preencher com meu usuario") do
    find(:xpath, "(//input[@type='text'])[5]").set("LucasGK")
    sleep(5)
    find(:xpath, "//*[@id='table-estrutura']/tbody[1]/tr[1]/td[2]/div[3]/ponto[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[11]/td[2]/button[1]").click
    sleep(5)
  end
  
  E("responder a pergunta corretamente") do
    
    mae = "Qual o primeiro nome da sua mãe?"

    diaContratacao = "Qual o dia da sua contratação?"
    mesContratacao = "Qual o mês da sua contratação?"
    anoContratacao = "Qual o ano da sua contratação?"
   
    
    tresCPF = "Qual os três primeiros números do seu CPF?"
    doisCPF = "Qual os dois últimos números do seu CPF?"
    
    diaNascimento = "Qual o dia do seu nascimento?"
    mesNascimento = "Qual o mês do seu nascimento?"
    anoNascimento = "Qual o ano do seu nascimento?"
    sleep(5)
    
    respostaTela = find(:xpath, "//*[@id='table-estrutura']/tbody/tr/td[2]/div[3]/ponto/div/div[1]/div/div/table/tbody/tr[5]/td[2]").text
    puts(respostaTela)
    if (respostaTela == mae)
      choose("ELAINE")
      sleep(5)
      puts("ELAINE")
    end

    if (respostaTela == anoContratacao)
  
      choose("2017")
      sleep(5)
      puts("2017")
    end

    if (respostaTela == diaContratacao)
      choose("24")
      sleep(5)
      puts("24")
    end

    if (respostaTela == mesNascimento)
      choose("Maio")
      sleep(5)
      puts("Maio")
    end

    if (respostaTela == tresCPF)
      choose("448")
      sleep(5)
      puts("448")
    end

    if (respostaTela == doisCPF)
      choose("57")
      sleep(5)
      puts("57")
    end

    if (respostaTela == anoNascimento)
      choose("1996")
      sleep(5)
      puts("1996")
    end

    if (respostaTela == diaNascimento)
      choose("23")
      sleep(5)
      puts("23")
    end

    if (respostaTela == mesContratacao)
      choose("Abril")
      sleep(5)
      puts("Abril")
    end

  end
  
  Então("o sistema maracará o ponto") do
     find(:xpath, "//*[@id='table-estrutura']/tbody[1]/tr[1]/td[2]/div[3]/ponto[1]/div[1]/div[1]/div[1]/div[1]/table[1]/tbody[1]/tr[11]/td[2]/button[1]").click
  end