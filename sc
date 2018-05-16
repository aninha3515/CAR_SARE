
[1mFrom:[0m C:/Projetos/CAR_SARE/features/step_definitions/PreencheDados.rb @ line 4 InsereDados.inicio:

     [1;34m3[0m: 	[32mdef[0m [1;34;4mInsereDados[0m.[1;34minicio[0m(nomeCAR)
 =>  [1;34m4[0m: 		binding.pry
     [1;34m5[0m: 	find([31m[1;31m"[0m[31m[src='imagens/logo/CAR.png'][1;31m"[0m[31m[0m).click
     [1;34m6[0m: 	[1;34m#Validação para identificar se já possui CAR[0m
     [1;34m7[0m: 	[32mif[0m assert_text([31m[1;31m"[0m[31mCadastrar Nova Propriedade[1;31m"[0m[31m[0m)
     [1;34m8[0m: 		find([33m:link[0m, [31m[1;31m"[0m[31mCadastrar Nova Propriedade[1;31m"[0m[31m[0m).click
     [1;34m9[0m: 		puts([31m[1;31m"[0m[31mJá existe car para este usuário[1;31m"[0m[31m[0m)
    [1;34m10[0m: 	[32melse[0m
    [1;34m11[0m: 		puts([31m[1;31m"[0m[31mNão existe CAR para este usuário, criando seu primeiro CAR[1;31m"[0m[31m[0m)
    [1;34m12[0m: 	[32mend[0m
    [1;34m13[0m: 	[1;34m#fim da validação[0m
    [1;34m14[0m:     find([33m:id[0m, [31m[1;31m"[0m[31mctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBCadastro_carCadastro_rblTipo_0[1;31m"[0m[31m[0m).click
    [1;34m15[0m: 	find([33m:id[0m, [31m[1;31m"[0m[31mctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBCadastro_carCadastro_chkPropriedade_0[1;31m"[0m[31m[0m).click
    [1;34m16[0m: 	fill_in([31m[1;31m'[0m[31mctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$nomPropriedade[1;31m'[0m[31m[0m, [33m:with[0m => nomeCAR)
    [1;34m17[0m: 	fill_in([31m[1;31m'[0m[31mctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$desEndereco[1;31m'[0m[31m[0m, [33m:with[0m => [31m[1;31m"[0m[31mAv Professor Frederico Hermann JR[1;31m"[0m[31m[0m)
    [1;34m18[0m: 	fill_in([31m[1;31m'[0m[31mctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$nomBairro[1;31m'[0m[31m[0m, [33m:with[0m => [31m[1;31m"[0m[31mAlto de Pinheiros[1;31m"[0m[31m[0m)
    [1;34m19[0m: 	fill_in([31m[1;31m'[0m[31mctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$numCEP[1;31m'[0m[31m[0m, [33m:with[0m => [31m[1;31m"[0m[31m03259000[1;31m"[0m[31m[0m)
    [1;34m20[0m: 	select([31m[1;31m'[0m[31mILHABELA[1;31m'[0m[31m[0m, [33m:from[0m => [31m[1;31m'[0m[31mctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$ddlMunicipio[1;31m'[0m[31m[0m)
    [1;34m21[0m: 	fill_in([31m[1;31m'[0m[31mctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$numArea[1;31m'[0m[31m[0m, [33m:with[0m => [31m[1;31m"[0m[31m2702[1;31m"[0m[31m[0m)
    [1;34m22[0m: 	fill_in([31m[1;31m'[0m[31mctl00$conteudo$TabContainer1$TabPanel1$TabNavegacao$TBCadastro$carCadastro$area2008[1;31m'[0m[31m[0m, [33m:with[0m => [31m[1;31m"[0m[31m2702[1;31m"[0m[31m[0m)
    [1;34m23[0m: 	find([33m:id[0m, [31m[1;31m"[0m[31mctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBCadastro_carCadastro_chkAtividade_1[1;31m"[0m[31m[0m).click
    [1;34m24[0m: 	find([33m:id[0m, [31m[1;31m"[0m[31mctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBCadastro_carCadastro_rblQualificacao_0[1;31m"[0m[31m[0m).click
    [1;34m25[0m: 	find([33m:id[0m, [31m[1;31m"[0m[31mctl00_conteudo_TabContainer1_TabPanel1_TabNavegacao_TBCadastro_carCadastro_cmdAtualiza[1;31m"[0m[31m[0m).click
    [1;34m26[0m: [32mend[0m

