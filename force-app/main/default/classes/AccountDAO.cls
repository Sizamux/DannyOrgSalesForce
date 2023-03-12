public with sharing class AccountDAO {
    private static AccountDAO instance = new AccountDAO();
    public static AccountDAO getInstance(){
        return instance;
    }

    public List<Account> buscarContas( Set<Id> setIdParent){
        List<Account> lstAcc = new List<Account>();
        lstAcc = [SELECT id, ContaDeMaiorFaturamento__c, ( SELECT Id, Faturamento__c FROM ChildAccounts) 
                    FROM Account 
                    WHERE Id IN :setIdParent];
        return lstAcc;
    }

    public List<Account> buscarContasMatrizComFilhos( Set<Id> setIdParent, Id filialRT, Id matrizRT){
        return [SELECT Id, QuantidadeContas__c, ( SELECT Id 
                                                    FROM ChildAccounts   
                                                    WHERE RecordTypeId = :filialRT ) 
                FROM Account 
                WHERE Id IN :setIdParent AND RecordTypeId = :matrizRT];
    }
}