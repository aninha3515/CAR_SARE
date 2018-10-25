class SareRetificacao
    def SareRetificacao.GeraRetificacao
        find("[id*='TBTermo']", visible: true, :match => :first).click
        find("[id*='TBRetificacao']", visible: true, :match => :first).click
        tipoRetificacao = "TCRE – Termo de Compromisso de Restauração Ecológica"
        find("[id*='ddlTermos']").find(:option, tipoRetificacao).text
        find("[id*='ddlTermos']").find(:option, tipoRetificacao).click
        find("[id*='lkbAdicionaRetificacao']").click
        sleep(2)

        find(".txtTextoRet1").set("Item Retificacao Manual")
        find(".txtTextoRet2").set("Item Retificacao Automatizada")
        find("[id*='SareTermoRetificacao_cmdAtualiza']").click
        retorno = find("[id*='lblRetorno']").text

        if(retorno == "Dados atualizados com sucesso")
            first("[id*='SareTermoRetificacao_cmdFinaliza']").click
            Desenha.verificaPopUp
            find("[id*='rblOpcoesImpressao_0']").click
            find("[id*='cmdFinalizaImpresao']").click
        else
            puts("Falha na geração da retificação...")
        end
    end

    def SareRetificacao.SituacaoRetificacao(sitAlterada)
        find(:link, "Termo", visible: true, :match => :first).click
        find("[id*='TBRetificacao']", visible: true, :match => :first).click
        if(sitAlterada == "RetificacaoOrgaoEmissor")
            situacaoRetif = find("#ctl00_conteudo_TabNavegacao_TBTermo_sareTermo_TabNavegacaoTermo_TBRetificacao_SareTermoRetificacao_gvPesquisa > tbody > tr.ModuloItem > td:nth-child(11)").text
        end
        puts("Retificacao alterado para a situação: " + situacaoRetif)
    end
end