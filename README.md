# Links 
---------------

Playlist - https://www.youtube.com/playlist?list=PLaPALzL4ps1AlVfYh5XGGuGTY7HP_K2d_


## Domain Driven Design



## Code Style


* Front - End


    function way ... 

    lwc 

        - alumni
            - builder
            - filter
            - ddd



* BackEnd 

    
    Ctrl
    > Classe controller independente do cenário, ela pode ser um rest controller 
    > aura, lwc controlller 

    >> Teste de Controller 100% mockado.

    Service
    > Utilizar classes de serviço para juntar dominios separados

    Repository
    > Classe de acesso a dados
    > * Dentro do repository pode ser utilizado o Criteria para queries dinamicas
    


    TriggerHandlers
    > Utilize a classe TriggerHandler como centralizador da logica da trigger
    > Ela tem um papel de delegação, evite lógicas nessa classe
    > Utilize de Classes de Enricher / Filter / Service para o processo de delegação

    Integração

        Inbound
        > Utilizar a classe AbstractInboundService para orquestrar o fluxo e criar um evento na Queue

        Outbound Síncrono
        > Utilizar a classe AbstractRestOutboundService para orquestrar o fluxo e envio da request http, lembrando que ela não persiste na Queue por default, necessário chamar o método publishEventLog()

        Outbound Assíncrono
        > Utilizar as classes AbstractUpdatableOutboundCommand, AbstractOutboundCommand para orquestrar o fluxo e envio da request http e persistir na Queue

        Cadeia de Eventos
        > Lembrando que não é possível ter chamada futura dentro de chamada futura
        então qnd vc esta dentro de uma chamada futura e necessita publicar um evento que o seu processamento seja imediato utilize o System.enqueueJob ( new EventExecutor (new EventQueue(...)) );

    Utilitarios

        Filter 

        ListHelper
        > Conversor de Listas 

        BrazilianDocument
        > Façade de Formatação/Validação para documentos CPF e CNPJ

        Criteria
        > Realizar Queries Dinâmincas

        StringHelper

        DateTimeHelper

        Random 
        > Utiliza-la em classes de teste para geração texto, valores numericos


















