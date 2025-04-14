*** Settings ***
Documentation        Cenário de testes do cadastro do usuário

Resource        ../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuário

    ${user}            Create Dictionary
    ...        name=Eduardo Golçalo
    ...        email=Eduardogol@hotmail.com
    ...        password=pwd1234

    Remove user from database    ${user}[email]

    Go to signup page
    Submit signup form    ${user}
    Notice should be        Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Tags]    dup

    ${user}            Create Dictionary
    ...            name=Joao doido
    ...            email=doidojoao@hotmail.com
    ...            password=pwd1234

    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Go to signup page
    Submit signup form    ${user}
    Notice should be          Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios
    [Tags]    required

    ${user}        Create Dictionary
    ...            name=${EMPTY}
    ...            email=${EMPTY}
    ...            password=${EMPTY}

    Go to signup page
    Submit signup form    ${user}

    Alert should be        Informe seu nome completo
    Alert should be        Informe seu e-email
    Alert should be        Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com email incorreto
    [Tags]        doido

    ${user}        Create Dictionary
    ...            name=Pedro Gustavo
    ...            email=pedrogus.com.br
    ...            password=pwd123
    
    Go to signup page
    Submit signup form    ${user}
    Alert should be       Digite um e-mail válido

Não deve cadastrar com Senha muito curta
    [Tags]    temp

    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
    ${user}        Create Dictionary
    ...            name=pedro andre
    ...            email=pedroandre@hotmail.com
    ...            password=${password}

    Go to signup page
    Submit signup form    ${user}

    Alert should be        Informe uma senha com pelo menos 6 digitos
    END

Não deve cadastrar com a senha de 1 digito
    [Tags]    short_pass
    [Template]
    Short password    1

Não deve cadastrar com a senha de 2 digitos
    [Tags]    short_pass
    [Template]
    Short password    12

Não deve cadastrar com a senha de 3 digitos
    [Tags]    short_pass
    [Template]
    Short password    112

Não deve cadastrar com a senha de 4 digitos
    [Tags]    short_pass
    [Template]
    Short password    1234

Não deve cadastrar com a senha de 5 digitos
    [Tags]    short_pass
    [Template]
    Short password    12345

*** Keywords ***
Short password
    [Arguments]        ${short_pass}

    ${user}        Create Dictionary
    ...            name=pedro andre
    ...            email=pedroandre@hotmail.com
    ...            password=${short_pass}

    Go to signup page
    Submit signup form    ${user}

    Alert should be        Informe uma senha com pelo menos 6 digitos