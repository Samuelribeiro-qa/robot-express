*** Settings ***
Documentation        Ações e elementos do componentes de notificações

Library        Browser

*** Keywords ***
Notice should be
    [Arguments]        ${expected_text}

    ${elements}            Set Variable        css=.notice p

    Wait For Elements State    ${elements}        visible        5
    Get Text                   ${elements}        equal          ${expected_text}
