require 'faker'
class InsereDados
	def InsereDados.inicio(nomeCAR,muni)
	first(".Atendimento", text: "SiCAR/SP", visible: true).click
	#Validação para identificar se já possui CAR
		if assert_text("Cadastrar Nova Propriedade")
			find(:link, "Cadastrar Nova Propriedade").click
			puts("Já existe car para este usuário")
		else
			puts("Não existe CAR para este usuário, criando seu primeiro CAR")
		end
	#fim da validação
	choose("Rural")
	InsereDados.tipoPropriedade

	fill_in('ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$nomPropriedade', :with => nomeCAR)
	fill_in('ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$desEndereco', :with => "Av Professor Frederico Hermann JR")
	fill_in('ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$nomBairro', :with => "Alto de Pinheiros")
	fill_in('ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$numCEP', :with => "03259000")
	select(muni, :from => 'ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$ddlMunicipio')
	fill_in('ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$numArea', :with => "2702")
	fill_in('ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$area2008', :with => "2702")
	#find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBCadastro_carCadastro_chkAtividade_1").click
	choose("Criação Animal")
	#find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBCadastro_carCadastro_rblQualificacao_0").click
	find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBCadastro_carCadastro_cmdAtualiza").click
	numProtocolo = find(:id, "ctl00_conteudo_lblID").text
	puts("Car sendo gerado... Número do Protocolo: " + numProtocolo)
