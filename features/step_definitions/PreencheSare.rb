require 'faker'
require "cpf_cnpj"
class PreencheSare

    def PreencheSare.CadastroInicial(nomeSare,link)
        find(:link, "Cadastrar projetos com dispensa de CAR").click
        #aba Cadastro
        select('Exigência da CETESB', :from => 'ctl00$conteudo$TabNavegacao$TBCadastro$ProjetoCadastroSemCar$ddlMotivo')
        # if link == "http://exec-dev01.sma.local/sigam-adequacao-test"
        #     page.driver.browser.switch_to.alert.accept
        # end
        fill_in("ctl00$conteudo$TabNavegacao$TBCadastro$ProjetoCadastroSemCar$nomProjeto", :with => nomeSare)
        anoProcesso = "2016"
        find(:id, "ctl00_conteudo_TabNavegacao_TBCadastro_ProjetoCadastroSemCar_PesqProcesso_cmdExibeGrid").click
        #preenche o grid secundário
        fill_in("ctl00$conteudo$TabNavegacao$TBCadastro$ProjetoCadastroSemCar$PesqProcesso$txtFiltroAnoProcesso", :with => anoProcesso)
        find(:link, "Pesquisar").click
        find(:id, "ctl00_conteudo_TabNavegacao_TBCadastro_ProjetoCadastroSemCar_PesqProcesso_gvConsulta_ctl02_rbRefDocumento").click
        numProcesso = find("#ctl00_conteudo_TabNavegacao_TBCadastro_ProjetoCadastroSemCar_PesqProcesso_txtNumProcesso").value
        puts("O processo vinculado é o : " + numProcesso)
        #Endereço
        fill_in("ctl00$conteudo$TabNavegacao$TBCadastro$ProjetoCadastroSemCar$txtEndereco", :with => "Rua Automatizada")
        select("GUARULHOS", :from => "ctl00$conteudo$TabNavegacao$TBCadastro$ProjetoCadastroSemCar$ddlMunicipio")
        find(:link, "Atualizar").click
    end

    def PreencheSare.Pessoa(nomPessoa,funcaoPessoa,tipoPessoa)
        find(:link, "Pessoas").click
        find("[title='Adiciona uma Nova Pessoa']").click
        cpfPessoa = CPF.generate
        cnpjPessoa = CNPJ.generate

        if tipoPessoa == "Física"
        fill_in("ctl00$conteudo$TabNavegacao$TBPessoa$ProjetoPessoa$TabNavegacao$TBCadastroPessoas$pesPessoa$CPFCNPJ", :with => cpfPessoa)
        else
        fill_in("ctl00$conteudo$TabNavegacao$TBPessoa$ProjetoPessoa$TabNavegacao$TBCadastroPessoas$pesPessoa$CPFCNPJ", :with => cnpjPessoa)
        end
        
        find(:link, "Confirmar").click
        fill_in("ctl00$conteudo$TabNavegacao$TBPessoa$ProjetoPessoa$TabNavegacao$TBCadastroPessoas$pesPessoa$nomPessoa", :with => nomPessoa)
        fill_in("ctl00$conteudo$TabNavegacao$TBPessoa$ProjetoPessoa$TabNavegacao$TBCadastroPessoas$pesPessoa$desEndereco", :with => "Rua Testes QA")
        fill_in("ctl00$conteudo$TabNavegacao$TBPessoa$ProjetoPessoa$TabNavegacao$TBCadastroPessoas$pesPessoa$nomBairro", :with => "Alto de Pinheiros")
        fill_in("ctl00$conteudo$TabNavegacao$TBPessoa$ProjetoPessoa$TabNavegacao$TBCadastroPessoas$pesPessoa$CEP", :with => "03259000")
        select("Guarulhos", :from => "ctl00$conteudo$TabNavegacao$TBPessoa$ProjetoPessoa$TabNavegacao$TBCadastroPessoas$pesPessoa$ddlMunicipio")
        select(funcaoPessoa, :from => "ctl00$conteudo$TabNavegacao$TBPessoa$ProjetoPessoa$TabNavegacao$TBCadastroPessoas$pesPessoa$ddlFuncao")
        emailPessoa = "lucas.koritar@globalweb.com.br"
        fill_in("ctl00$conteudo$TabNavegacao$TBPessoa$ProjetoPessoa$TabNavegacao$TBCadastroPessoas$pesPessoa$Email", :with => emailPessoa)
        find(:link, "Cadastro Pessoas").click
        fill_in("ctl00$conteudo$TabNavegacao$TBPessoa$ProjetoPessoa$TabNavegacao$TBCadastroPessoas$pesPessoa$EmailConfirma", :with => emailPessoa)

        if funcaoPessoa == "Representante legal"
        find("[title='Grava os dados da Pessoa']").click
        textoPopUp = page.driver.browser.switch_to.alert.text
        puts (textoPopUp)
        page.driver.browser.switch_to.alert.accept
        find(:link, "Compromissário(s) Representado(s)").click
        check("ctl00$conteudo$TabNavegacao$TBPessoa$ProjetoPessoa$TabNavegacao$TBRepresentanteLegal$responsavelTermo$gvCompromissarios$ctl02$chkCompromissario")
        sleep(3)
        find("[title='Adicionar compromissários']").click
        sleep(3)
        attach_file('ctl00$conteudo$TabNavegacao$TBPessoa$ProjetoPessoa$TabNavegacao$TBRepresentanteLegal$responsavelTermo$fileUpload$ctl02', 'C:\Projetos\CAR_SARE_PRA\anexos\Teste.pdf')
        sleep(10)
        find(:link, "Adicionar Anexos").click
        sleep(3)
        find("[title='Grava as alterações']").click
        find(:id, "ctl00_conteudo_TabNavegacao_TBPessoa_ProjetoPessoa_TabNavegacao_TBRepresentanteLegal_responsavelTermo_cmdFinaliza").click
        end

        if funcaoPessoa == "Compromissário"
        find("[title='Grava os dados da Pessoa']").click
        validaMensagem = find("#ctl00_conteudo_TabNavegacao_TBPessoa_ProjetoPessoa_TabNavegacao_TBCadastroPessoas_pesPessoa_lblMensagem").text
        puts(validaMensagem)
        find("[title='Salva os dados e retorna para a Consulta']").click
        end

    end

    def PreencheSare.AlteraSituacao(usuario)
        if usuario == "leilacm" || usuario == "karinaac"
            find("[title='Analise']").click
            find("[title='Adiciona uma nova Análise']").click
            find("#ctl00_conteudo_TabNavegacao_TBAnalise_projetoAnalise_TabStatus_TabStatusProjeto_btnDataSituacao").click
            find(".ajax__calendar_day", text: "20").click
            sleep(3)
            select("Em análise", :from => "ctl00$conteudo$TabNavegacao$TBAnalise$projetoAnalise$TabStatus$TabStatusProjeto$ddlSituacao")
            sleep(3)
            fill_in("ctl00$conteudo$TabNavegacao$TBAnalise$projetoAnalise$TabStatus$TabStatusProjeto$desAnalise", :with => "Teste Automatizado")
            find(".BotaoCmd", text: "Finalizar").click
            sleep(3)
            find(:link, "Termo").click
        end
    end

    def PreencheSare.GeraTermo(usuario,tipoTermo)
        if ((usuario == "leilacm" || usuario == "karinaac" || usuario == "rodrigolp") && tipoTermo == "TCRE")
            select("TCRE – Termo de Compromisso de Restauração Ecológica", :from => "ctl00$conteudo$TabNavegacao$TBTermo$sareTermo$TabNavegacaoTermo$TBSubTermos$dplTermos")
            find(:link, "Adicionar Termo").click
            fill_in("ctl00$conteudo$TabNavegacao$TBTermo$sareTermo$TabNavegacaoTermo$TBSubTermos$TermoTcpraTcreTca$desPreambulo$ctl01$txtDescVariavel", :with => "Unidade Automatizada")
            find("[title='Grava as alterações']").click
        end

        if ((usuario == "leilacm" || usuario == "karinaac" || usuario == "rodrigolp") && tipoTermo == "TCA")
            select("TCA – Termo de Compromisso da Adequação Ambiental", :from => "ctl00$conteudo$TabNavegacao$TBTermo$sareTermo$TabNavegacaoTermo$TBSubTermos$dplTermos")
            find(:link, "Adicionar Termo").click
            find("[title='Grava as alterações']").click
        end
    end

    def PreencheSare.DesenhaPropSare
        find(:id, "__tab_ctl00_conteudo_TabNavegacao_TBArea").click
        find(:id, "ctl00_conteudo_TabNavegacao_TBArea_ProjetoAreaSemCar_cmdInclui").click
        fill_in("ctl00$conteudo$TabNavegacao$TBArea$ProjetoAreaSemCar$TabNavegacao$TBCadastroSemCar$areaCadastroSemCar$nomArea", :with => "Projeto SARE Automatizado")
        find("[value='ATLANTICA']").click
        sleep(5)
        select("Florestas Ombrófilas ou Estacionais", :from => "ctl00$conteudo$TabNavegacao$TBArea$ProjetoAreaSemCar$TabNavegacao$TBCadastroSemCar$areaCadastroSemCar$ddlFitofisionomia")
        sleep(3)
        select("Unidade de Conservação Estadual", :from => "ctl00$conteudo$TabNavegacao$TBArea$ProjetoAreaSemCar$TabNavegacao$TBCadastroSemCar$areaCadastroSemCar$ddlTipologia")
        sleep(3)
        unidade = "Área de Proteção Ambiental Cabreúva"
        fill_in("ctl00_conteudo_TabNavegacao_TBArea_ProjetoAreaSemCar_TabNavegacao_TBCadastroSemCar_areaCadastroSemCar_dpUC_txtText_Input", :with => unidade)
        sleep(7)
        find(:id, "__tab_ctl00_conteudo_TabNavegacao_TBArea").click
        select("GUARULHOS", :from => "ctl00$conteudo$TabNavegacao$TBArea$ProjetoAreaSemCar$TabNavegacao$TBCadastroSemCar$areaCadastroSemCar$ddlMunicipio")
        sleep(5)
        find(:id, "ctl00_conteudo_TabNavegacao_TBArea_ProjetoAreaSemCar_TabNavegacao_TBCadastroSemCar_areaCadastroSemCar_cmdAtualiza").click
        find(:link, "Mapa").click
        find(:id, "ctl00_conteudo_TabNavegacao_TBArea_ProjetoAreaSemCar_TabNavegacao_TBMapa_MapaAreaSemCar_gvConsulta_ctl02_btnGeo").click
        page.driver.browser.switch_to.frame("ctl00_conteudo_TabNavegacao_TBArea_ProjetoAreaSemCar_TabNavegacao_TBMapa_MapaAreaSemCar_ifrmMapa")
        find("[title='Desenhar forma']").click
        map = find(:id, "GMap").native
        page.driver.browser.action.move_to(map,565, 354).click.perform
        page.driver.browser.action.move_to(map,625, 343).click.perform
	    page.driver.browser.action.move_to(map,623, 380).click.perform
        page.driver.browser.action.move_to(map,564, 359).click.perform
        sleep(10)
    end

    def PreencheSare.InsereCamposProp
        page.driver.browser.switch_to.frame(0)
        find('#txtNome').set('Propriedade Automatizada')
        find('#txtEndereco').set("Av Professor Hermann Jr")
        find("#txtComplemento").set("Sobrado - Teste Automatizado")
        find('#txtBairro').set("Alto de Pinheiros")
        find('#txtCep').set("03259000")
        find('#txtReferencia').set("Teste Automatizado do Koritar")
        find(:link,"Adicionar Dominialidade").click
        select("Amparo", :from => "ddlComarca")
        fill_in("txtCartorio", :with => "12345")
        fill_in("txtNumMatricula", :with => "1234")
        find("#rblPosse_0").click
        fill_in("txtPosse", :with => "12345")
        find(:link, "Adicionar").click
        find(:link, "Salvar Atributos").click
        sleep(3)
        page.driver.browser.switch_to.frame(1)
        find(:id, "bntFechar").click
        sleep(5)
    end

    def PreencheSare.NaoExiste
        check("ctl00$conteudo$TabNavegacao$TBArea$ProjetoAreaSemCar$TabNavegacao$TBMapa$MapaAreaSemCar$gvConsulta$ctl03$chkNaoExiste")
        check("ctl00_conteudo_TabNavegacao_TBArea_ProjetoAreaSemCar_TabNavegacao_TBMapa_MapaAreaSemCar_gvConsulta_ctl04_chkNaoExiste")
        check("ctl00_conteudo_TabNavegacao_TBArea_ProjetoAreaSemCar_TabNavegacao_TBMapa_MapaAreaSemCar_gvConsulta_ctl05_chkNaoExiste")
        check("ctl00_conteudo_TabNavegacao_TBArea_ProjetoAreaSemCar_TabNavegacao_TBMapa_MapaAreaSemCar_gvConsulta_ctl06_chkNaoExiste")
        check("ctl00_conteudo_TabNavegacao_TBArea_ProjetoAreaSemCar_TabNavegacao_TBMapa_MapaAreaSemCar_gvConsulta_ctl07_chkNaoExiste")
    end

    def PreencheSare.DesenhaRestauracao
        find("#ctl00_conteudo_TabNavegacao_TBArea_ProjetoAreaSemCar_TabNavegacao_TBMapa_MapaAreaSemCar_gvConsulta_ctl08_btnGeo").click
        page.driver.browser.switch_to.frame("ctl00_conteudo_TabNavegacao_TBArea_ProjetoAreaSemCar_TabNavegacao_TBMapa_MapaAreaSemCar_ifrmMapa")
        find("[title='Desenhar forma']").click
        map = find(:id, "GMap").native
        page.driver.browser.action.move_to(map,664, 236).click.perform
        page.driver.browser.action.move_to(map,748, 229).click.perform
        page.driver.browser.action.move_to(map,753, 276).click.perform
        page.driver.browser.action.move_to(map,669, 283).click.perform
        page.driver.browser.action.move_to(map,666, 241).click.perform
        sleep(5)
        find("[title='Clique para salvar o estado do mapa']").click
        sleep(5)
        page.driver.browser.switch_to.alert.dismiss
        find(:link, "Fechar").click
        sleep(5)
    end
end