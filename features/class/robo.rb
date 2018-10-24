class ExecutaRobo
    def ExecutaRobo.SuspendeTermo
        linkRobo = "http://exec-dev01.sma.local/SMA-EST-CAR_test/WebServices/SareTermos.asmx"
        visit(linkRobo)
        find(:link, "Termo_Suspenso").click
        click_button("Invoke")
        sleep(5)
        VerificaAbas.fechaAbas
    end
end