end

	def InsereDados.tipoPropriedade
		#check("Posse")
		#choose("Posseiro")
		check("Propriedade")
		choose("Proprietário")
	end

	def InsereDados.InserePessoa(cpfPessoa,permissao)
		find(:link, "Domínio").click
			if permissao == "Tecnico"
				find(:link, "Técnicos").click
				find(".BotaoCmd", text: "Adicionar", visible: true).click
				fill_in("ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBDominio$carDominio$TabDominio$TBResponsavel$carPessoa$pesPessoa$CPFCNPJ", :with => cpfPessoa)
				find(:link, "Confirmar").click
				select("SMA", :from =>"ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBDominio$carDominio$TabDominio$TBResponsavel$carPessoa$pesPessoa$ddlInstituicao")
			end

			if permissao == "Representante"
				find(:link, "Representantes").click
				find(".BotaoCmd", text: "Adicionar", visible: true).click
				fill_in("ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBDominio$carDominio$TabDominio$TBRepLegal$carRepLegal$pesPessoa$CPFCNPJ", :with => cpfPessoa)
				find(:link, "Confirmar").click
				sleep(2)
				first("input[id*=chkPodeAlterar]").click
			end
		sleep(5)
		find(:link, "Salvar", visible: true).click
	end

	def InsereDados.AnexaProcuracao
		find("[title='Arqivos Anexos ao CAR']").click
		find(".BotaoCmd", text: "Adicionar", visible: true).click
		select("Procuração do Proprietário", :from => "ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBAnexo$carAnexo$ddlTipoAnexo")
		fill_in("ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBAnexo$carAnexo$desConteudo", :with => "Criado pelo teste automatizado")
		attach_file('ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBAnexo$carAnexo$fileUpload$ctl02', File.absolute_path('anexos/Teste.pdf'))
		sleep(5)
		find(".BotaoCmd", text: "Salvar", visible: true).click
		sleep(5)
	end

	def InsereDados.DesenhaPropriedade
		find(:link, "Mapa").click
		find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBArea_carArea_gvConsulta_ctl02_btnGeo").click
		#Inicio da Iteração com Iframe
		sleep(10)
		page.driver.browser.switch_to.frame("ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBArea_carArea_ifrmMapa")
		find("[title='Desenhar forma']").click
		#map = o local onde será realizado o desenho
		map = find(:id, "ucCARAreaMapa_ucCARGMapSketch1_CarGMap").native
		page.driver.browser.action.move_to(map,565, 354).click.perform
		sleep(2)
		page.driver.browser.action.move_to(map,625, 343).click.perform
		sleep(2)
		page.driver.browser.action.move_to(map,623, 380).click.perform
		sleep(2)
		page.driver.browser.action.move_to(map,564, 359).click.perform
		sleep(2)
		#Fecha a iteração com o Iframe

		#clica na opção salvar
		find("[title='Clique para salvar o estado do mapa']").click
		sleep(10)
		page.driver.browser.switch_to.alert.accept
		find(:id, "ucCARAreaMapa_btnFechaMapaInclusao").click
		sleep(5)
	end
	
	def InsereDados.DesenhaPropriedadeMenor4
		find(:link, "Mapa").click
		find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBArea_carArea_gvConsulta_ctl02_btnGeo").click
		#Inicio da Iteração com Iframe
		sleep(10)
		page.driver.browser.switch_to.frame("ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBArea_carArea_ifrmMapa")
	
		find("[title='Aumentar o zoom']").click
		find("[title='Aumentar o zoom']").click
		sleep(3)
		find("[title='Desenhar forma']").click
		sleep(2)
		#map = o local onde será realizado o desenho
		map = find(:id, "ucCARAreaMapa_ucCARGMapSketch1_CarGMap").native
		page.driver.browser.action.move_to(map,565, 354).click.perform
		sleep(2)
		page.driver.browser.action.move_to(map,625, 343).click.perform
		sleep(2)
		page.driver.browser.action.move_to(map,623, 380).click.perform
		sleep(2)
		page.driver.browser.action.move_to(map,564, 359).click.perform
		sleep(2)
		#Fecha a iteração com o Iframe

		#clica na opção salvar
		find("[title='Clique para salvar o estado do mapa']").click
		sleep(10)
		page.driver.browser.switch_to.alert.accept
		find(:id, "ucCARAreaMapa_btnFechaMapaInclusao").click
		sleep(5)
    end

    def InsereDados.NaoExiste(link,artigo)
		#seleciona "Não Existe"
		textoServidaoAdm = "Servidão Administrativa"
		textoRiosMais = "Rios com mais de 3 metros de largura média"
		textoRiosMedia = "Rios com até 3 metros de largura média"
		textoNascente = "Nascente"
		textoOutrosCorpos = "Outros corpos d'água"
		textoOutrasApps = "Outras APPs"
		textoVegetacao = "Vegetação Nativa"
		textoReservaLegal = "Reserva Legal"
		textoDeclividade = "Declividade entre 25° e 45°"
		textoUsoConsolidado = "Uso consolidado"
		textoRLCompensacao = "Reserva legal de compensação"
		textoServidaoAmb = "Servidão Ambiental"
		textoLagoLagoa = "Lago e Lagoa Natural"
	
			if link == "http://homologacao-sigam.eastus2.cloudapp.azure.com/sigam-homologacao1"

				flegaArea = find('.ModuloAlternado', text: textoServidaoAdm)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloAlternado', text: textoRiosMais)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloItem', text: textoRiosMedia)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloAlternado', text: textoNascente)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloItem', text: textoOutrosCorpos)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloAlternado', text: textoOutrasApps)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloAlternado', text: textoVegetacao)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloItem', text: textoReservaLegal)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloAlternado', text: textoDeclividade)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloItem', text: textoUsoConsolidado)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloAlternado', text: textoRLCompensacao)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloItem', text: textoServidaoAmb)
				flegaArea.find('input[type=checkbox]').click
			end

			if link == "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car_test/" || link == "http://homologacao-sigam.eastus2.cloudapp.azure.com/sma-est-car"

				textoNascente = "Nascentes e Veredas"
				textoLagoLagoa = "Lago e Lagoa Natural"
				textoRLCompensacao = "Reserva Legal de Compensação"


				flegaArea = find('.ModuloAlternado', text: textoServidaoAdm)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloAlternado', text: textoRiosMais)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloItem', text: textoRiosMedia)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloAlternado', text: textoNascente)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloItem', text: textoLagoLagoa)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloAlternado', text: textoOutrosCorpos)
				flegaArea.find('input[type=checkbox]').click

				if artigo == "4771"
					puts("Não Marca " + textoOutrasApps)
				else
					flegaArea = find('.ModuloItem', text: textoOutrasApps)
					flegaArea.find('input[type=checkbox]').click
				end

				if artigo == "4771"
					puts("Não Marca " + textoVegetacao)
				else
					flegaArea = find('.ModuloItem', text: textoVegetacao)
					flegaArea.find('input[type=checkbox]').click
				end

				if artigo == "4771" || artigo == "Def_RL" || artigo == "Exc_RL"
					puts("Não Marca " + textoReservaLegal)
				else
					flegaArea = find('.ModuloAlternado', text: textoReservaLegal)
					flegaArea.find('input[type=checkbox]').click
				end

				flegaArea = find('.ModuloItem', text: textoDeclividade)
				flegaArea.find('input[type=checkbox]').click

				flegaArea = find('.ModuloAlternado', text: textoUsoConsolidado)
				flegaArea.find('input[type=checkbox]').click

				if artigo == "Exc_RL"
					puts("Não Marca " + textoRLCompensacao)
				else
					flegaArea = find('.ModuloItem', text: textoRLCompensacao)
					flegaArea.find('input[type=checkbox]').click
				end
				if artigo == "Exc_RL"
					puts("Não Marca " + textoServidaoAmb)
				else
				flegaArea = find('.ModuloAlternado', text: textoServidaoAmb)
				flegaArea.find('input[type=checkbox]').click
				end
			end
    end

    def InsereDados.DesenhaUC(usuario)
		#desenhando área de UC
		find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBArea_carArea_gvConsulta_ctl18_btnGeo").click
		page.driver.browser.switch_to.frame("ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBArea_carArea_ifrmMapa")
		find("[title='Desenhar forma']").click
		map = find(:id, "ucCARAreaMapa_ucCARGMapSketch1_CarGMap").native
		page.driver.browser.action.move_to(map,664, 236).click.perform
		sleep(2)
		page.driver.browser.action.move_to(map,748, 229).click.perform
		sleep(2)
		page.driver.browser.action.move_to(map,753, 276).click.perform
		sleep(2)
		page.driver.browser.action.move_to(map,669, 283).click.perform
		sleep(2)
		page.driver.browser.action.move_to(map,666, 241).click.perform
		sleep(10)
		#inicio da interação com o iframe de atributos
		page.driver.browser.switch_to.frame(0)
		#validacao para interagir com campos, caso seja o usuário da marianab
			if usuario == "marianab"
				processo = "1919601" #idProcesso EST-CAR: 1919501
				select("Cerrado", :from => "ctl01$ddlBioma")
				sleep(5)
				fill_in("ctl01$txtIdentificadorDoProcesso", :with => processo)
				sleep(5)
				find(:id, "ctl01_txtProcessoAno").click
			end
		sleep(7)
		find(:link, "Salvar Atributos").click
		sleep(10)
		#Fim da interação com o iframe de atributos
		#retorna para o iframe do desenho
		page.driver.browser.switch_to.frame(1)
		find(:link, "Sair do Mapa").click
		sleep(10)
    end

    def InsereDados.final(possuiAreas)
		#clica na aba Domínio
		find(:id, "__tab_ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDominio").click
		find(:link, "Matrículas").click
		sleep(2)
		find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDominio_carDominio_TabDominio_TBMatricula_carMatricula_cmdInclui").click
		select("Guarulhos", :from =>"ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBDominio$carDominio$TabDominio$TBMatricula$carMatricula$ddlComarca")
		fill_in("ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBDominio$carDominio$TabDominio$TBMatricula$carMatricula$nomCartorio", :with => "1234")
		fill_in("ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBDominio$carDominio$TabDominio$TBMatricula$carMatricula$numMatricula", :with => "1234")
		fill_in("ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBDominio$carDominio$TabDominio$TBMatricula$carMatricula$livro", :with => "1234")
		find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBDominio_carDominio_TabDominio_TBMatricula_carMatricula_cmdAtualiza").click
		find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBFinaliza_spanFinalizar").click
		#aba Finaliza
		find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBFinaliza_carFinaliza_flaInformacao").click
		find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBFinaliza_carFinaliza_flaCiencia").click
			if possuiAreas == "RL"
				find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBFinaliza_carFinaliza_flaServidaoTemp").click
			end
		find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBFinaliza_carFinaliza_flaNotificaEmail").click
		find(:id, "ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBFinaliza_carFinaliza_cmdFinaliza").click
		sleep(5)
		page.driver.browser.switch_to.alert.accept
		sleep(5)
		end

	def InsereDados.SolicitaAlteracao
		find("[title=Alterar]").click
		find("[id*=cmdAltera]").click
		Desenha.verificaPopUp
		select("Acrescentar Anexos", :from => "ctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBFinaliza$carFinaliza$ddlMotivo")
		find("textarea[id*='desMotivo']").set("Teste Automatiazado")
		find("a[id*='cmdSolicita']").click
		Desenha.verificaPopUp
		sleep(3)
		Desenha.verificaPopUp
	end

	def InsereDados.VinculaCAR(numCarDeficitario)

		textoReservaLegal = "Reserva Legal"
        textoRLCompensacao = "Reserva Legal de Compensação"
		textoServidaoAmb = "Servidão Ambiental"
		
		find(:link, "Mapa", visible: true).click
		flegaArea = find('.ModuloItem', text: textoRLCompensacao)
		flegaArea.first(:css, 'a[href]').click
		page.driver.browser.switch_to.frame("ctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBArea_carArea_ifrmMapa")
		find("[title*='sobre o elemento selecionado']", visible: true, match: :first).click
		map = find(:id, "ucCARAreaMapa_ucCARGMapSketch1_CarGMap").native
		page.driver.browser.action.move_to(map,800,250).click.perform
		sleep(5)
		page.driver.browser.switch_to.frame(0)
		sleep(3)
		page.save_screenshot('log/shots/AntesVinculaCar.png')
		find("[id*='cmdVincularNovo']").click
		page.save_screenshot('log/shots/DepoisVinculaCar.png')
		find("[id*='txtnumCARVinculado']").set(numCarDeficitario)
		areaRestante = "101,2566"
		find("[id*='txtArea']").click
		sleep(2)
		find("[id*='txtArea']").set(areaRestante)
		find("[id*='cmdAtualizaCarVnculado']").click
		find(:link, "Salvar Atributos").click
		sleep(5)
		Desenha.verificaPopUp
		page.driver.browser.switch_to.frame(1)
		sleep(5)
		find(:link, "Sair do Mapa").click
		sleep(5)
		find(:link, "Finalizar", visible: true).click
		find("[id*='carFinaliza_cmdFinaliza']").click
		Desenha.verificaPopUp
		sleep(3)
		Desenha.verificaPopUp
	end
end