public with sharing class FicharioDAO {
    private static FicharioDAO instance = new FicharioDAO();
    public static FicharioDAO getInstance(){
        return instance;
    }

    public List<Fichario__c> buscaFichariosPorConta( Set<Id> setIdConta){
        List<Fichario__c> lstFicharios = new List<Fichario__c>();
        lstFicharios = [SELECT Account__c FROM Fichario__c WHERE Account__c IN :setIdConta];
        return lstFicharios;
    }
}