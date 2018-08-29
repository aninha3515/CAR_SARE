class RealizaBusca
    def RealizaBusca.CAR(numCar)
        select("Número do CAR", :from => "ctl00_conteudo_ctl00_SqlWhere_fields")
        fill_in("onetext_1", with:  numCar, :match => :prefer_exact)
        click_button("Adiciona")
        first(:link, "Pesquisar").click
    end

    def RealizaBusca.Sare(numeroSare)
        select("Número SARE", :from => "ctl00_conteudo_ctl00_SqlWhere_fields")
        fill_in("onetext_1", with:  numeroSare, :match => :prefer_exact)
        click_button("Adiciona")
        choose("Todas Unidades")
        first(:link, "Pesquisar").click
    end
end