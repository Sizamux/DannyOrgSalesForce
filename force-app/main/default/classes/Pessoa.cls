public with sharing class Pessoa {
    public String nomeCompleto {get;set;}
    public Date dataDeNascimento {get;set;}
   
    public Pessoa(String pNomeCompleto, Date pDataDeNascimento){
        nomeCompleto = pNomeCompleto;
        dataDeNascimento = pDataDeNascimento;
    }
}