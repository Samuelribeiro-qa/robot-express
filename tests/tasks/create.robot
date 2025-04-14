*** Settings ***
Documentation            Canários de cadastro de tarefas

Resource        ../../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa

    ${data}    Get fixtures    tasks    create

    Reset user from database    ${data}[user]

    Do login                    ${data}[user]

    Go to task form
    Submit task form    ${data}[task]
    Task should be registered        ${data}[task][name]

Não deve cadastrar tarefa com o nome duplicado
    [Tags]    dup

    ${data}    Get fixtures    tasks    duplicate

    # Dado que eu tenha um novo usuário
    
    Reset user from database    ${data}[user]

    #POST On Session    ${data}[user]
    #POST a new task    ${data}[task]

    # E que estou logado na aplicação web

    Do login                    ${data}[user]

    # E que o esse usuário já cadastrou uma tarefa

    Go to task form
    Submit task form    ${data}[task]

    # Quando tento cadastrar essa tarefa que já foi cadastrada

    Go to task form
    Submit task form    ${data}[task]

    # Então deve chegar uma notificação de tarefa duplicada

    Notice should be    Oops! Tarefa duplicada.

Não deve cadastrar uma nova tarefa quando atinge o limite de tags
    [Tags]    tags_limit

    ${data}    Get fixtures    tasks    tags_limit

    Reset user from database    ${data}[user]
    Do login                    ${data}[user]

    Go to task form
    Submit task form    ${data}[task]

    Notice should be    Oops! Limite de tags atingido.