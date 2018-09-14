require 'faker'
class PreencheAdequacao
    def PreencheAdequacao.compromissosAnteriores
        #Auto de Infração
        opcaoAIA = find("[id*='trPossuiAIA']").text
        choose("Não", visible: true)

        #Órgão Ambiental
        find("[title='Órgão Ambiental']").click
        opcaoOrgaoAmbiental = find("[id*='CARCompromissoOrgaoAmbiental_trPossuiCompromisso']", visible: true).text
        choose("Não", visible: true)

        #Órgão Externo
        find("[title='Órgão Externo']").click
        opcaoOrgaoExterno = find("[id*='CARCompromissoOrgaoExterno_trPossuiCompromisso']").text
        choose("Não", visible: true)

        #Decisão Judicial
        find("[title='Decisão Judicial']").click
        opcaoDecisaoJudicial = find("[id*='CARDecisaoJudicial_trPossuiDecisaoJudicial']").text
        choose("Não", visible: true)
    end

    def PreencheAdequacao.PassivosAmbientais
        find("[title='Passivos Ambientais']").click
        choose("Sim", visible: true)
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
        find("[id*='FinalizarAdequacao']").click
        find("[id*='CARAdequacaoFinaliza_cmdFinaliza']").click
        Desenha.verificaPopUp
    end
end