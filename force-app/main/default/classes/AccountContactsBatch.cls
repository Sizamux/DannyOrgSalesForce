public with sharing class AccountContactsBatch implements Database.Batchable<sObject>{

    public Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator( [  SELECT ID, BillingStreet, BillingCity, BillingState, BillingCountry,
                                                    BillingPostalCode, (SELECT ID, MailingStreet, MailingCity, 
                                                                            MailingState, MailingCountry, MailingPostalCode 
                                                                        FROM Contacts) 
                                            FROM Account
                                        ]);
    }
    
    public void execute(Database.BatchableContext bc, List<Account> accountList){
        // process each batch of records
        List<Contact> ctctsList = new List<Contact>();
        for(Account itemAcc : accountList) {
            If(itemAcc.Contacts.size()>=2){
                for(Contact itemCtcs : itemAcc.Contacts){
                    if(itemCtcs.MailingStreet != itemAcc.BillingStreet      &&
                        itemCtcs.MailingCity != itemAcc.BillingCity         &&
                        itemCtcs.MailingState != itemAcc.BillingState       &&
                        itemCtcs.MailingCountry != itemAcc.BillingCountry   &&
                        itemCtcs.MailingPostalCode != itemAcc.BillingPostalCode ){

                        itemCtcs.MailingStreet = itemAcc.BillingStreet;
                        itemCtcs.MailingCity = itemAcc.BillingCity;
                        itemCtcs.MailingState = itemAcc.BillingState;
                        itemCtcs.MailingCountry = itemAcc.BillingCountry;
                        itemCtcs.MailingPostalCode = itemAcc.BillingPostalCode;
                        ctctsList.add(itemCtcs);
                    }
                }
            }
        }
        if(!ctctsList.isEmpty()){
            update(ctctsList);
        }
    }
   
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}