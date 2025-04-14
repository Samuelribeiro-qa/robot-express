*** Settings ***
Documentation            Cenário de testes de remoção de tarefas

Resource        ../../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder apagar um tarefa indesejada

    ${data}        Get fixtures    tasks    delete

    Reset user from database    ${data}[user]

    Do login                    ${data}[user]

    Go to task form
    Submit task form    ${data}[task]

    Request removal          ${data}[task][name]
    Task should not exist    ${data}[task][name]
