*** Settings ***
Documentation            Ações e elementos da página de cadastro de tarefas

Library        Browser

*** Keywords ***
Submit task form
    [Arguments]        ${task}

    Fill Text    css=input[placeholder$=tarefa]        ${task}[name]

    ${tags_elemet}            Set Variable        css=input[name=tags]

    FOR    ${tag}    IN    @{task}[tags]
        Fill Text     ${tags_elemet}        ${tag}
        Sleep         1
        Press Keys    ${tags_elemet}        Enter
    END


    Click    css=button >> text=Cadastrar

