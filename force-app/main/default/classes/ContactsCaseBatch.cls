public with sharing class ContactsCaseBatch  implements Database.Batchable<sObject>{
    Id lastCtct;
    //Construtor com recebendo ctct
    public ContactsCaseBatch (Id ctct){
        lastCtct = ctct;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator( [  SELECT Id
                                            FROM Case
                                            WHERE ContactId = NULL 
                                                AND CreatedDate >= : date.today().addDays(-5)
                                        ]);
    }
    
    public void execute(Database.BatchableContext bc, List<Case> caseList){
        // process each batch of records
        for(Case itemCase : caseList) {
            itemCase.ContactId = lastCtct;
        }
        if(!caseList.isEmpty()){
            update (caseList);
        }
    }
   
    public void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}