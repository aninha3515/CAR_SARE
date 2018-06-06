class Desenha

    def Desenha.Informacoes(tipo,coordenadas)
        
		textoServidaoAdm = "Servidão Administrativa"
		textoRiosMais = "Rios com mais de 3 metros de largura média"
		textoRiosMedia = "Rios com até 3 metros de largura média"
		textoNascente = "Nascentes e Veredas"
		textoOutrosCorpos = "Outros corpos d'água"
		textoOutrasApps = "Outras APPs"
		textoVegetacao = "Vegetação Nativa"
		textoReservaLegal = "Reserva Legal"
		textoDeclividade = "Declividade entre 25° e 45°"
		textoUsoConsolidado = "Uso consolidado"
		textoRLCompensacao = "Reserva Legal de Compensação"
		textoServidaoAmb = "Servidão Ambiental"
        textoLagoLagoa = "Lago e Lagoa Natural"
        textoAreaEmUC = "Área Inserida em UC"

		if tipo == "ServidaoAdm"

		flegaArea = find('.ModuloAlternado', text: textoServidaoAdm)
		flegaArea.find(:css, 'a[href]').click

		end

		if tipo == "RiosMais"
            flegaArea = find('.ModuloAlternado', text: textoRiosMais)
            flegaArea.first(:css, 'a[href]').click
        end
        
        if tipo == "RiosMedia"
            flegaArea = find('.ModuloItem', text: textoRiosMedia)
            flegaArea.first(:css, 'a[href]').click
            
        end

        if tipo == "Nascente" || tipo == "NascenteVereda"
            flegaArea = find('.ModuloAlternado', text: textoNascente)
            flegaArea.first(:css, 'a[href]').click
        end

        if tipo == "LagoLagoa"
            flegaArea = find('.ModuloItem', text: textoLagoLagoa)
            flegaArea.first(:css, 'a[href]').click
        end

        if tipo == "OutrosCorpos"
            flegaArea = find('.ModuloAlternado', text: textoOutrosCorpos)
            flegaArea.first(:css, 'a[href]').click
        end

        if tipo == "OutrasApps"
            flegaArea = find('.ModuloItem', text: textoOutrasApps)
            flegaArea.first(:css, 'a[href]').click
        end

        if tipo == "Vegetacao"  
            flegaArea = find('.ModuloItem', text: textoVegetacao)
            flegaArea.first(:css, 'a[href]').click
        end

        if tipo == "ReservaLegal"
            flegaArea = find('.ModuloAlternado', text: textoReservaLegal)
            flegaArea.first(:css, 'a[href]').click
        end

        if tipo == "Declividade"
            flegaArea = find('.ModuloItem', text: textoDeclividade)
            flegaArea.first(:css, 'a[href]').click
        end

        if tipo == "UsoConsolidado" || tipo == "UsoConsolidadoApp"
            flegaArea = find('.ModuloAlternado', text: textoUsoConsolidado)
            flegaArea.first(:css, 'a[href]').click
        end

        if tipo == "RLCompensacao"
            flegaArea = find('.ModuloItem', text: textoRLCompensacao)
            flegaArea.first(:css, 'a[href]').click
        end

        if tipo == "ServidaoAmb"
            flegaArea = find('.ModuloAlternado', text: textoServidaoAmb)
            flegaArea.first(:css, 'a[href]').click
        end

        if tipo == "AreaEmUC"
            flegaArea = find('.ModuloItem', text: textoAreaEmUC)
            flegaArea.first(:css, 'a[href]').click
        end
            
        sleep(5)
        
        Desenha.DesenhaPoligono(tipo,coordenadas)
        Desenha.SalvaPoligono(tipo)
    end

    def Desenha.Ponto(tipo)
        textoNascente = "Nascentes e Veredas"
            if tipo == "NascentePonto"
                flegaArea = find('.ModuloAlternado', text: textoNascente)
                flegaArea.first(:css, 'a[href]').click
                sleep(5)
                page.driver.browser.switch_to.frame("ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBArea_carArea_ifrmMapa")
                find("[title='Inserir nascente pontual']").click
                map = find(:id, "ucCARAreaMapa_ucCARGMapSketch1_CarGMap").native
                page.driver.browser.action.move_to(map,628,195).click.perform
                sleep(3)
                find(:link, "Sair do Mapa").click
                sleep(5)
            end
    end

    def Desenha.DesenhaPoligono(tipo,coordenadas)
        page.driver.browser.switch_to.frame("ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBArea_carArea_ifrmMapa")
        
        if tipo == "UsoConsolidadoApp"
            find("[title='Aumentar o zoom']").click
        end

        if tipo == "RiosMedia"
            find("[title='Desenhar linha']").click
        elsif tipo == "Nascente" || tipo == "NascenteVereda"
            find("[title='Desenhar nascente difusa']").click
        else
        find("[title='Desenhar forma']").click
        end
        map = find(:id, "ucCARAreaMapa_ucCARGMapSketch1_CarGMap").native
		page.driver.browser.action.move_to(map,coordenadas[0],coordenadas[1]).click.perform
		page.driver.browser.action.move_to(map,coordenadas[2],coordenadas[3]).click.perform
		page.driver.browser.action.move_to(map,coordenadas[4],coordenadas[5]).click.perform
		page.driver.browser.action.move_to(map,coordenadas[6],coordenadas[7]).click.perform
    end
    
    def Desenha.SalvaPoligono(tipo)

        if (tipo == "ServidaoAdm" || tipo == "RiosMedia" || tipo == "LagoLagoa" || tipo == "Vegetacao" || tipo == "Declividade")
            find("[title='Clique para salvar o estado do mapa']").click
            sleep(5)
            page.driver.browser.switch_to.alert.accept
            sleep(3)
            find(:link, "Sair do Mapa").click
            sleep(5)
        end

        if tipo == "RiosMais"
            sleep(3)
            page.driver.browser.switch_to.frame(0)
            sleep(3)
            fill_in("ctl01$txtLarguraRio", :with => "10")
            sleep(3)
            find(:link, "Salvar Atributos").click
            sleep(3)
            page.driver.browser.switch_to.frame(1)
            sleep(3)
            find(:link, "Sair do Mapa").click
            sleep(5)
        end

        if tipo == "Nascente"
            sleep(3)
            page.driver.browser.switch_to.frame(0)
            sleep(3)
            choose('Nascente Difusa')
            find(:link, "Salvar Atributos").click
            sleep(3)
            page.driver.browser.switch_to.frame(1)
            sleep(3)
            find(:link, "Sair do Mapa").click
            sleep(5)
        end

        
        if tipo == "NascenteVereda"
            sleep(3)
            page.driver.browser.switch_to.frame(0)
            sleep(3)
            choose('Vereda')
            find(:link, "Salvar Atributos").click
            sleep(3)
            page.driver.browser.switch_to.frame(1)
            sleep(3)
            find(:link, "Sair do Mapa").click
            sleep(5)
        end

        if tipo == "OutrosCorpos"
            sleep(3)
            page.driver.browser.switch_to.frame(0)
            sleep(3)
            select("Lago ou Lagoa Artificial", :from => "ctl01$ddlTipoHidro")
            choose('Rural')
            sleep(3)
            find(:link, "Salvar Atributos").click
            sleep(3)
            page.driver.browser.switch_to.frame(1)
            sleep(3)
            find(:link, "Sair do Mapa").click
            sleep(5)
        end
        
        if tipo == "OutrasApps"
            sleep(3)
            page.driver.browser.switch_to.frame(0)
            sleep(3)
            select("Mangue", :from => "ctl01$ddlAPP")
            sleep(3)
            find(:link, "Salvar Atributos").click
            sleep(3)
            page.driver.browser.switch_to.frame(1)
            sleep(3)
            find(:link, "Sair do Mapa").click
            sleep(5)
        end

        if tipo == "ReservaLegal"
            sleep(3)
            page.driver.browser.switch_to.frame(0)
            sleep(3)
            choose('ctl01_rblLegal_0') # primeiraOpcao
            sleep(2)
            fill_in("ctl01$txtAno", :with => "2017")
            sleep(2)
            fill_in("ctl01$txtNumero", :with => "2017123")
            sleep(2)
            choose("Não")
            sleep(3)
            find(:link, "Salvar Atributos").click
            sleep(3)
            page.driver.browser.switch_to.frame(1)
            sleep(3)
            find(:link, "Sair do Mapa").click
            sleep(5)
        end

        if tipo == "UsoConsolidado"
            sleep(3)
            page.driver.browser.switch_to.frame(0)
            sleep(3)
            select("Pasto", :from => "ctl01$ddlTipoUso")
            sleep(3)
            find(:link, "Salvar Atributos").click
            sleep(3)
            page.driver.browser.switch_to.frame(1)
            sleep(3)
            find(:link, "Sair do Mapa").click
            sleep(5)
        end

        if tipo == "UsoConsolidadoApp"
            sleep(3)
            page.driver.browser.switch_to.frame(0)
            sleep(3)
            select("Ecoturismo", :from => "ctl01$ddlTipoUso")
            sleep(3)
            find(:link, "Salvar Atributos").click
            popUp = page.driver.browser.switch_to.alert.text
            puts(popUp)
            page.driver.browser.switch_to.alert.accept
            sleep(5)
            page.driver.browser.switch_to.frame(1)
            find(:link, "Sair do Mapa").click
            sleep(5)
        end

        if tipo == "RLCompensacao"
            sleep(3)
            page.driver.browser.switch_to.frame(0)
            choose('ctl01_rblLegal_0')
            sleep(2)
            fill_in("ctl01$txtAno", :with => "2018")
            sleep(2)
            fill_in("ctl01$txtNumero", :with => "2018123")
            sleep(2)
            choose('ctl01_rblAverbado_0')
            choose('ctl01_rblCondominio_0')
            find(:link, "Salvar Atributos").click
            sleep(5)
            page.driver.browser.switch_to.frame(1)
            find(:link, "Sair do Mapa").click
            sleep(5)
        end

        if tipo == "ServidaoAmb"
            sleep(3)
            page.driver.browser.switch_to.frame(0)
            choose('ctl01_rblLegal_0')
            fill_in("ctl01$txtAno", :with => "2016")
            sleep(1)
            fill_in("ctl01$txtNumero", :with => "2016123")
            choose('ctl01_rblAverbado_0')
            sleep(1)
            choose('ctl01_rblUsaParaRL_0')
            sleep(1)            
            choose('ctl01_rblTipoServidao_0')
            sleep(1)
            choose('ctl01_rblCondominio_0')
            find(:link, "Salvar Atributos").click
            sleep(5)
            page.driver.browser.switch_to.frame(1)
            find(:link, "Sair do Mapa").click
            sleep(5)
        end

        if tipo == "AreaEmUC"
            sleep(3)
            page.driver.browser.switch_to.frame(0)
            sleep(5)
            find(:link, "Salvar Atributos").click
            sleep(5)
            page.driver.browser.switch_to.frame(1)
            sleep(5)
            find(:link, "Sair do Mapa").click
            sleep(10)
        end
    end
end