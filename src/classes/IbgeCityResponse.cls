public with sharing class IbgeCityResponse {

    public Long id;
    public String nome;

    Municipio municipio;

    public class Municipio {

        Long id;
        String nome;

        MicrorRegiao microrregiao;
    
    }

    public class MicrorRegiao {

        Long id;
        String nome;
        Mesorregiao mesorregiao;

    }
    public class Mesorregiao {

        Long id;
        String nome;
        Estado UF;

    }

    public class Estado {
        Long id;
        String nome;
        String sigla;

        Regiao regiao;

    }

    public class Regiao {
        Long id;
        String nome;
        String sigla;
    }

}