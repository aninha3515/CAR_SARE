class SareTermos
    def SareTermos.AbaArquivos(numTermoConvertido,tipoAnexo)
        find("[id*='TBTermo']", visible: true, :match => :first).click
        find("[id*='TabNavegacaoTermo_TBAnexo']", visible: true, :match => :first).click
        find("[id*='ucAnexo_cmdAdiciona']").click
        sleep(5)
        if(tipoAnexo == "TermoOrgaoEmissor")
            anexo = "Termo assinado somente pelo órgão emissor"
        end

        if(tipoAnexo == "DisponivelAssinatura")
            anexo = "Termo assinado"
        end

        find("[name*='ddlTipoAnexo']").find(:option, anexo).text
        find("[name*='ddlTipoAnexo']").find(:option, anexo).select_option

        select(numTermoConvertido, :from => "ctl00$conteudo$TabNavegacao$TBTermo$sareTermo$TabNavegacaoTermo$TBAnexo$ucAnexo$ddlNumeroDoc")
        find("[id*='desConteudo']").set("Inserindo anexo pelo teste automatizado...")
        attach_file('ctl00$conteudo$TabNavegacao$TBTermo$sareTermo$TabNavegacaoTermo$TBAnexo$ucAnexo$fileUpload$ctl02', File.absolute_path('anexos/Teste.pdf'))
        find("[id*='ucAnexo_cmdAtualiza']").click
        Desenha.verificaPopUp
        sleep(3)
    end

    def SareTermos.SituacaoTermo
        find(:link, "Termo", visible: true, :match => :first).click
        find("[id*='TBSubTermos']", visible: true, :match => :first).click
        situacaoTermo = find("#ctl00_conteudo_TabNavegacao_TBTermo_sareTermo_TabNavegacaoTermo_TBSubTermos_gvPesquisa > tbody > tr.ModuloItem > td:nth-child(12)").text
        puts("Termo alterado para a situação: " + situacaoTermo)
    end
end