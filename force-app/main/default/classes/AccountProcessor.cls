public with sharing class AccountProcessor {
    @future 
    public static void countContacts(List<Id> accountId){

        List<Account> accountsToUpdate = new List<account>();

        List<Account> AccWCtct = [SELECT Id, Number_Of_Contacts__c, (SELECT id 
                                                FROM Contacts)
                                    FROM Account
                                    WHERE Id in :accountId];
        
        for (Account acc : AccWCtct) {
            Integer count=0;
            for (Contact ctct : acc.Contacts) {
                count++;
            }
            acc.Number_Of_Contacts__c = count;
            accountsToUpdate.add(acc);
        }
        update accountsToUpdate;
    }
}