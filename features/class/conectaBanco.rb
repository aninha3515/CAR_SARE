class ConectaBanco

require 'tiny_tds'

    def ConectaBanco.acesso
        @client = TinyTds::Client.new username: 'usrSigam', password: '@@S.m.a.1',
        host: 'db-dev01', port: 1433
        puts 'Connecting to SQL Server'
    end

    def ConectaBanco.consulta
        projeto = "25571"
        results = @client.execute("SELECT idTermo from [SMA-EST-CAR_test].dbo.[SARETERMO] where idProjeto = '#{projeto}'")  
        results.each do |linha|  
        puts linha  
        end
    end

    def ConectaBanco.alteraPrazoAssinatura(idProjeto)
        results = @client.execute("UPDATE [SMA-EST-CAR_test].dbo.[SARETERMO] set DatData = dateadd (dd, -2, DatData), datAssinatura = dateadd (dd, -3, datAssinatura) where idProjeto = '#{idProjeto}'")
        results.each do |linha|
        end
    end
end