public with sharing class CloseCaseBatch implements Database.Batchable<SObject>{

    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([   SELECT Id 
                                            FROM Case 
                                            WHERE ContactId = null ]);
    }

    public void execute(Database.BatchableContext bc, List<Case> caseList){
        //int test;
    }

    public void finish(Database.BatchableContext bc){
        //int test;
    }


}