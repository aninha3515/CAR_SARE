require 'faker'
class PreencheAdequacao
    def PreencheAdequacao.compromissosAnteriores
        Desenha.verificaPopUp
        #Auto de Infração
        opcaoAIA = find("[id*='trPossuiAIA']").text
        choose("Não", visible: true)
        Desenha.verificaPopUp

        #Órgão Ambiental
        find("[title='Órgão Ambiental']").click
        Desenha.verificaPopUp
        opcaoOrgaoAmbiental = find("[id*='CARCompromissoOrgaoAmbiental_trPossuiCompromisso']", visible: true).text
        choose("Não", visible: true)

        #Órgão Externo
        find("[title='Órgão Externo']").click
        Desenha.verificaPopUp
        opcaoOrgaoExterno = find("[id*='CARCompromissoOrgaoExterno_trPossuiCompromisso']").text
        choose("Não", visible: true)

        #Decisão Judicial
        find("[title='Decisão Judicial']").click
        Desenha.verificaPopUp
        opcaoDecisaoJudicial = find("[id*='CARDecisaoJudicial_trPossuiDecisaoJudicial']").text
        choose("Não", visible: true)
    end

    def PreencheAdequacao.PassivosAmbientais(criaProjeto)
        find("[title='Passivos Ambientais']").click
        Desenha.verificaPopUp
            if (criaProjeto == "PRADA")
                choose("Sim", visible: true)
            else
                choose("Não", visible: true)
            end
        desenhaProp2008 = find(".ModuloAlternado", text: "Propriedade em 2008")
        desenhaProp2008.find(:css, "a[href]").click
        page.driver.browser.switch_to.frame(1)
        check("ucCARAreaMapaAdequacao$chkCopiaPropiedade")
        Desenha.verificaPopUp
        sleep(5)
        find(:link, "Sair do Mapa").click
        find(:link, "Calcular os passivos").click
        Desenha.verificaPopUp
    end

    def PreencheAdequacao.Finalizar
        Desenha.verificaPopUp
        find("[id*='FinalizarAdequacao']").click
        find("[id*='CARAdequacaoFinaliza_cmdFinaliza']").click
        Desenha.verificaPopUp
        Desenha.verificaPopUp
        Desenha.verificaPopUp
    end
end