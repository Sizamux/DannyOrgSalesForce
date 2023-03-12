public with sharing class ClienteController {

    @AuraEnabled
    public static void inserirCliente(ClienteTo clienteTo){
        Cliente__c novoCliente = new Cliente__c();
        Id cliPf = Schema.SObjectType.Cliente__c.getRecordTypeInfosByName().get('ClientePF').getRecordTypeId();
        Id cliPj = Schema.SObjectType.Cliente__c.getRecordTypeInfosByName().get('ClientePJ').getRecordTypeId();

        novoCliente.Name = clienteTo.nome;
        novoCliente.CPF__c = clienteTo.cpf;
        novoCliente.CNPJ__c = clienteTo.cnpj;

        String tipoDeRocord = clienteTo.recordType;
        
        cliPjBool = false;
        cliPfBool = false;

        if(tipoDeRocord == 'Pf'){
            novoCliente.RecordTypeId = cliPf;
        }else if(tipoDeRocord == 'Pj'){
            novoCliente.RecordTypeId = cliPj;
        }
        system.debug(novoCliente);
        insert novoCliente;
    }
   
    public Class ClienteTo{
        @AuraEnabled public String nome{get;set;}
        @AuraEnabled public String cnpj{get;set;}
        @AuraEnabled public String cpf{get;set;}
        @AuraEnabled public String recordType{get;set;}
    }
}