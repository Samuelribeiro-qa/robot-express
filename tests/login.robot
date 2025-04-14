*** Settings ***
Documentation        Cenários de autenticação de usuário

Library         Collections
Resource        ../resources/base.resource

Test Setup      Start Session
Test Teardown   Take Screenshot

*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado

    ${user}    Create Dictionary
    ...    name=Thiago Biano
    ...    email=bianoThiago@hotmail.com
    ...    password=pwd123
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Submit login form           ${user}
    User should be logged in    ${user}[name]

Não deve logar com senha inválida

    ${user}        Create Dictionary
    ...        name=Pedro Liz
    ...        email=Liz@msn.com
    ...        password=123456
    
    Remove user from database    ${user}[email]
    Insert user from database    ${user}

    Set To Dictionary    ${user}        password=098765

    Submit login form           ${user}
    Notice should be            Ocorreu um erro ao fazer login, verifique suas credenciais.