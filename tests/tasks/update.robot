*** Settings ***
Documentation            Cenário de testes de atualização de tarefas

Resource        ../../resources/base.resource

Test Setup        Start Session
Test Teardown     Take Screenshot

*** Test Cases ***
Deve poder marcar uma tarefa como concluida

    ${data}        Get fixtures    tasks    done

    Reset user from database    ${data}[user]

    Do login                    ${data}[user]

    Go to task form
    Submit task form    ${data}[task]

    Mark task as completed    ${data}[task][name]
    Task should be completed    ${data}[task][name]