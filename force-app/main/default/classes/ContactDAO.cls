public with sharing class ContactDAO {
    private static ContactDAO instance = new ContactDAO();
    public static ContactDAO getInstance(){
        return instance;
    }

    public List<AggregateResult> buscarContas( Set<Id> setIdConta){
        //List<Account> lstAccContact = new List<Account>();
        // lstAccContact = [ SELECT id, QtdHomosexuais__c, (SELECT id FROM Contact WHERE Sexualidade__c = 'Homossexual')
        //                 FROM Account WHERE id IN :setIdConta];
        List<AggregateResult> lstAccContact = new List<AggregateResult>();
        lstAccContact = [SELECT count(id) qtd, AccountId 
            FROM Contact 
            WHERE Sexualidade__c = 'Homossexual' AND AccountId IN :setIdConta GROUP BY AccountId]; 
                
        return lstAccContact;
    }
}