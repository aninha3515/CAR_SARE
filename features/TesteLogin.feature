#language: pt
#utf-8

@validaLogin

Funcionalidade: Validar Login
Eu como usuario do sistema
Quero realizar tentativas de login
Para validar a segurança do Sistema

Esquema do Cenário: realizar login no sistema com usuários válidos
Dado que esteja na tela de login
Quando informar '<Usuario>' válido
E inserir '<Senha>' válida
Então o sistema deve permitir a autenticação do usuário

Exemplos:
|Usuario |Senha|
|edgaro  | a | 
|gtiadm  | a |

Esquema do Cenário: Tentar login no sistema com usuários inválidos
Dado que esteja na tela de login do sistema
Quando informar '<Usuario>' inválido
E inserir '<Senha>' inválida
Então o sistema não deve permitir a autenticação do usuário

Exemplos:
|Usuario |Senha|
|lucask  | a | 
|naianal | a |
