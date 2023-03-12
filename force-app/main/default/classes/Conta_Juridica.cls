public with sharing class Conta_Juridica extends Conta_Bancaria {
    public Integer cnpj{get;set;}
    public Conta_Juridica() {
        tipoDeConta = 'Conta Juridica';
    }
}