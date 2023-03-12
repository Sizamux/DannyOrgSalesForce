public with sharing class ContactsCaseCallBatchSched implements Schedulable {
    public void execute(SchedulableContext ctx) {
        Contact lastContact =   [   SELECT Id
                                    FROM Contact
                                    ORDER BY CreatedDate DESC
                                    LIMIT 1
                                ];
        ContactsCaseBatch CtcsBatch = new ContactsCaseBatch(lastContact.Id);
        Id batchId = Database.executeBatch(CtcsBatch, 10);
        System.debug('batch id -'+ batchId);
    }
}