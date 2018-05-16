Before do
puts("Iniciando os testes pelo código automatizado")
end

=begin
After do 
find(:id, "ctl00_cmdLogin").click
find(:link, "aqui").click
sleep(2)
puts("Deslogado com sucesso do ambiente!")
end
=end


After('@tira_print') do
    page.save_screenshot('log/shots/temp.png')
end