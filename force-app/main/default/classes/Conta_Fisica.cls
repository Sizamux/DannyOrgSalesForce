public with sharing class Conta_Fisica extends Conta_Bancaria {
    public Integer cpf{get;set;}
    public Conta_Fisica() {
        tipoDeConta = 'Conta Fisica';
    }
}