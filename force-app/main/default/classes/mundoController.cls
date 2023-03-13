public with sharing class mundoController {

    @AuraEnabled
    public static List<MundoTO> getMundos(){
        List<Mundo__c> mundoList = [SELECT Id, Name, Cor__c, PossuiAgua__c, QuantidadeLuas__c, Tamanho__c FROM Mundo__c];
        List<MundoTO> retMundoToList = new List<MundoTO>();
        for (Mundo__c mundoItem : mundoList) {
            MundoTO tempTo = new MundoTO();
            tempTo.id = mundoItem.Id;
            tempTo.nome = mundoItem.Name;
            tempTo.cor = mundoItem.Cor__c;
            tempTo.pAgua = mundoItem.PossuiAgua__c;
            tempTo.quantLuas = (Integer)mundoItem.QuantidadeLuas__c;
            tempTo.tamanho = (Integer)mundoItem.Tamanho__c;
            tempTo.selecionado = false;
            retMundoToList.add(tempTo);
        }
        return retMundoToList;
    }

    @AuraEnabled
    public static void deleteMundos(List<string> id){
        List<Mundo__c> mundoDelList = [SELECT Id FROM Mundo__c WHERE id IN :id];
        
        delete mundoDelList;
    }

    @AuraEnabled
    public static void setMundos(MundoTO mundoTo){
        Mundo__c newMundo = new Mundo__c();
        
        newMundo.Name = mundoTo.nome;
        newMundo.Cor__c = mundoTo.cor;
        newMundo.PossuiAgua__c = mundoTo.pAgua;
        newMundo.QuantidadeLuas__c = mundoTo.quantLuas;
        newMundo.Tamanho__c = mundoTo.tamanho;

        insert newMundo;
    }

    @AuraEnabled
    public static void setMundosV2(String nome, String cor, String pAgua, Integer quantLuas, Integer tamanho){      //v2
        Mundo__c newMundo = new Mundo__c();
        
        newMundo.Name = nome;
        newMundo.Cor__c = cor;
        newMundo.PossuiAgua__c = pAgua;
        newMundo.QuantidadeLuas__c = quantLuas;
        newMundo.Tamanho__c = tamanho;

        insert newMundo;
    }
    
    public Class MundoTO{
        @AuraEnabled public String id{get;set;}
        @AuraEnabled public String nome{get;set;}
        @AuraEnabled public String cor{get;set;}
        @AuraEnabled public String pAgua{get;set;}
        @AuraEnabled public Integer quantLuas{get;set;}
        @AuraEnabled public Integer tamanho{get;set;}
        @AuraEnabled public Boolean selecionado{get;set;}
    }

}