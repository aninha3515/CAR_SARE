class RealizaLogin
	def RealizaLogin.acesso(usuario)
		find('.Login').click
		fill_in('username', :with => usuario)
		fill_in('password', :with => "a")
		find(:id, "login").click
		# analisar o trecho do código abaixo
		@EntraCAR = find(:id, "ctl00_lblNomPortal").text
			if @EntraCAR == "Centro de Monitoramento e Avaliação de Programas e Projeto"
			find(:id, "ctl00_lnkLogo").click
			end
	end
end

#usuarios
		#Usuario Externo = 55613853720
		#CAR Técnico = karinaac
		#SARE Técnica = renatam
		#SARE ADM = leilacm
		#find(:id, "ctl00_conteudo_ctl00_Panel1").click
		#03416907833 - usuario externo